#!/bin/sh

# Parsing arguments
while [ $# != "0" ]; do
    case $1 in
        "?"|"-h"|"-help"|"--help")
            prog=`basename $0`
            echo "Usage: $0 [-pricer pricername]"
            exit
            ;;

        "-pricer")
            shift
            #Pricer name argument
            PRICER_ARG="-pricer $1 "
            ;;
        *)
            prog=`basename $0`
            echo "Usage: $0 [-pricer pricername] [-debug] [-distributed]"
            exit
            ;;
    esac
    shift;
done

# Init command
GREP=/bin/grep
SED=/bin/sed
CUT=/bin/cut
PS=
PSARGS="auxwwww"
MACHINE=`uname -s`
case "$MACHINE" in
    "SunOS")
        PS="/usr/ucb/ps"
        ;;
    "Linux")
        PS="/bin/ps"
        ;;
    *)
        echo "[ERROR] Cannot guess your machine $MACHINE"
        exit 1
esac

if [ ! -x $PS ]; then
    echo "[ERROR] The mandatory command '$PS' is missing in your env => Cannot stop the Groovy RV Pricing Server!"
    exit 1
fi

# Find the Groovy Rendez-Vous Pricer pid
GROOVY_PID=`$PS $PSARGS | $GREP "com.reuters.ksp.groovyrvpricer.KSPGroovyRVPricingServer -daemon tcp:kplus-front-rvd:7500 -service 6659 ${PRICER_ARG}" | $GREP -v grep | $SED 's/  */ /g' | $SED 's/^ //' | $CUT -d ' ' -f 2`
if [ $? -ne 0 ]; then
    echo "[ERROR] Failed to retrieve the Groovy RV Pricer pid!"
    exit 1
fi

# Kill the Groovy RV Pricer pid
if [ -z "$GROOVY_PID" ]; then
    echo "[WARNING] The Groovy RV Pricing Server is not running!"
else
    kill -9 $GROOVY_PID > /dev/null 2>&1
    if [ "$?" -ne 0 ]; then
        echo "[ERROR] Failed to kill the Groovy RV Pricing Server!"
        exit 1
    fi
    echo "[INFO] The Groovy RV Pricing Server has been stopped."
    exit 0
fi
