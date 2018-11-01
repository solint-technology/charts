@ECHO OFF

CALL commonGUIServer.bat

sc stop "%SERVICE_NAME%"
