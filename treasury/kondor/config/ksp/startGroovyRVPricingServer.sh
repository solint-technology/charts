#!/bin/sh

# Parsing arguments
while [ $# != "0" ]; do
    case $1 in
        "?"|"-h"|"-help"|"--help")
            prog=`basename $0`
            echo "Usage: $0 [-pricer pricername] [-debug] [-distributed]"
            exit
            ;;

        "-debug")
            DEBUG_ARG="-debug"
            ;;

        "-distributed")
            DISTRIBUTED_ARG="-distributed"
            ;;

        "-pricer")
            shift
            #Pricer name argument
            PRICER_ARG="-pricer $1"
            ;;
    	*)
            prog=`basename $0`
            echo "Usage: $0 [-pricer pricername] [-debug] [-distributed]"
            exit
			;;
    esac
    shift;
done

#Kplus home installation path
KPLUSHOME3=/opt/finastra/kplus-front

#The JAVA home installation path
JAVA_HOME=/usr/java/latest/jre

# JAVA library path and system LD_LIBRARY_PATH
if [ -z "$ARCH" ]; then
    echo ""
    echo "ERROR: environment variable ARCH must be set."
    echo ""
    exit 1 
fi
JAVA_LIBRARY_PATH=${KPLUSHOME3}/lib64/ext/${ARCH}
unset LD_LIBRARY_PATH_64
LD_LIBRARY_PATH=${JAVA_LIBRARY_PATH}:${LD_LIBRARY_PATH}
export LD_LIBRARY_PATH

#Path to the Groovy RV Pricing Server jar and its dependencies
CLASSPATH=${KPLUSHOME3}/ksp/GroovyDependencies/ksp-groovy-rv-pricer.jar:${KPLUSHOME3}/lib/ext/java/tibrv-8.4.4.jar

# JVM options
JVM_OPTS="-d64"

#Start the Groovy RV Pricing Server
${JAVA_HOME}/bin/java ${JVM_OPTS} -Djava.library.path=${JAVA_LIBRARY_PATH} -classpath $CLASSPATH \
com.reuters.ksp.groovyrvpricer.KSPGroovyRVPricingServer \
-daemon tcp:kplus-front-rvd:7500 -service 6659 ${PRICER_ARG} -network "eth0;;" ${DEBUG_ARG} ${DISTRIBUTED_ARG}
