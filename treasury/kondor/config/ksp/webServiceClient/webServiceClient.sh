#!/bin/bash
export CLASSPATH=/opt/finastra/kplus-front/ksp/webServiceClient/ksp-wsclient.jar

# Check command syntax
if [ "$#" -ne 1 ]; then
    echo "KSP Webservice Client"
    echo "Syntax: webServiceClient.sh <inputFile>"
    echo ""
    echo "<inputFile>                    a valid properties file containing the client configuration"
    echo ""
    echo "Allowed params in the properties file:"
    echo "service.url                    the url to the webservice WSDL"
    echo "service.username               the username for KSP server"
    echo "service.password               the password for KSP server"
    echo "service.timeout.connection     (optional) service connection timeout in ms, default is 30000"
    echo "service.timeout.receive        (optional) service response timeout in ms, default is 180000"
    echo ""
    echo "service.action                 the service method to call, supported methods are [list, execute, content]"
    echo ""
    echo "template.name                  the name of the template for execute and content actions"
    echo "template.param.KEY=VALUE       allows setting up template parameters for the execute action"
    echo ""
    echo "session.id                     [execute action only] allows executing the template in a session, with the given session id"
    echo "session.closeAtEnd             [execute action only, requires specifying a session.id] closes the session after executing the template if 'true'"
    echo "session.resetMask              [execute action only, requires specifying a session.id] resets the application after executing the template if 'true'"
    echo ""
    echo "output.file                    the file to write the output of the call, default is output.xml"
    exit 1
fi

# Set the JAVA_HOME variable
MACHINE=`uname -s`
case "$MACHINE" in
    "SunOS")
        MACHINE_ARCH=`uname -p`
        case "$MACHINE_ARCH" in
           "sparc")
              export JAVA_HOME=/opt/jdk1.8.0_60
           ;;
           "i386")
              export JAVA_HOME=/opt/jdk1.8.0_60
           ;;
           *)
              echo "[ERROR] Unsupported machine architecture: $MACHINE_ARCH"
              exit -1
        esac
    ;;
    "Linux")
        export JAVA_HOME=/usr/java/latest/jre
    ;;
    *)
        echo "[ERROR] Unsupported operating system: $MACHINE"
        exit -1
esac

# Launch KSP Webservice client
$JAVA_HOME/bin/java -cp $CLASSPATH com.reuters.ksp.wsclient.WSClient $*
