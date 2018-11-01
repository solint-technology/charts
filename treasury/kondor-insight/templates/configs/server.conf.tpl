{{- define "kondor-insight-server.conf" -}}

system : {
    opendashboard.user.model = "_default"
    tibrv.libs.path = ${cargo.base}"/lib"
}


com.trmsys.fusion.kondor.report {
    defaultUserReportsPerWorkspace={
        "914f2cd3-a872-40a0-a96a-a4a709dbe795" : [],
        "914f2cd3-a872-40a0-a96a-a4a709dbe796" : []
    }
}

com.trmsys.bi.cube.provider.csm : {
    core : {
        csmMaxRowCount = "5000"
        csmPartitionCount = 4
        csmUseOnlyHeapMemory = true
        csmIgnoreNaNforDoubles = true
        csmDirectMemoryBlockSize = 262144
    },
    selector : {
        cubeClientFactory = LocalCubeClientFactory
    }
}

com.trmsys.dasel.gridgain.tcp {
  addresses = ["127.0.0.1:47501"]
  discoveryMode = TCP
}


com.trmsys.cargo.monitoring.collect : {
    enable = false,
    period = 5,
    format = LOG
}

com.trmsys.cargo.shield : {
  curb : {
    authorizations : {
      ARCAccess {
          "beforeAccess" = true
          "objectPattern" = [
            "web:/api/cargo/system/whoami.*",
            "report:(FTPResults.*|ALMAggregatedResults.*|FTPAggregatedResults.*|LCRResults.*|LCRReport.*|NSFRReport.*|RWAResults|AggregatedRWAResults)",
            "report-element:(FTPResults.*|ALMAggregatedResults.*|FTPAggregatedResults.*|LCRResults.*|LCRReport.*|NSFRReport.*|RWAResults|AggregatedRWAResults):.*"
          ]
          "onGoingAccess" = false
          "refuseAccess" = false
          "rightPattern" = [".*"]
          "subjectPattern" = [
            "role:authenticated"
          ]
          "type" = "Simple"
      },
      ReportScript {
           "beforeAccess" = true
          "objectPattern" = [
            "web:/api/cargo/system/whoami.*",
            "report:(ALMResults.*|G.INSIGHT.insight_TO_CFE.*|G.ALL_DEALS_BLOTTER.*)",
            "report-element:(ALMResults.*|G.INSIGHT.insight_TO_CFE.*|G.ALL_DEALS_BLOTTER.*):.*"
          ]
          "onGoingAccess" = false
          "refuseAccess" = false
          "rightPattern" = [".*"]
          "subjectPattern" = [
            ".*"
          ]
          "type" = "Simple"
      }
      DaselREST : {
        "beforeAccess" = true
        "objectPattern" = ["web:/(api/)?dasel(/.*)?"]
        "onGoingAccess" = false
        "refuseAccess" = false
        "rightPattern" = [".*"]
        "subjectPattern" = [".*"]
        "type" = "Simple"
      },
      FppREST : {
        "beforeAccess" = true
        "objectPattern" = ["web:/(api/)?fpp(/.*)?"]
        "onGoingAccess" = false
        "refuseAccess" = false
        "rightPattern" = [".*"]
        "subjectPattern" = [".*"]
        "type" = "Simple"
      },
      PivotREST : {
        "beforeAccess" = true
        "objectPattern" = ["web:/(api/)?pivot(/.*)?"]
        "onGoingAccess" = false
        "refuseAccess" = false
        "rightPattern" = [".*"]
        "subjectPattern" = [".*"]
        "type" = "Simple"
      },
      MisysBoardREST : {
        "beforeAccess" = true
        "objectPattern" = ["web:/(api/)?misysboard(/.*)?"]
        "onGoingAccess" = false
        "refuseAccess" = false
        "rightPattern" = [".*"]
        "subjectPattern" = [".*"]
        "type" = "Simple"
      },
      UIComponentsAccess : {
        "beforeAccess" = true
        "objectPattern" = ["web:/(api/)?ui(/.*)?", "web:/(api/)?iron-ui-web(/.*)?"]
        "onGoingAccess" = false
        "refuseAccess" = false
        "rightPattern" = [".*"]
        "subjectPattern" = [".*"]
        "type" = "Simple"
      },
      FormREST : {
        "beforeAccess" = true
        "objectPattern" = ["web:/(api/)?form(/.*)?"]
        "onGoingAccess" = false
        "refuseAccess" = false
        "rightPattern" = [".*"]
        "subjectPattern" = ["^(?!guest).*$"]
        "type" = "Simple"
      },
      TradeREST : {
        "beforeAccess" = true
        "objectPattern" = ["web:/(api/)?(trade|trade-mapper-provider)(/.*)?"]
        "onGoingAccess" = false
        "refuseAccess" = false
        "rightPattern" = [".*"]
        "subjectPattern" = ["^(?!guest).*$"]
        "type" = "Simple"
      },
      RiskREST : {
        "beforeAccess" = true
        "objectPattern" = ["web:/(api/)?(gl|limit)(/.*)?"]
        "onGoingAccess" = false
        "refuseAccess" = false
        "rightPattern" = [".*"]
        "subjectPattern" = ["^(?!guest).*$"]
        "type" = "Simple"
      },
      ProductREST : {
        "beforeAccess" = true
        "objectPattern" = ["web:/(api/)?product(/.*)?"]
        "onGoingAccess" = false
        "refuseAccess" = false
        "rightPattern" = [".*"]
        "subjectPattern" = ["^(?!guest).*$"]
        "type" = "Simple"
      },
      CollateralAccess: {
        beforeAccess=true
        objectPattern=[
            "web:/(api/)?(agreement|margincall|optimization|security_definition|security_inventory|third_party|getAgreementAndSiloForAssignments|collateralassignment)(/.*)?"
        ]
        onGoingAccess=false
        refuseAccess=false
        rightPattern=[
            ".*"
        ]
        subjectPattern=[
            "^(?!guest).*$"
        ]
        type=Simple
      },
      Collateral2Access: {
        beforeAccess=true
        objectPattern=[
            "web:/(api/)?collateral(/.*)?"
        ]
        onGoingAccess=false
        refuseAccess=false
        rightPattern=[
            ".*"
        ]
        subjectPattern=[
            "^(?!guest).*$"
        ]
        type=Simple
      },
      ReportREST : {
        "beforeAccess" = true
        "objectPattern" = ["web:/(api/)?(report|dynamicbar)(/.*)?"]
        "onGoingAccess" = false
        "refuseAccess" = false
        "rightPattern" = [".*"]
        "subjectPattern" = ["^(?!guest).*$"]
        "type" = "Simple"
      },
      SessionREST : {
        "beforeAccess" = true
        "objectPattern" = ["web:/api/session(/.*)?"]
        "onGoingAccess" = false
        "refuseAccess" = false
        "rightPattern" = [".*"]
        "subjectPattern" = [".*"]
        "type" = "Simple"
      },
      BOActionsREST: {
        "beforeAccess": true,
        "objectPattern": [
          "web:/api/boinsight(/.*)?",
          "web:/api/staticdata/(.*)?"
        ],
        "onGoingAccess": false,
        "refuseAccess": false,
        "rightPattern": [".*"],
        "subjectPattern": ["^(?!guest).*$"],
        "type": "Simple"
      },
      GcsAccess{
        beforeAccess=true,
        objectPattern=["web:/api/gcs(/.*)?"],
        onGoingAccess=false,
        refuseAccess=false,
        rightPattern=[".*"],
        subjectPattern=["(?!guest).*$"],
        type="Simple"
      },
      PricingEngineAccess{
        beforeAccess=true,
        objectPattern=["web:/api/pricingengine(/.*)?"],
        onGoingAccess=false,
        refuseAccess=false,
        rightPattern=[".*"],
        subjectPattern=["(?!guest).*$"],
        type="Simple"
      },
      CargoFreeAccess : {
        objectPattern = [
          "web:/api/cargo/registry",
          "web:/cargo/events.*",
          "web:/api/cargo/events.*",
          "web:/favicon.ico",
          "web:.*/package.json",
          "web:/admincargo.*",
          "web:/misysboard.*",
          "web:/api/cargo/configuration.*",
          "web:/api/doc.*",
          "web:/api/users.*",
          "web:/api/cargo/access.*",
          "web:/api/cargo/oauth/auth.*",
          "web:/api/cargo/oauth/revoke.*",
          "web:/api/cargo/oauth/check.*",
          "web:/api/cargo/oauth/refresh_token.*",
          "web:/doc.*",
          "web:/cube.*",
          "web:/api-docs.*"
        ]
        "beforeAccess" = true
        "refuseAccess" = false
        "onGoingAccess" = false
        "rightPattern" = [".*"]
        "subjectPattern" = [".*"]
        "type" = "Simple"
      }
    },
    subjects: {
        kplus : {
          type: "Simple",
          roles: ["misysboard:designer","kondor:admin"],
          attributes: {}
        },
        touser1 : {
          type: "Simple",
          roles: ["misysboard:designer","kondor:admin"],
          attributes: {}
        },
        touser2 : {
          type: "Simple",
          roles: ["misysboard:designer","kondor:admin"],
          attributes: {}
        },
        touser3 : {
          type: "Simple",
          roles: ["misysboard:designer","kondor:admin"],
          attributes: {}
        },
        touser4 : {
          type: "Simple",
          roles: ["misysboard:designer","kondor:admin"],
          attributes: {}
        },
        touser5 : {
          type: "Simple",
          roles: ["misysboard:designer","kondor:admin"],
          attributes: {}
        },
        touser6 : {
          type: "Simple",
          roles: ["misysboard:designer","kondor:admin"],
          attributes: {}
        },
        touser7 : {
          type: "Simple",
          roles: ["misysboard:designer","kondor:admin"],
          attributes: {}
        },
        touser8 : {
          type: "Simple",
          roles: ["misysboard:designer","kondor:admin"],
          attributes: {}
        },
        touser9 : {
          type: "Simple",
          roles: ["misysboard:designer","kondor:admin"],
          attributes: {}
        },
        touser10 : {
          type: "Simple",
          roles: ["misysboard:designer","kondor:admin"],
          attributes: {}
        },
        touser11 : {
          type: "Simple",
          roles: ["misysboard:designer","kondor:admin"],
          attributes: {}
        },
        touser12 : {
          type: "Simple",
          roles: ["misysboard:designer","kondor:admin"],
          attributes: {}
        },
        touser13 : {
          type: "Simple",
          roles: ["misysboard:designer","kondor:admin"],
          attributes: {}
        },
        touser14 : {
          type: "Simple",
          roles: ["misysboard:designer","kondor:admin"],
          attributes: {}
        },
        touser15 : {
          type: "Simple",
          roles: ["misysboard:designer","kondor:admin"],
          attributes: {}
        },
        touser16 : {
          type: "Simple",
          roles: ["misysboard:designer","kondor:admin"],
          attributes: {}
        }
    }
  },
  curbstore : {
    jdbcPassword = "sq9LrZFDulmHL0rmCCDygw=="
    jdbcUsername = "READONLY"
    jdbcUrl = "jdbc:h2:mem:persistence;"
  },
  oauth : {
    expirationTime = 3600
  },
  web : {
    filter : {
      enforceToken = true
    }
  }
}
#intentionally set to one year. This timeout should be long enought
com.trmsys.cargo.realtime.events.rs : {
  sessionTimeout = 31622400000
}
com.trmsys.dasel.addon.doctypebuilder.extensionTimeOut = 1
com.trmsys.dasel.gridgain.publicThreadPoolSize=32

