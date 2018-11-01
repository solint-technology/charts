#!/bin/ksh

FG_MODE=0
PARAM_DEBUG=""
PARAM_DEBUG_PORT="8585"

while test $# -gt 0
do
    case "$1" in
        -foreground|-fg) FG_MODE=1
            ;;
        -debug|--debug)
            PARAM_DEBUG=1
            ;;
        -debugport|--debugport)
            shift
            PARAM_DEBUG_PORT="$1"
            ;;
        -*) echo "Unknown option $1"
            exit 1
            ;;
    esac
    shift
done

. /opt/finastra/kplus-front/entities/Standalone/config/ksp/commonGUIServer.sh

export CATALINA_OPTS="$JAVA_MEMORY_OPTS"
export CATALINA_OPTS="$CATALINA_OPTS -Dlog4j.configuration=file:$APPLICATION_CONF/log4j.lcf"
export CATALINA_OPTS="$CATALINA_OPTS -Djava.awt.headless=true"
export CATALINA_OPTS="$CATALINA_OPTS -Dapplication.property.dir=$APPLICATION_CONF"
export CATALINA_OPTS="$CATALINA_OPTS -Dksp.logging.dir=/opt/finastra/kplus-front/entities/Standalone/log/ksp/"
export CATALINA_OPTS="$CATALINA_OPTS -Dksp.logging.level=WARN"
export CATALINA_OPTS="$CATALINA_OPTS -Dksp.logging.console.threshold=OFF"
export CATALINA_OPTS="$CATALINA_OPTS "
export CATALINA_OPTS="$CATALINA_OPTS $JAVA_OPTIONS"
if [ "$PARAM_DEBUG" != "" ]
then
    CATALINA_OPTS="$CATALINA_OPTS -Xdebug -Xrunjdwp:transport=dt_socket,address=$PARAM_DEBUG_PORT,server=y,suspend=n"
    echo "KSP UI debug activated on port $PARAM_DEBUG_PORT"
fi

#############
# CLEANNING #
#############
/bin/rm -rf $CATALINA_BASE/tmp
/bin/rm -rf $CATALINA_BASE/work
/bin/mkdir -p $CATALINA_TMPDIR

#########
# START #
#########
if [ $FG_MODE -eq 1 ]; then
    $CATALINA_HOME/bin/catalina.sh run
else
    $CATALINA_HOME/bin/catalina.sh start
fi

# DEBUG : comment the regular START command above
#export JPDA_ADDRESS="7708"
#$CATALINA_HOME/bin/catalina.sh jpda start

