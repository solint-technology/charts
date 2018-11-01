@ECHO OFF

IF "%TIBEMS_PATH%"=="" (SET TIBEMS_PATH=)

CALL "%TIBEMS_PATH%\bin\emsntsrg.exe" /i /a tibemsd "%TIBEMS_PATH%\bin" "%TIBEMS_PATH%\bin" "-config C:\Program Files\Reuters\Kplus30\entities\Standalone\config\ksp\jms.winnt\tibemsd.conf" "for Kondor KSP"