com.trmsys.fabric.form.gateway.provider.filesystem.filesystem.directory = ${cargo.base}"/etc/store"

############ AUTHENTICATION ###########################

##Authentication kondor-integration config

##Authentication kondor-integration config
com.trmsys.cmf.integration.kondor.soap : {
  locatorAddress : "http://klws:8090"
  useLocator : "false"
  kdewsFixedAddress : "http://kdews:1025"
},

com.trmsys.cargo.shield.kernel : {
  authenticationActiveList = [
    "com.trmsys.fusion.kondor.session.impl.FKSessionManager"
  ]
},

############ REALTIME FEED ###########################

com.trmsys.fabric.datafeed.domain.impl: {
  databaseUser : "*",
  databaseServer : ""
},
com.trmsys.fabric.datafeed.domain.impl.framework : {
  versionDRT : "7.2"
}

############ KONDOR FO ###########################

com.trmsys.fusion.kondor.session : {
  "sessionTimeout" : 1800
  "elsEnabled": true
},

com.trmsys.fusion.kondor.integration.ksg : {
  credentialType : "KXLS"
  user : "kplus"
  host : "N/A"
  reportTimeout : 3600
},

com.trmsys.fusion.kondor.license : {
    els : {
        communicationMode = TCP
        serviceName = "els_port"
    }
    type = els
},

