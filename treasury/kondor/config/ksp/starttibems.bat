:: TIBCO EMS startup script for kzones

:: Set TIBCO EMS installation path
set TIBEMS_PATH=
:: KSP Log directory
set KSP_LOG_DIR=C:\Program Files\Reuters\Kplus30\entities\Standalone\log\ksp

cd %TIBEMS_PATH%\bin
md C:\Program Files\Reuters\Kplus30\entities\Standalone\config\ksp\jms.winnt\datastore
md %KSP_LOG_DIR%\ems

call %TIBEMS_PATH%\bin\tibemsd -config C:\Program Files\Reuters\Kplus30\entities\Standalone\config\ksp\jms.winnt\tibemsd.conf
