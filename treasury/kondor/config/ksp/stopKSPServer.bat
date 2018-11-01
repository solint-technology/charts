:: KSPServer shutdown script for kzones

:: K+ Home path
set KPLUSHOME3=C:\Program Files\Reuters\Kplus30
:: KSP Config directory
set KSP_CONFIG_DIR=%KPLUSHOME3%\entities\Standalone\config\ksp

set /p KSPSERVER_PID=<%KSP_CONFIG_DIR%\KSPServer.pid
TSKILL  %KSPSERVER_PID%