com.trmsys.ksg : {
  rvdService : 7500
  rvdNetwork : "eth0;;"
  rvdDaemon  : "tcp:kplus-front-rvd-svc:7500"
  rvdSubject : "KPLUS_kplus"
  asyncTimeout : 60
  timeout : 120
  dataCompression="none"
},

com.trmsys.fusion.kondor.trade : {
    ksp : {
        serverUrl : "http://ksp-web:7777/ksp"
    },
    webaccess : {
        serverUrl : "http://webaccess:7600/webaccess"
    }
},

com.trmsys.fusion.kondor.report : {
  reports : []
  superUsers :[]
  globalReports :[]
},

com.trmsys.fusion.kondor.limit : {
  activate: true
},

com.trmsys.reportscript : {
     core : {
          reportScriptDir=${cargo.base}"/etc/reportscript/"
          reportScriptList=[
               "ConsolidatedLiquidity.groovy", "ConsolidatedIRGap.groovy", "ALMScenarioDifference.groovy",  "BankingBookImport.groovy", "IncrementalLCR.groovy", "IncrementalNSFR.groovy", "Generic.groovy"
          ]
          reportScriptStart=[ "ConsolidatedLiquidity.groovy", "ConsolidatedIRGap.groovy", "IncrementalLCR.groovy", "IncrementalNSFR.groovy" ]
     }
},

