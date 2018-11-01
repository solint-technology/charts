:: @ECHO off

CALL commonGUIServer.bat

SET JRE_HOME=%JAVA_HOME%\jre

SET JVM=%JRE_HOME%\bin\server\jvm.dll
IF EXIST "%JVM%" GOTO JVMSET
SET JVM=%JRE_HOME%\bin\client\jvm.dll
IF EXIST "%JVM%" GOTO JVMSET

ECHO "JVM.DLL not found. Cannot install service."
GOTO EXITERROR

:JVMSET

SET CLASSPATH=%CATALINA_HOME%\bin\bootstrap.jar;\lib\jms-2.0.jar;\lib\tibjms.jar;C:\Program Files\Reuters\Kplus30\lib\ext\java\log4j-1.2.16.jar;%CATALINA_HOME%\bin\tomcat-juli.jar

set JAVA_OPTS=-XX:MaxPermSize=256m;-Dcatalina.home=%CATALINA_HOME%;-Dcatalina.base=%CATALINA_BASE%;-Dlog4j.configuration=file:%APPLICATION_CONF%\\log4j.lcf;-Djava.awt.headless=true;-Dapplication.property.dir=%APPLICATION_CONF%;-Dksp.logging.dir=C:\Program Files\Reuters\Kplus30\entities\Standalone\log\ksp\;-Dksp.logging.level=WARN;-Dksp.logging.console.threshold=OFF;

"%CATALINA_HOME%\bin\tomcat8.exe" "//IS//%SERVICE_NAME%" ^
    --DisplayName "%SERVICE_DISPLAYNAME%" ^
    --Description "%SERVICE_DESCRIPTION%" ^
    --Install "%CATALINA_HOME%\bin\tomcat8.exe" ^
    --LogPath "C:\Program Files\Reuters\Kplus30\entities\Standalone\log\ksp\" ^
    --StdOutput "%CATALINA_OUT%" ^
    --StdError "%CATALINA_OUT%" ^
    --Classpath "%CLASSPATH%" ^
    --Jvm "%JVM%" ^
    --StartMode jvm ^
    --StopMode jvm ^
    --StartPath "%CATALINA_HOME%" ^
    --StopPath "%CATALINA_HOME%" ^
    --StartClass org.apache.catalina.startup.Bootstrap ^
    --StopClass org.apache.catalina.startup.Bootstrap ^
    --StartParams start ^
    --StopParams stop ^
    --JvmOptions "%JAVA_OPTS%" ^
    --JvmMs 256m ^
    --JvmMx 1024m
	
EXIT 0
	
:EXITERROR
PAUSE
EXIT 1
