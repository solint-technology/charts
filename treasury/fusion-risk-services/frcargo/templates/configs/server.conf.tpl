{{- define "frcargo-server.conf" -}}
# ############################################################################
#  Configure Cargo Web Jetty
#  https://scm-git-eur.misys.global.ad/projects/MAFTP/repos/cargo/browse/cargo-platform/cargo-web/cargo-web-impl/src/main/config/com.trmsys.cargo.web.properties
# ############################################################################
include "globalMonitoring.conf"

common.parameters
{
  KEY_STORE_FILE="/home/fusionrisk/Certificates/server.keystore"
  KEY_STORE_PASSWORD="ZaRdS73gxCIDbpCTjK3Zzg=="
  TRUST_CERT_FILE="/home/fusionrisk/Certificates/trust.keystore"
  TRUST_CERT_PASSWORD="ZaRdS73gxCIDbpCTjK3Zzg=="
  fusionrisk.database
  {
    URL= "jdbc:jtds:sqlserver://kplus-db:1433/rknet"
    USER = kgr	
    PASSWORD = "OOMoqEGsC1GT0oQ0wvi+wQ==" 
    DRIVER = net.sourceforge.jtds.jdbc.Driver	
    DIALECT = "org.hibernate.dialect.SQLServer2008Dialect"	
    TYPE = mssql
    RKNET=rknet
  }
  fusionrisk.rtm
  {
    URL = "https://frcmr-rtm:19097"
  }
  fusionrisk.arc
  {
    URL = "http://frarc:32412"
    launcherURL = "http://localhost:5005"
  }
  fusionrisk.security
  {
    ADMIN_GROUP="GROUP-ADMIN-KOND"
  }
  fusionrisk.cargo
  {
    HTTPS_URL="https://frcargo:8444"
  }
}
  
com.trmsys.cargo.web.http = true
com.trmsys.cargo.web.httpPort = 8181
com.trmsys.cargo.web.secure = true
com.trmsys.cargo.web.httpsPort = 8444
com.trmsys.cargo.web.maxWorkers = 42
com.trmsys.cargo.web.useGzipCompression = true
com.trmsys.cargo.web.filter.enforceToken = true

com.trmsys.cargo.web : {
  keymanagerPassword=${common.parameters.TRUST_CERT_PASSWORD}
  keystorePassword=${common.parameters.KEY_STORE_PASSWORD}
  keystorePath=${common.parameters.KEY_STORE_FILE}
  trustCertFile=${common.parameters.TRUST_CERT_FILE}
}

# ############################################################################
#  Configure Global Monitoring
# ############################################################################

fusionrisk.globalmonitoring {
  dbUpgradeOnStartup=false
  elasticsearch_http_port = 9200
  elasticsearch_url="http://elasticsearch:9200"
  components_enabled=false
}

# ############################################################################
#  Configure CSM
# ############################################################################

com.trmsys.bi.cube.provider.csm.core.csmMaxRowCount = 200000
com.trmsys.bi.cube.provider.csm.core.csmPartitionCount = 4

# Isolate DASEL to prevent it creating a cluster
com.trmsys.dasel.gridgain {
         discovery {
             port: 47510
             portRange: 10
         }
         tcp {
             addresses: ["127.0.0.1:47510..47519"]
             shared: true
         }
         metricsLogPeriodMilliSecond=0
     }

# ############################################################################
#  Configure ELS
# ############################################################################
com.trmsys.fcgc.licensing.applicationName="FCGC"
com.trmsys.fcgc.licensing.serviceName="els"

# ############################################################################
#  Configure Insights Applications (former riskinsight.properties)
# /!\ More clean up to come but keys will stay the same /!\
# ############################################################################

// Base URLs for all Insight Apps.
com.misys.fusionrisk.uiconfig  {
  cargoURL = ""
  rtmServerUrl = ${common.parameters.fusionrisk.rtm.URL}/RiskTransparencyServices
  dataAdmin {
    webApiUrl = ${common.parameters.fusionrisk.rtm.URL}/api
  }
  arc {
    launcherURL = ${common.parameters.fusionrisk.arc.launcherURL}
  }
}

// Will soon be refactored as below by default and removed
com.misys.fusionrisk.indicators.impl.notifications {
  notificationServiceUrl = ${com.misys.fusionrisk.uiconfig.cargoURL}/notifications/notify
  keystorePath =  ${common.parameters.KEY_STORE_FILE}
  keystorePassword = ${common.parameters.KEY_STORE_PASSWORD}
}

// Will soon be refactored as below by default and removed
com.misys.fusionrisk.hedgeservice.common {
  rtmUrl = ${com.misys.fusionrisk.uiconfig.rtmServerUrl}
  keystorePath = ${common.parameters.KEY_STORE_FILE}
  keystorePassword = ${common.parameters.KEY_STORE_PASSWORD}
  username = "kgr"
  password = "OOMoqEGsC1GT0oQ0wvi+wQ=="
  baseCurrency = "EUR"
}

fusionrisk.simulationservice {
  ffc {
    ws {
      url = "https://ffc-kplus-integration:8838/treasuryOptimisation/integration/FFCSimulationService?wsdl"
      password = "password"
    }
  }
}

# ############################################################################
#  Configure Monitoring server
#  -> Make it point to an ARC REST Dispatcher
# /!\ More clean up to come but keys will stay the same /!\
# ############################################################################

com.misys.mgr.proxy.commons.arcUrl = ${common.parameters.fusionrisk.arc.URL}

# #############################################################################
# Configure Limits
# #############################################################################

com.trmsys.cargo.web.war.contextNames {
  "com.trmsys.org.camunda.bpm.webapp:camunda-webapp"=workflow
}