############ FPP ###########################
com.misys.mgr.mpp.cargo : {
  compileScriptAtStartUp: false
},

com.trmsys.fpp.cargo.engine : {
  # To avoid FPP crashes
  oclSliceSize = 1,
  maxPackSize = 200,
  defaultArraySize = 1000,
  oclCompilationOptions = "-cl-opt-disable",
  compileScriptAtStartUp = false,
  selectedOpenclDevices: [0]
},

######################################################
system {
  opendashboard {
    user {
      model="_default"
    }
  }
  tibrv {
    libs {
      path=${cargo.base}"/lib"
    }
  }
  yar {
    default {
      timeout=30000
    }
  }
}

################# KONDOR BO ##########################

# BULKLOADING ENABLEMENT FLAG
enableBackOfficeBulkLoading = false
enableFrontOfficeBulkLoading = false
enableFront2BackBulkLoading = false
# WARNING: enableFront2BackBulkLoading = enableBackOfficeBulkLoading || enableFrontOfficeBulkLoading

#Null value in cube
com.trmsys.bi.cube.provider.csm.core : {
  csmNullStringValue : "-"
},

com.trmsys.maf.database.jdbc : {
  driver.classname : "net.sourceforge.jtds.jdbc.Driver"
  url : "jdbc:jtds:sqlserver://kplus-db:1433;DatabaseName=kplus"
  username : "kplus"
  password : "OOMoqEGsC1GT0oQ0wvi+wQ=="
},

com.trmsys.cmf.infra.database.jdbc : {
  driver.classname : "net.sourceforge.jtds.jdbc.Driver"
  url : "jdbc:jtds:sqlserver://kplus-db:1433;DatabaseName=Kustom"
  username : "kplus"
  password : "OOMoqEGsC1GT0oQ0wvi+wQ=="
},

com.trmsys.fabric.database.jdbc : {
  driver.classname : "net.sourceforge.jtds.jdbc.Driver"
  url : "jdbc:jtds:sqlserver://kplus-db:1433;DatabaseName=Kustom;loginTimeout=10"
  username = "kplus"
  password : "OOMoqEGsC1GT0oQ0wvi+wQ=="
},

com.trmsys.fabric.user.gateway.provider.database : {
  driverClassName : "net.sourceforge.jtds.jdbc.Driver"
  url : "jdbc:jtds:sqlserver://kplus-db:1433;DatabaseName=Kustom"
  userName : "kplus"
  password : "OOMoqEGsC1GT0oQ0wvi+wQ=="
},

com.trmsys.cmf.integration.kondor.common.service.impl.database : {
  jdbcClassname : "net.sourceforge.jtds.jdbc.Driver"
  jdbcUrl : "jdbc:jtds:sqlserver://kplus-db:1433;DatabaseName=kplus;loginTimeout=10"
  jdbcUsername : "kplus"
  jdbcPassword : "OOMoqEGsC1GT0oQ0wvi+wQ=="
  kplusDbName : "kplus"
  kplusVersionDbName : "KplusVersion"
  kplustpDbName : "ktpplus"
  instanceName : "Kplus1"
  maxActive : 8
},

com.trmsys.cmf.integration.kondor.common.service.impl.ksg : {
  ksgSso : "false"
  ksgUser : "kplus"
  ksgPassword : "OOMoqEGsC1GT0oQ0wvi+wQ=="
},

com.trmsys.cmf.integration.kondor.common.service.impl.reports.reportConfig : {
  MTMComputation = "false"
  ReportDatabase = "grtr"
  ReportName = "KondorIntegrationMTM"
  MovementAwaitingTimeout = 600

  ## K+ TRADES ##

  CapFloorDeals = "false"
  CreditSwapDeals = "false"
  EquitySwapDeals = "false"
  ForwardDeals = "false"
  FraDeals = "false"
  FxOptionsDeals = "false"
  SwapDeals = "false"
  SwaptionDeals = "false"

  ## K+ STATIC DATA ##
  Bonds = "false"
},


## FO replicator configuration
com.trmsys.cmf.integration.kondor.common.service.impl.replicator : {
  codifier : CMF-INT
  port : 7500
  network : "eth0;;"
  daemon : "tcp:kplus-front-rvd-svc:7500"
},

