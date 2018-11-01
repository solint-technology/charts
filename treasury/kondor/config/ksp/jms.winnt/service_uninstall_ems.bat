@ECHO OFF

IF "%TIBEMS_PATH%"=="" (SET TIBEMS_PATH=)

CALL "%TIBEMS_PATH%\bin\emsntsrg.exe" /r tibemsd "for Kondor KSP"

