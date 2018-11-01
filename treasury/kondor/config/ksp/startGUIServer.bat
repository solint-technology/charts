:: KSP GUI startup script for kzones

call commonGUIServer.bat

:: JVM parameters
set CATALINA_OPTS=%JAVA_MEMORY_OPTS%
set CATALINA_OPTS=%CATALINA_OPTS% -Dlog4j.configuration=file:%APPLICATION_CONF%\\log4j.lcf
set CATALINA_OPTS=%CATALINA_OPTS% -Djava.awt.headless=true
set CATALINA_OPTS=%CATALINA_OPTS% -Dapplication.property.dir=%APPLICATION_CONF%
set CATALINA_OPTS=%CATALINA_OPTS% -Dksp.logging.dir=C:\Program Files\Reuters\Kplus30\entities\Standalone\log\ksp\
set CATALINA_OPTS=%CATALINA_OPTS% -Dksp.logging.level=WARN
set CATALINA_OPTS=%CATALINA_OPTS% -Dksp.logging.console.threshold=OFF
set CATALINA_OPTS=%CATALINA_OPTS% 
set CATALINA_OPTS=%CATALINA_OPTS% %JAVA_OPTIONS%

::-------------------------------------------------------------------------------------------------

:: Clean Catalina cache directories
rmdir /S /Q %CATALINA_BASE%\tmp
mkdir %CATALINA_BASE%\tmp
rmdir /S /Q %CATALINA_BASE%\work

:: Launch KSP GUI
call %CATALINA_HOME%\bin\catalina.bat run