## BO replicator configuration
com.trmsys.cmf.integration.kondor.bo.gateway.kml : {
  user : "ktpplus"
  password : "OOMoqEGsC1GT0oQ0wvi+wQ=="
  applicationName : "kplustp"
  rvService : 8889
  rvNetWork : "eth0;;"
  rvDaemon : "tcp:kplus-front-rvd-kis-tk-svc:8889"
  dbName : "ktpplus"
  dbUrl : "jdbc:sqlserver:Tds:kplus-db:1433/ktpplus"
  enabled : "true"
},

## cross referencing enablement
com.trmsys.fabric.repository : {
  xRefEnabled : false
},

## available repos FO
com.trmsys.fabric.repository : {
  repositoryConfig : {
    Trade : {
      stereotypeName : "Trade"
    }
    legalentity : {
      stereotypeName : "legalentity"
    }
    businesscenter : {
      stereotypeName : "businesscenter"
    }
    currency : {
      stereotypeName : "currency"
    }
    equity : {
      stereotypeName : "equity"
    }
    currencypair : {
      stereotypeName : "currencypair"
    }
    currefindex : {
      stereotypeName : "currefindex"
    }
    floatingrate : {
      stereotypeName : "floatingrate"
    }
    exception : {
      stereotypeName : "exception"
    }
    posting : {
      stereotypeName : "posting"
    }
    settlement : {
      stereotypeName : "settlement"
    }
    messaging : {
      stereotypeName : "messaging"
    }
  }
},

com.trmsys.fcbo.reportmodel.impl : {
  "_DISABLE_fixedPivotDate":"2003-05-07"
},

com.trmsys.fcbo.trade:{
  enable=true
  stereotype=tradeEvent
  tradeTypeAttribute=dummyType
},

#iron gateway server in K+TP
#http://kplustphost:KPLUSTP_CATALINA_FCBO_WEBAPP_PORT/irongw
com.trmsys.cmf.integration.kondor.bo.gateway {
  "ironurl" : "http://kplus-back:7576/irongw"
},

com.trmsys.cmf.integration.kondor.bo.toolbar : {
  enable:true,
  frontEnable:true
},

com.trmsys.fcbo.todolist : {
  enable:true
},

com.trmsys.fcgc.licensing {
  serviceName="els_port"
},


