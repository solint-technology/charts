#!/bin/bash
# Reuse DISPLAY calculation method from dockerExec.sh script of treasury-compose


Debug()
{
    if [ "$GLOBAL_PARAM_DEBUG" != "" ]; then
        echo -e "DEBUG: `hostname`: $1"
    fi
}

CalculateParameterDisplayWithIpAddrShow()
{
    Debug "Found ip addresse(s)(with ip addr show):\n`ip -oneline -4 addr show | cut -d/ -f1 | awk '{print $2 " " $4}' \
          | grep -v 'docker'        \
          | grep -v 'lo '           \
          | grep -v 'virbr'         \
          | grep -v 'br-'           \
          | grep -v '127.0.0.1'`"
    GLOBAL_PARAM_IPADDRESS=`ip -oneline -4 addr show | cut -d/ -f1 | awk '{print $2 "#" $4}' \
          | grep -v 'docker'        \
          | grep -v 'lo '           \
          | grep -v 'virbr'         \
          | grep -v 'br-'           \
          | grep -v '127.0.0.1'     \
          | cut -d# -f2`
}

CalculateParameterDisplayWithIfconfig()
{
    # Finds path to ifconfig
    ifconfigPath="ifconfig"
    $ifconfigPath -a > /dev/null 2> /dev/null
    if [ $? -ne 0 ]; then
        ifconfigPath="/sbin/ifconfig"
        $ifconfigPath -a > /dev/null 2> /dev/null
        if [ $? -ne 0 ]; then
            ifconfigPath="/usr/sbin/ifconfig"
            $ifconfigPath -a > /dev/null 2> /dev/null
            if [ $? -ne 0 ]; then
                echo "Failed to execute ifconfig, /sbin/ifconfig and /usr/sbin/ifconfig"
                exit 1
            fi
        fi
    fi
    Debug "ifconfigPath=$ifconfigPath"

    # Determine if ifconfig is in the format "inet addr" or "inet"
    inetAddrFormat=`$ifconfigPath -a | grep "inet addr"`
    Debug "inetAddrFormat=$inetAddrFormat"
    if [ "$inetAddrFormat" = "" ]; then
        # Solaris kzone:
        #   lo0:7: flags=2001000849<UP,LOOPBACK,RUNNING,MULTICAST,IPv4,VIRTUAL> mtu 8232 index 1
        #          inet 127.0.0.1 netmask ff000000
        #   igb0:7: flags=1000843<UP,BROADCAST,RUNNING,MULTICAST,IPv4> mtu 1500 index 2
        #           inet 150.151.179.122 netmask ffff0000 broadcast 150.151.255.255
        # New kworkstation:
        #   eth2: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        #           inet 10.25.30.170  netmask 255.255.254.0  broadcast 10.25.31.255
        #           inet6 fe80::6ee5:e75:7aed:390e  prefixlen 64  scopeid 0x20<link>
        Debug "Found ip addresse(s)(with ipconfig inet):\n`ifconfig -a \
          | awk -F: '/^[^ ]/ { desc=$1; } /^ *inet / { print desc $0; }' \
          | grep -v '^docker'                                            \
          | grep -v '^lo '                                               \
          | grep -v '^virbr'                                             \
          | grep -v '^br-'                                               \
          | grep -v '127.0.0.1'`"
        GLOBAL_PARAM_IPADDRESS=`ifconfig -a \
          | awk -F: '/^[^ ]/ { desc=$1; } /^ *inet / { print desc $0; }' \
          | grep -v '^docker'                                            \
          | grep -v '^lo '                                               \
          | grep -v '^virbr'                                             \
          | grep -v '^br-'                                               \
          | grep -v '127.0.0.1'                                          \
          | sed 's/.*inet \([0-9.]*\).*/\1/'`
    else
        # Linux kzone:
        #   eth1      Link encap:Ethernet  HWaddr 02:42:0A:15:39:80
        #             inet addr:10.21.57.128  Bcast:0.0.0.0  Mask:255.255.254.0
        #             inet6 addr: fe80::42:aff:fe15:3980/64 Scope:Link
        # Old kworkstation:
        #   eth0      Link encap:Ethernet  HWaddr 90:b1:1c:6a:d6:cc
        #             inet addr:10.25.31.44  Bcast:10.25.31.255  Mask:255.255.254.0
        Debug "Found ip addresse(s)(with ipconfig inet addr):\n`ifconfig -a \
          | awk -F: '/^[^ ]/ { desc=$1; } /^ *inet addr/ { print desc $0; }' \
          | grep -v '^docker'                                                \
          | grep -v '^lo '                                                   \
          | grep -v '^virbr'                                                 \
          | grep -v '^br-'                                                   \
          | grep -v '127.0.0.1'`"
        GLOBAL_PARAM_IPADDRESS=`ifconfig -a \
          | awk -F: '/^[^ ]/ { desc=$1; } /^ *inet addr/ { print desc $0; }' \
          | grep -v '^docker'                                                \
          | grep -v '^lo '                                                   \
          | grep -v '^virbr'                                                 \
          | grep -v '^br-'                                                   \
          | grep -v '127.0.0.1'                                              \
          | sed 's/.*inet addr:\([0-9.]*\).*/\1/'`
    fi
}

CalculateParameterDisplay()
{
    # CalculateParameterDisplay() finds the main ip address of current machine
    # input:  none
    # output: $GLOBAL_PARAM_IPADDRESS $GLOBAL_PARAM_DISPLAY

    ip -o -4 addr show > /dev/null 2> /dev/null
    if [ $? -eq 0 ]; then
        CalculateParameterDisplayWithIpAddrShow
    else
        CalculateParameterDisplayWithIfconfig
    fi
    if [ `echo -e "$GLOBAL_PARAM_IPADDRESS" | wc -l` != "1" ]; then
        Error "A bug occurred during ipaddress retrieval\n    Please send a mail to christophe.streissel with the output of dockerShell.sh --verbose XXX\n    Then try to use --display"
    else
        GLOBAL_PARAM_DISPLAY=$GLOBAL_PARAM_IPADDRESS:$GLOBAL_PARAM_DISPLAY_PORT
    fi
}

GLOBAL_PARAM_DISPLAY=""
GLOBAL_PARAM_DISPLAY_PORT="0"

if [ "$GLOBAL_PARAM_DISPLAY" == "" ]; then
    # We are on a physical machine with a screen => call ifconfig
    CalculateParameterDisplay
fi

docker run -it \
 -v ${PWD}/config/:/opt/finastra/kplus-front//entities/Standalone/config:rw \
 --add-host fr1pslbmc04:10.21.16.175 \
 --add-host elsd-1-2110:10.22.180.198 \
 registry.misys.global.ad/treasury-optimisation/kplus-front:3.4.7.020.011-25731f3-20180913T021020 \
 bash -c "export DISPLAY=$GLOBAL_PARAM_DISPLAY ; DealManager -Ukplus -PKondor_123"
