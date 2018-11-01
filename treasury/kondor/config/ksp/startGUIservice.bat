@ECHO OFF

CALL commonGUIServer.bat

sc start "%SERVICE_NAME%"