##=============== Kondor Integration list of tables to load ========##
com.trmsys.cmf.integration.kondor.common.store : {
  instrumentConfig : {
    ## K+ TRADES ##
    BondsDeals = "false"        # Future: ${enableFrontOfficeBulkLoading}
    BondsOtcOptDeals = "false"
    CallAccountsDeals = "false"
    CapFloorDeals = "false"
    CashFlowDeals = "false"
    CreditSwapDeals = "false"
    EqOtcOptDeals = "false"
    EquitiesDeals = "false"
    EquitySwapDeals = "false"
    ForwardDeals = "false"      # Future: ${enableFrontOfficeBulkLoading}
    FraDeals = "false"          # Future: ${enableFrontOfficeBulkLoading}
    FuturesDeals = "false"      # Future: ${enableFrontOfficeBulkLoading}
    FxOptionsDeals = "false"
    FxSwapDeals = "false"
    KdbTables = ${enableFront2BackBulkLoading}
    IamDeals = "false"          # Future: ${enableFrontOfficeBulkLoading}
    LoansDepositDeals = "false" # Future: ${enableFrontOfficeBulkLoading}
    OptionsDeals = "false"
    PaperDeals = "false"
    RepoDeals = "false"
    SecurLoansDeals = "false"
    SpotDeals = "false"
    SwapDeals = ${enableFrontOfficeBulkLoading}
    SwaptionDeals = "false"
    WarrantsDeals = "false"
    BondsDealsVer = "false"
    ForwardDealsVer = "false"
    FraDealsVer = "false"
    FuturesDealsVer = "false"
    FxSwapDealsVer = "false"
    IamDealsVer = "false"
    LoansDepositDealsVer = "false"
    RepoDealsVer = "false"
    SpotDealsVer = "false"
    SwapDealsVer = "false"

    ## K+ STATIC DATA ##
    Bonds = ${enableFront2BackBulkLoading}
    BondsCurves = "false"
    BondsCurvesQuotes = "false"
    BondsQuotes = "false"
    Branches = ${enableFront2BackBulkLoading}
    BranchesEntity = ${enableBackOfficeBulkLoading}
    Cities = ${enableFront2BackBulkLoading}
    CmUnits = ${enableBackOfficeBulkLoading}
    CollatAgrt = ${enableBackOfficeBulkLoading}
    Countries = ${enableBackOfficeBulkLoading}
    Cpty = ${enableFront2BackBulkLoading}
    CurRefIndex = ${enableFront2BackBulkLoading}
    Currencies = ${enableFront2BackBulkLoading}
    DRTPrefix = ${enableBackOfficeBulkLoading}
    Equities = ${enableFront2BackBulkLoading}
    FloatingRates = ${enableFront2BackBulkLoading}
    HierarchyEntities = ${enableBackOfficeBulkLoading}
    Folders = ${enableFront2BackBulkLoading}
    FoldersAllowed = ${enableFront2BackBulkLoading}
    LegalEntities = ${enableBackOfficeBulkLoading}
    Markets = ${enableBackOfficeBulkLoading}
    MaturityClasses = ${enableFront2BackBulkLoading}
    Pairs = ${enableFront2BackBulkLoading}
    Papers = ${enableBackOfficeBulkLoading}
    Portfolios = ${enableFront2BackBulkLoading}
    Regions = ${enableFront2BackBulkLoading}
    RTHubRouting = ${enableBackOfficeBulkLoading}
    TypeOfInstr = ${enableFront2BackBulkLoading}
    Users = ${enableFront2BackBulkLoading}
    UsersAccessRights = ${enableBackOfficeBulkLoading}

    ## ACCESS RIGHTS ##
    BranchesAccessRights = "false"
    CollatAgrtAccessRights = "false"
    CptyAccessRights = ${enableBackOfficeBulkLoading}
    CurrenciesAccessRights = "false"
    DataAccessRights = "false"
    FloatingRatesAccessRights = "false"
    FoldersAccessRights = ${enableBackOfficeBulkLoading}
    HierarchyEntitiesAccessRights = "false"
    PortfoliosAccessRights = "false"
    RegionsAccessRights = "false"
    TypeOfInstrAccessRights = "false"
    UserEntitlements = "false"

    ## K+ MARKET DATA ##
    BasketIndexes = "false"
    BasisSwapSpread = ${enableFrontOfficeBulkLoading}
    BasisSwapSpreadValues = "false"
    CalcRules = "false"
    ClosingCurveFloatingRatesValues = "false"
    Curves = ${enableFrontOfficeBulkLoading}
    CurveInstrumentEOMYRates = ${enableFrontOfficeBulkLoading}
    CurvesFloatingRatesLD = ${enableFrontOfficeBulkLoading}
    CurvesFloatingRatesSWAP = ${enableFrontOfficeBulkLoading}
    CurvesFxPointsValues="false"
    CurveInstrumentFloatingRates = ${enableFrontOfficeBulkLoading}
    CurveInstrumentBasisSwapNR = ${enableFrontOfficeBulkLoading}
    CurveInstrumentGridPoints = ${enableFrontOfficeBulkLoading}
    FloatingRatesValues="false"
    FraMaturitiesValues="false"
    Futures = ${enableFrontOfficeBulkLoading}
    FuturesMaturities = ${enableFrontOfficeBulkLoading}
    FuturesQuotes = "false"
    FxCurves = ${enableFrontOfficeBulkLoading}
    FxCurvesMarketData = "false"
    Options = ${enableFrontOfficeBulkLoading}

    ## K+TP INSTRUMENTS ##
    Account = ${enableBackOfficeBulkLoading}
    Accounting = ${enableBackOfficeBulkLoading}
    AccountingGroup = ${enableBackOfficeBulkLoading}
    BankAccount = ${enableBackOfficeBulkLoading}
    Bic = ${enableBackOfficeBulkLoading}
    BODeal = ${enableBackOfficeBulkLoading}
    ChartOfAccount = ${enableBackOfficeBulkLoading}
    ClearingModes = ${enableBackOfficeBulkLoading}
    CustodianAccount = ${enableBackOfficeBulkLoading}
    Delivery = ${enableBackOfficeBulkLoading}
    DeliveryClass = ${enableBackOfficeBulkLoading}
    DeliveryReconciliation = ${enableBackOfficeBulkLoading}
    DeliveryValidationJournal = "false"
    Entity = ${enableBackOfficeBulkLoading}
    EventAccountingData = ${enableBackOfficeBulkLoading}
    EventCashFlowData = ${enableBackOfficeBulkLoading}
    EventDealData = ${enableBackOfficeBulkLoading}
    EventSecurities = ${enableBackOfficeBulkLoading}
    EventValidationJournal = "false"
    DeliveryException = ${enableBackOfficeBulkLoading}
    Exception = ${enableBackOfficeBulkLoading}
    PaymentException = ${enableBackOfficeBulkLoading}
    ExceptionCode = ${enableBackOfficeBulkLoading}
    FOSource = ${enableBackOfficeBulkLoading}
    MailHeader = ${enableBackOfficeBulkLoading}
    MailHeaderCfg = ${enableBackOfficeBulkLoading}
    MailMatching = ${enableBackOfficeBulkLoading}
    MailType = ${enableBackOfficeBulkLoading}
    MailValidationJournal = ${enableBackOfficeBulkLoading}
    Payment = ${enableBackOfficeBulkLoading}
    PaymentClass = ${enableBackOfficeBulkLoading}
    PaymentGroup = ${enableBackOfficeBulkLoading}
    PaymentNetting = ${enableBackOfficeBulkLoading}
    PaymentReconciliation = ${enableBackOfficeBulkLoading}
    PaymentValidationJournal = "false"
    PositionValidationJournal = "false"
    Securities = ${enableBackOfficeBulkLoading}
    SecuritiesEvent = ${enableBackOfficeBulkLoading}
    SSICpty = ${enableBackOfficeBulkLoading}
    SSIEntity = ${enableBackOfficeBulkLoading}
    ThirdParty = ${enableBackOfficeBulkLoading}
    ThirdPartyAccessRights = ${enableBackOfficeBulkLoading}
    Timezones = ${enableFront2BackBulkLoading}
    TradeEvent = ${enableBackOfficeBulkLoading}
    Validation = ${enableBackOfficeBulkLoading}
    ValidationStatus = ${enableBackOfficeBulkLoading}
  }
},


