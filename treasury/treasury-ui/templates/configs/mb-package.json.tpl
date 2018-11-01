{{- define "mb-package.json" -}}
{
  "packages": [
    "addons"
  ],
  "services": [
    {
      "type": "rest",
      "provider": "socket",
      "name": "Misysboard Event Bus",
      "url": "https://localhost:{{ .Values.service.port }}/api/misysboard/events",
      "token": "master"
    },


    {
      "type": "rest",
      "provider": "form",
      "name": "FormBuilder",
      "url": "http://{{ .Values.insight.service }}:{{ .Values.insight.port }}/api",
      "checkUrl": "http://{{ .Values.insight.service }}:{{ .Values.insight.port }}/api/form",
      "token": "master"
    },
    {
      "type": "rest",
      "provider": "trade",
      "name": "Trade",
      "url": "http://{{ .Values.insight.service }}:{{ .Values.insight.port }}/api",
      "checkUrl": "http://{{ .Values.insight.service }}:{{ .Values.insight.port }}/api/form/trade",
      "token": "master",
      "options": {
        "limitsInitializationTimeout": 120000
      }
    },
    {
      "type": "rest",
      "provider": "trade-mapper-provider",
      "name": "Mapper",
      "url": "http://{{ .Values.insight.service }}:{{ .Values.insight.port }}/api/trade-mapper-provider",
      "checkUrl": "http://{{ .Values.insight.service }}:{{ .Values.insight.port }}/api/trade-mapper-provider/services",
      "token": "master"
    },
    {
      "type": "rest",
      "provider": "report",
      "name": "Report Recap",
      "url": "http://{{ .Values.insight.service }}:{{ .Values.insight.port }}/api/report",
      "token": "master"
    },
    {
      "type": "rest",
      "provider": "cubeactionsfilter",
      "name": "Cube Actions Filter",
      "url": "http://{{ .Values.insight.service }}:{{ .Values.insight.port }}/api/report",
      "token": "master"
    },
    {
      "type": "rest",
      "provider": "kondorglobalreports",
      "name": "Kondor Global Reports",
      "url": "http://{{ .Values.insight.service }}:{{ .Values.insight.port }}/api/report/global",
      "token": "master"
    },
    {
      "type": "rest",
      "provider": "reporting",
      "name": "Reporting",
      "url": "http://{{ .Values.insight.service }}:{{ .Values.insight.port }}/api/misysboard/report/types",
      "token": "master",
      "options": {
        "realTime": "KondorCargoRealTime"
      }
    },
    {
      "type": "rest",
      "provider": "pivot",
      "name": "Pivot",
      "url": "http://{{ .Values.insight.service }}:{{ .Values.insight.port }}/api/misysboard/pivot",
      "checkUrl": "http://{{ .Values.insight.service }}:{{ .Values.insight.port }}/api/misysboard/pivot/test",
      "token": "master",
      "options": {
        "realTime": "KondorCargoRealTime"
      }
    },
    {
      "type": "rest",
      "provider": "limitsdk",
      "name": "Limits SDK",
      "url": "http://{{ .Values.insight.service }}:{{ .Values.insight.port }}/api/limit",
      "checkUrl": "http://{{ .Values.insight.service }}:{{ .Values.insight.port }}/api/limit",
      "token": "master",
      "options": {
        "realTime": "KondorCargoRealTime"
      }
    },
    {
      "type": "rest",
      "provider": "dynamicbar",
      "name": "Dynamic Bar",
      "url": "http://{{ .Values.insight.service }}:{{ .Values.insight.port }}/api/dynamicbar",
      "token": "master"
    },
    {
      "provider": "cargoRealTime",
      "name": "KondorCargoRealTime",
      "version": "2.0",
      "url": "http://{{ .Values.insight.service }}:{{ .Values.insight.port }}/api/cargo/events",
      "token": "master"
    },
    {
      "type": "rest",
      "provider": "reportscript",
      "name": "ReportScript",
      "url": "http://{{ .Values.insight.service }}:{{ .Values.insight.port }}/api",
      "checkUrl": "http://{{ .Values.insight.service }}:{{ .Values.insight.port }}/api",
      "token": "master"
    },
    {
      "type": "rest",
      "provider": "reference",
      "name": "Static Data Reference",
      "url": "http://{{ .Values.insight.service }}:{{ .Values.insight.port }}/api/store/static-data/vocabulary",
      "token": "master"
    },
    {
      "type": "rest",
      "provider": "bucketlist",
      "name": "Bucket List",
      "url": "http://{{ .Values.insight.service }}:{{ .Values.insight.port }}/api/bucketlist",
      "token": "master"
    },
    {
      "type": "rest",
      "provider": "bucketlistperccyconfig",
      "name": "Bucket List Per Currency",
      "url": "http://{{ .Values.insight.service }}:{{ .Values.insight.port }}/api/bucketlistperccyconfig",
      "token": "master"
    },


    {
      "type": "rest",
      "provider": "reporting",
      "name": "Reporting_collateral",
      "url": "${CARGO_COLLATERAL_URL}/api/misysboard/report/types",
      "token": "collateral",
      "options": {
        "realTime": "CollateralCargoRealTime"
      }
    },
    {
      "provider": "CargoRealTime",
      "name": "CollateralCargoRealTime",
      "version": "2.0",
      "url": "${CARGO_COLLATERAL_URL}/api/cargo/events",
      "token": "collateral"
    },
    {
      "type": "rest",
      "provider": "agreement",
      "name": "Agreement",
      "url": "${CARGO_COLLATERAL_URL}/api",
      "checkUrl": "${CARGO_COLLATERAL_URL}/api",
      "token": "collateral"
    },
    {
      "type": "rest",
      "provider": "margincall",
      "name": "Margin Call",
      "url": "${CARGO_COLLATERAL_URL}/api",
      "checkUrl": "${CARGO_COLLATERAL_URL}/api",
      "token": "collateral"
    },
    {
      "type": "rest",
      "provider": "profile",
      "name": "Profile",
      "url": "${CARGO_COLLATERAL_URL}/api",
      "token": "collateral"
    },
    {
      "type": "rest",
      "provider": "collateralactionbar",
      "name": "Collateralactions",
      "url": "${CARGO_COLLATERAL_URL}/api/collateral",
      "checkUrl": "${CARGO_COLLATERAL_URL}/api/collateral",
      "token": "collateral"
    },
    {
      "type": "rest",
      "provider": "collateralassignment",
      "name": "Collateral Assignment",
      "url": "${CARGO_COLLATERAL_URL}/api",
      "checkUrl": "${CARGO_COLLATERAL_URL}/api",
      "token": "collateral"
    },
    {
      "type": "rest",
      "provider": "collateraloptimization",
      "name": "Collateral",
      "url": "${CARGO_COLLATERAL_URL}/api",
      "checkUrl": "${CARGO_COLLATERAL_URL}/api",
      "token": "collateral"
    },
    {
      "type": "rest",
      "provider": "editrow",
      "name": "Edit Row",
      "url": "${CARGO_COLLATERAL_URL}/api",
      "checkUrl": "${CARGO_COLLATERAL_URL}/api",
      "token": "collateral"
    },
    {
      "type": "rest",
      "provider": "decisiontable",
      "name": "Decision Table",
      "url": "${CARGO_COLLATERAL_URL}/api/decision-table",
      "checkUrl": "${CARGO_COLLATERAL_URL}/api/decision-table/type",
      "token": "collateral"
    },


    {
      "type": "rest",
      "provider": "limitsdk",
      "name": "FR Limits SDK",
      "url": "http://{{ .Values.fusionrisk.service }}:{{ .Values.fusionrisk.port }}/api/gl/v1.0",
      "token": "risk",
      "options": {
        "realTime": "FRCargoRealTime"
      }
    },
    {
      "type": "rest",
      "provider": "reporting",
      "name": "FR Reporting",
      "url": "http://{{ .Values.fusionrisk.service }}:{{ .Values.fusionrisk.port }}/api/misysboard/report/types",
      "token": "risk",
      "options": {
        "realTime": "FRCargoRealTime"
      }
    },
    {
      "provider": "CargoRealTime",
      "name": "FRCargoRealTime",
      "version": "2.0",
      "url": "http://{{ .Values.fusionrisk.service }}:{{ .Values.fusionrisk.port }}/api/cargo/events",
      "token": "risk"
    },


    {
      "type": "rest",
      "provider": "globalMonitoring",
      "name": "globalMonitoring",
      "url": "${CARGO_MONITORING_URL}/api/globalMonitoring",
      "token": "monitoring"
    },
    {
      "provider": "cargoRealTime",
      "name": "monitoringCargoEvent",
      "version": "2.0",
      "url": "${CARGO_MONITORING_URL}/api/cargo/events",
      "token": "monitoring"
    },
    {
      "type": "rest",
      "provider": "cargo",
      "name": "cargo",
      "url": "${CARGO_MONITORING_URL}/api/cargo",
      "token": "monitoring"
    },
    {
      "type": "rest",
      "provider": "${KIBANA_URL}",
      "name": "kibana",
      "url": "${KIBANA_URL}",
      "token": "monitoring"
    },
    {
      "type": "rest",
      "provider": "elastic",
      "name": "elasticSearch",
      "url": "${ELASTIC_URL}",
      "token": "monitoring"
    }
  ],
  "authorizations": {
    "master": {
      "type": "rest",
      "provider": "authorization",
      "access": "http://{{ .Values.insight.service }}:{{ .Values.insight.port }}/api/cargo/access",
      "url": "http://{{ .Values.insight.service }}:{{ .Values.insight.port }}/api/cargo/oauth/auth",
      "refresh": "http://{{ .Values.insight.service }}:{{ .Values.insight.port }}/api/cargo/oauth/refresh_token",
      "logout": "http://{{ .Values.insight.service }}:{{ .Values.insight.port }}/api/cargo/oauth/revoke"
    }
    ,
    "risk": {
      "type": "rest",
      "provider": "authorization",
      "access": "http://{{ .Values.fusionrisk.service }}:{{ .Values.fusionrisk.port }}/api/cargo/access",
      "url": "http://{{ .Values.fusionrisk.service }}:{{ .Values.fusionrisk.port }}/api/cargo/oauth/auth",
      "refresh": "http://{{ .Values.fusionrisk.service }}:{{ .Values.fusionrisk.port }}/api/cargo/oauth/refresh_token",
      "logout": "http://{{ .Values.fusionrisk.service }}:{{ .Values.fusionrisk.port }}/api/cargo/oauth/revoke"
    }
  }
}
{{- end -}}