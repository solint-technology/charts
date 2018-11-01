@ECHO OFF

CALL commonGUIServer.bat

SET CLASSPATH=%CATALINA_HOME%\bin\bootstrap.jar;\lib\jms-2.0.jar;\lib\tibjms.jar;C:\Program Files\Reuters\Kplus30\lib\ext\java\log4j-1.2.16.jar;%CATALINA_HOME%\bin\tomcat-juli.jar

"%CATALINA_HOME%\bin\tomcat8.exe" "//DS//%SERVICE_NAME%" 