##============== Back Office Bulkload config ==================##
com.trmsys.cmf.integration.kondor.common.store.lib: {
  bulkloaderConfig : {
    staticDataConfig : {
      ClosingCurveFloatingRatesConfig : {
        maxCount : -1
        whereClause : ""
      },
      FloatingRatesConfig : {
        maxCount : -1
        whereClause : ""
        whereClauseFloatingRatesValues : "0=1"
      }
    },
    marketDataConfig : {
      ClosingCurveFloatingRatesValuesConfig : {
        maxCount : -1
        whereClause : "FloatingRatesValues.FRDate > DATEADD(year,-3, 'systemDate')"
      },
      FloatingRatesValuesConfig : {
        maxCount : -1
        whereClause : "FloatingRatesValues.FRDate > DATEADD(year,-3, 'systemDate')"
      },
      FxCurvesConfig : {
        maxCount : -1
        whereClause : "PairsQuotes.PriceDate > DATEADD(year,-3,(select max(PairsQuotes.PriceDate) from PairsQuotes ))"
      }
    },
    BackOfficeConfig : {
      BicConfig : {
        maxCount : -1
        whereClause : ""
      },
      DeliveryConfig : {
        maxCount : -1
        whereClause : "CaptureDate>=dateadd(dd,-90,getdate()) AND CaptureDate<dateadd(dd,7,getdate())"
      },
      PaymentConfig : {
        maxCount : -1
        whereClause : "((ValueDate>=dateadd(dd,-90,getdate()) AND ValueDate<dateadd(dd,7,getdate())) OR (CaptureDate>=dateadd(dd,-90,getdate()) AND CaptureDate<dateadd(dd,7,getdate())))"
      },
      AccountConfig : {
        maxCount : -1
        whereClause : ""
      },
      AccountingGroupConfig : {
        maxCount : -1
        whereClause : ""
      },
      BranchesEntityConfig : {
        maxCount : -1
        whereClause : ""
      },
      ChartOfAccountConfig : {
        maxCount : -1
        whereClause : ""
      },
      AccountingConfig : {
        maxCount : -1
        whereClause : "CaptureDate>=dateadd(dd,-90,getdate()) AND CaptureDate<dateadd(dd,7,getdate())"
      },
      MailHeaderConfig : {
        maxCount : -1
        whereClause : "CreationDate>=dateadd(dd,-90,getdate()) AND CreationDate<dateadd(dd,7,getdate())"
      },
      DeliveryExceptionConfig : {
        maxCount : -1
        whereClause : ""
      },
      ExceptionConfig : {
        maxCount : -1
        whereClause : "ExceptionDate>=dateadd(dd,-90,getdate()) AND ExceptionDate<dateadd(dd,7,getdate())"
      },
      PaymentExceptionConfig : {
        maxCount : -1
        whereClause : ""
      },
      EventDealDataConfig : {
        maxCount : -1
        whereClause : "KPLUSTPDBNAME..Event.EventDate>=dateadd(dd,-90,getdate()) AND KPLUSTPDBNAME..Event.EventDate<dateadd(dd,7,getdate())"
      },
      BankAccountConfig : {
        maxCount : -1
        whereClause:""
      },
      BODealConfig : {
        maxCount : -1
        whereClause : ""
        whereClauseBODealFOKey : ""
      },
      CustodianAccountConfig : {
        maxCount : -1
        whereClause:""
      },
      DeliveryClassConfig : {
        maxCount : -1
        whereClause:""
      },
      DeliveryReconciliationConfig : {
        maxCount : -1
        whereClause:""
      },
      EntityConfig : {
        maxCount : -1
        whereClause:""
      },
      EventAccountingDataConfig : {
        maxCount : -1
        whereClause : "KPLUSTPDBNAME..Event.EventDate>=dateadd(dd,-90,getdate()) AND KPLUSTPDBNAME..Event.EventDate<dateadd(dd,7,getdate())"
      },
      EventCashFlowDataConfig : {
        maxCount : -1
        whereClause : "KPLUSTPDBNAME..Event.EventDate>=dateadd(dd,-90,getdate()) AND KPLUSTPDBNAME..Event.EventDate<dateadd(dd,7,getdate())"
      },
      EventSecuritiesConfig : {
        maxCount : -1
        whereClause : "KPLUSTPDBNAME..Event.EventDate>=dateadd(dd,-90,getdate()) AND KPLUSTPDBNAME..Event.EventDate<dateadd(dd,7,getdate())"
      },
      PaymentValidationJournalConfig : {
        maxCount : -1
        whereClause:"CaptureDate>=dateadd(dd,-90,getdate()) AND CaptureDate<dateadd(dd,7,getdate())"
      },
      PositionValidationJournalConfig : {
        maxCount : -1
        whereClause:"CaptureDate>=dateadd(dd,-90,getdate()) AND CaptureDate<dateadd(dd,7,getdate())"
      },
      EventValidationJournalConfig : {
        maxCount : -1
        whereClause:"CaptureDate>=dateadd(dd,-90,getdate()) AND CaptureDate<dateadd(dd,7,getdate())"
      },
      DeliveryValidationJournalConfig : {
        maxCount : -1
        whereClause:"CaptureDate>=dateadd(dd,-90,getdate()) AND CaptureDate<dateadd(dd,7,getdate())"
      },
      ExceptionCodeConfig : {
        maxCount : -1
        whereClause:""
      },
      FOSourceConfig : {
        maxCount : -1
        whereClause:""
      },
      MailHeaderCfgConfig : {
        maxCount : -1
        whereClause:""
      },
      MailMatchingConfig : {
        maxCount : -1
        whereClause:""
      },
      MailTypeConfig : {
        maxCount : -1
        whereClause : ""
      },
      MailValidationJournalConfig : {
        maxCount : -1
        whereClause:"CaptureDate>=dateadd(dd,-90,getdate()) AND CaptureDate<dateadd(dd,7,getdate())"
      },
      PaymentGroupConfig : {
        maxCount : -1
        whereClause:""
      },
      PaymentNettingConfig : {
        maxCount : -1
        whereClause:""
      },
      PaymentReconciliationConfig : {
        maxCount : -1
        whereClause:""
      },
      SecuritiesConfig : {
        maxCount : -1
        whereClause:""
      },
      SSICptyConfig : {
        maxCount : -1
        whereClause:""
      },
      SSIEntityConfig : {
        maxCount : -1
        whereClause:""
      },
      ValidationConfig : {
        maxCount : -1
        whereClause:""
      },
      ValidationStatusConfig : {
        maxCount : -1
        whereClause:""
      },
      ThirdPartyConfig : {
        maxCount : -1
        whereClause:""
      },
      TimezonesConfig : {
        maxCount : -1
        whereClause:""
      }
    }
  }
}

com.trmsys.cargo.shield.curb : {
  authorizations : {
    ReportAccess: {
      "beforeAccess": true,
      "objectPattern": ["report|report_element:.*"],
      "onGoingAccess": false,
      "refuseAccess": false,
      "rightPattern": [".*"],
      "subjectPattern": ["^(?!guest).*$"],
      "type": "Simple"
    }
  }
}

com.trmsys.cargo.web {
    secure=False
    httpsPort=8445
    minWorkers=20
    maxWorkers=200
}

############ referenceDate for NR ###########################
# referenceDate should never be pushed to the customer. referenceDateThis is a temporary workaround for FCP. We need to dig out if bulkloading Users is enough to compute AsOf date correctly
com.trmsys.cmf.referenceDate="2003-08-27"

com.trmsys.cmf.integration.kondor.bo.store.impl.asofdate.cityShortName="PAR"

############################## ARC CONFIGURATION ###########################
com.misys.fusionrisk: {
csmApiFeatureConfig: {
  "deleteCSVFile" : True,
  "ActivateARCAccessRight" : False
}
}

{{- end -}}