:: KSP GUI Common parameters

:: KZone specific variables

:: JAVA HOME path
set JAVA_HOME=C:\Program Files\Java\jdk1.8.0_60

::-------------------------------------------------------------------------------------------------

:: Generic variables
set SERVICE_NAME=kplus_ksp_webui
set SERVICE_DISPLAYNAME=Kondor KSP Web UI Service
set SERVICE_DESCRIPTION=Kondor KSP Tomcat service. If this service is stopped, Kondor KSP Website will not be accessible

:: Tomcat configuration
set CATALINA_HOME=C:\Program Files\Tomcat
set CATALINA_BASE=C:\Program Files\Reuters\Kplus30\entities\Standalone\config\ksp\appliserver.winnt
set APPLICATION_CONF=C:\Program Files\Reuters\Kplus30\entities\Standalone\config\ksp\webconf.winnt
set CATALINA_TMPDIR=%CATALINA_BASE%\tmp
set CATALINA_PID=%CATALINA_BASE%\guiServer.pid
set CATALINA_OUT=C:\Program Files\Reuters\Kplus30\entities\Standalone\log\ksp\\catalina.out

set JAVA_MEMORY_OPTS=-Xms256m -Xmx1024m -XX:MaxPermSize=256m
