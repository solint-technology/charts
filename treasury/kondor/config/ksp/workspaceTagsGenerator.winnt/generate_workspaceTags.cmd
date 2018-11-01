@echo off
setlocal

set CLASSPATH=C:\Program Files\Reuters\Kplus30\ksp\workspaceTagsGenerator\ksp-workspacetags-generator.jar
set LOG_PROPERTIES_FILE=C:\Program Files\Reuters\Kplus30\entities\Standalone\config\ksp\workspaceTagsGenerator.winnt\log4j.lcf
set SETTINGS_PROPERTIES_FILE=C:\Program Files\Reuters\Kplus30\entities\Standalone\config\ksp\workspaceTagsGenerator.winnt\settings.properties
set JAVA_HOME="C:\Program Files\Java\jdk1.8.0_60"

%JAVA_HOME%\bin\java.exe -version
%JAVA_HOME%\bin\java.exe -Xmx512M -Djava.util.logging.config.file=%LOG_PROPERTIES_FILE% -cp %CLASSPATH% com.trmsys.ksp.dbmigration.MigrationUtility %SETTINGS_PROPERTIES_FILE% %*

endlocal
