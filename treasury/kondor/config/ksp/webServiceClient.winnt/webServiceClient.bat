@echo off
setlocal

set CLASSPATH=C:\Program Files\Reuters\Kplus30\ksp\webServiceClient\ksp-wsclient.jar
set JAVA_HOME="C:\Program Files\Java\jdk1.8.0_60"

rem Check command syntax
set argC=0
for %%x in (%*) do Set /A argC+=1
if %argC% NEQ 1 (
    echo KSP Webservice Client
    echo Syntax^: webServiceClient.sh ^<inputFile^>
    echo[
    echo ^<inputFile^>                    a valid properties file containing the client configuration
    echo[
    echo Allowed params in the properties file^:
    echo service.url                    the url to the webservice WSDL
    echo service.username               the username for KSP server
    echo service.password               the password for KSP server
    echo service.timeout.connection     ^(optional^) service connection timeout in ms, default is 30000
    echo service.timeout.receive        ^(optional^) service response timeout in ms, default is 180000
    echo[
    echo service.action                 the service method to call, supported methods are [list, execute, content]
    echo[
    echo template.name                  the name of the template for execute and content action
    echo template.param.KEY=VALUE       allows setting up template parameters for the execute action
    echo[
    echo session.id                     [execute action only] allows executing the template in a session, with the given session id
    echo session.closeAtEnd             [execute action only, requires specifying a session.id] closes the session after executing the template if 'true'
    echo session.resetMask              [execute action only, requires specifying a session.id] resets the application after executing the template if 'true'
    echo[
    echo output.file                    the file to write the output of the call, default is output.xml
) else (
    rem Launch KSP Webservice client
    %JAVA_HOME%\bin\java.exe -cp %CLASSPATH% com.reuters.ksp.wsclient.WSClient %*
)
