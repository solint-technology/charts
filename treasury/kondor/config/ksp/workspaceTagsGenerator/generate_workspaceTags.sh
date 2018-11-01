#!/bin/bash
export CLASSPATH=/opt/finastra/kplus-front/ksp/workspaceTagsGenerator/ksp-workspacetags-generator.jar
export LOG_PROPERTIES_FILE=/opt/finastra/kplus-front/entities/Standalone/config/ksp/workspaceTagsGenerator/log4j.lcf
export SETTINGS_PROPERTIES_FILE=/opt/finastra/kplus-front/entities/Standalone/config/ksp/workspaceTagsGenerator/settings.properties

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

$JAVA_HOME/bin/java -version
$JAVA_HOME/bin/java -Xmx512M -Djava.util.logging.config.file=$LOG_PROPERTIES_FILE -cp $CLASSPATH com.trmsys.ksp.dbmigration.MigrationUtility $SETTINGS_PROPERTIES_FILE $*
