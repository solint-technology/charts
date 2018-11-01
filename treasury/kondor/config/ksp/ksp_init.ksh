#!/bin/ksh
# This script is called by startksrv (after calling ksp_env.ksh) to set 5 variables (NAME,PID_DIR,LOG_DIR,PARAMS,NOKILL) before starting a ksp binary

# Check it has been sourced
[ "${NAME##*/}" = "common_ksp.ksh" ] && echo "ERROR: Please use startksrv/killksrv to control ksp process" && exit 1

Init_Ksp() {
    NAME=$1
    shift

    case $NAME in
        ksp_server|kspserver|KSPServer)
            echo $NAME$*
            NAME=$KSP_HOME_DIR/servers/$ARCH/KSPServer

            Init_KspServer

            PARAMS="-c $KSP_CONFIG_FILE -pid-file KSPServer.pid --configDir ${KSP_CONFIG_DIR} -disableAutomaticRestart"
            
            #TODO: check if we still need to change the current folder to load the xsd
            cd $KSP_HOME_DIR/common/ksp/xsd
            ;;
        ksp_ems|kspems)
            echo $NAME$*
            NAME=$TIBEMS_DIR/bin/tibemsd

            Init_EmsServer

            PARAMS="-config $KSP_CONFIG_DIR/jms/tibemsd.conf"

            #TODO: check if we still need to change the current folder to create durable.conf
            #(we should add durables=$V(KSP_CONFIG_DIR)/jms/durables.conf in tibemsd.conf)
            cd $KSP_CONFIG_DIR/3rdparty/jms/conf/
            ;;
        ksp_web|kspweb|ksp_gui|kspgui)
            echo "'startksrv <entity> ksp_web' is not yet implemented."
            echo "please use $KSP_CONFIG_DIR/startGUIServer.sh"
            echo "then       $KSP_CONFIG_DIR/stopGUIServer.sh"
            exit 1
            ;;
        all_ksp)
            $0 $FOREVER $NOKILL $ENTITY ksp_ems "$@"
            $0 $FOREVER $NOKILL $ENTITY ksp_server "$@"
            $0 $FOREVER $NOKILL $ENTITY ksp_web "$@"
            exit 0
            ;;
       ksp|KSP)
            echo "Available targets for KSP are: ksp_ems, ksp_server, ksp_web, all_ksp"
            exit 1
            ;;
       *)
            echo "$NAME is an unknown KSP target. Available targets are: ksp_ems, ksp_server, ksp_web, ksp_all"
            exit 1
            ;;
    esac

    PID_DIR=$KSP_CONFIG_DIR/pid
    LOG_DIR=$KSP_CONFIG_DIR/log
}

Init_EmsServer() {
    #TODO: Path to datastore should be changed here + in packaging\structure\3rdparty\jms\conf\tibemsd.conf.default to point in KSP_CONFIG_DIR
    mkdir -p $KSP_CONFIG_DIR/jms/datastore > /dev/null 2>&1
    mkdir -p $KSP_LOG_DIR/ems > /dev/null 2>&1
}

Init_KspServer() {
    #TODO: in case $FOREVER=forever is set we need to set KSP_DISABLE_AUTO_RESTART=yes

    KSP_CONFIG_FILE=${KSP_CONFIG_DIR}/Config.tsv
}
