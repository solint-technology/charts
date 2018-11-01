:: KSPServer startup script for kzones

:: KZone specific variables

:: Generic variables

:: Architecture
set ARCH=win
:: K+ Home path
set KPLUSHOME3=C:\Program Files\Reuters\Kplus30
:: PATH
set PATH=%KPLUSHOME3%\lib64\ext\%ARCH%;%KPLUSHOME3%\lib64\int\%ARCH%;%KPLUSHOME3%\lib\ext\%ARCH%;%KPLUSHOME3%\lib\int\%ARCH%
:: KSP Config directory
set KSP_CONFIG_DIR=%KPLUSHOME3%\entities\Standalone\config\ksp
:: KSP Log directory
set KSP_LOG_DIR=C:\Program Files\Reuters\Kplus30\entities\Standalone\log\ksp
:: Groovy pricing
set GROOVY_CLASS_PATH=C:\Program Files\Reuters\Kplus30\ksp\GroovyDependencies\
set GROOVY_JVM_XMS=-Xms1024M
set GROOVY_JVM_XMX=-Xmx1024M
:: Set RV Config for KSP RVWrapper
set KSP_WRAPPER_SERVICE=6659
set KSP_WRAPPER_NETWORK=eth0;;
set KSP_WRAPPER_DAEMON=tcp:kplus-front-rvd:7500
:: KSPServer configuration
set KSP_DISABLE_AUTO_RESTART=yes
:: Numerix License directory
set NX_LICENSE_DIR=\floating

::-------------------------------------------------------------------------------------------------

:: SYBASE path
set SYBASE=P:\sybase\kplus
:: K+ Admin file
set KPADMINFILE=%KPLUSHOME3%\entities\Standalone\config\.kpadminfile.passwords

::-------------------------------------------------------------------------------------------------

:: Launch KSPServer.exe
call %KPLUSHOME3%\servers\%ARCH%\KSPServer.exe -c %KSP_CONFIG_DIR%\Config.tsv -pid-file KSPServer.pid --configDir %KSP_CONFIG_DIR% < %KPADMINFILE% > %KSP_LOG_DIR%\KSPServer.log
