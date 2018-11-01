:: KSP GUI shutdown script for kzones

call commonGUIServer.bat

::-------------------------------------------------------------------------------------------------

:: Shutdown KSP GUI
call %CATALINA_HOME%\bin\catalina.bat stop