fusionrisk.bpm {
    enabled=true
    databaseType=${common.parameters.fusionrisk.database.TYPE}
    databaseSchemaUpdate="false"
    jdbcUrl=${common.parameters.fusionrisk.database.URL}
    jdbcDriver=${common.parameters.fusionrisk.database.DRIVER}
    jdbcUsername=${common.parameters.fusionrisk.database.USER}
    jdbcPassword=${common.parameters.fusionrisk.database.PASSWORD}
    mailServerHost=smtp.office365.com
    mailServerPort=587
    mailServerPassword=""
    mailServerUsername=""
    mailServerUseTLS=true
    mailServerDefaultFrom=""
    
    scriptEngineFactories=["org.codehaus.groovy.jsr223.GroovyScriptEngineFactory"]
  
    createDefaultTaskFilters = "true"	
	  taskFilters=["mytasks","mygrouptasks","alltasks"] 
    createDefaultAdminAuthorizations = "true"	
    adminGroupId=${common.parameters.fusionrisk.security.ADMIN_GROUP}
    
    filterVariables {
      LimitId="LimitName" 
      eventId="EventId" 
      BreachStatus="BreachStatus" 
    }
}
# ############################################################################ 
# User Management Service Configuration
# ############################################################################ 

fusionrisk.userservice.provider {
  masterSource=CMR
  synchedSources=[]
  synchronizeOnStartup=false
  dbUpgradeOnStartup=true
}

fusionrisk.cmr.database {
    url = ${common.parameters.fusionrisk.database.URL}
    user = ${common.parameters.fusionrisk.database.USER}
    password = ${common.parameters.fusionrisk.database.PASSWORD}
    driver = ${common.parameters.fusionrisk.database.DRIVER}
	dialect = ${common.parameters.fusionrisk.database.DIALECT}
    type = ${common.parameters.fusionrisk.database.TYPE}
    rknet = ${common.parameters.fusionrisk.database.RKNET}
}

fusionrisk.arc.rest {
    url = ${common.parameters.fusionrisk.arc.URL}
    keyStoreFile=${common.parameters.KEY_STORE_FILE}
    keyStorePassword=${common.parameters.KEY_STORE_PASSWORD}
    trustStoreFile=${common.parameters.TRUST_CERT_FILE}
    trustStorePassword=${common.parameters.TRUST_CERT_PASSWORD}
    basicAuthUsername="admin"
    basicAuthPassword="fls5Idf3RbM="
    trustAll=false
}

fusionrisk.master.database {
    url = ${common.parameters.fusionrisk.database.URL}
    user = ${common.parameters.fusionrisk.database.USER}
    password = ${common.parameters.fusionrisk.database.PASSWORD}
    driver = ${common.parameters.fusionrisk.database.DRIVER}
	dialect = ${common.parameters.fusionrisk.database.DIALECT}
    type = ${common.parameters.fusionrisk.database.TYPE}
    rknet = ${common.parameters.fusionrisk.database.RKNET}
}

fusionrisk.security {
default {
    }}

# #############################################################################
# Configure ARC Realm
# #############################################################################

com.misys.mgr.arc.security.common {
  serverUri = ${common.parameters.fusionrisk.arc.URL}"/login"
  sslKeystorePath = ${common.parameters.KEY_STORE_FILE}
  sslKeystorePassword = ${common.parameters.KEY_STORE_PASSWORD}
}

# #############################################################################
# Configure Shiro and Shield Security
# #############################################################################

com.trmsys.cargo.shield.shiro.ini.sections.main {
  "securityManager.realms": "$frRealm,$oauthShieldRealm"
}

com.trmsys.cargo.shield.oauth.expirationTime = 3600
com.trmsys.cargo.shield.curbstore.activate = false
com.trmsys.cargo.shield.curbstore.jdbcPassword = "ZaRdS73gxCIDbpCTjK3Zzg=="
com.trmsys.cargo.shield.bankfusion : {
  keyStorePassword=${common.parameters.KEY_STORE_PASSWORD}
  trustCertPassword=${common.parameters.TRUST_CERT_PASSWORD}
  keyStoreFile=${common.parameters.KEY_STORE_FILE}
  trustCertFile=${common.parameters.TRUST_CERT_FILE}
}

com.trmsys.cargo.shield.curb.authorizations : {
 
  FreeAccess: {
    objectPattern = [
      "web:/api/doc.*",
      "web:/doc.*",
      "web:/api/uiconfig.*",
      "web:/notifications.*",
      "web:/peEditor.*",
      "web:/rcw.*",
      "web:/api/cargo/oauth/auth.*",
      "web:/api/cargo/oauth/check.*",
      "web:/api/cargo/oauth/revoke.*",
      "web:/api/cargo/oauth/refresh_token.*",
      "web:/admincargo.*",
      "web:/api/cargo/configuration.*"
    ],
    "beforeAccess" = true
    "refuseAccess" = false
    "onGoingAccess" = false
    "rightPattern" = [".*"]
    "subjectPattern" = [".*"]
    "type" = "Simple"
  },
  
  AuthenticatedAccess: {
    "objectPattern" = [
      "web:/(api/)?misysboard.*",
      "web:/(api/)?fusionrisk.*",
      "report:.*",
      "cube:.*",
      "report-element:.*:.*",
      "web:/api/cargo/system/whoami.*",
      "web:/(api/)?cargo/events.*",
      "web:/api.*"
    ]
    "beforeAccess" = true
    "onGoingAccess" = false
    "refuseAccess" = false
    "rightPattern" = [".*"]
    "subjectPattern" = ["role:authenticated"]
    "type" = "Simple"
  }
  
}

# #############################################################################
# Others
# #############################################################################

system.yar.default.timeout=5000

{{- end -}}