!@ File automatically generated by macro
!@(#) $Id$ - Version : 36.0.01000
@include $(KREDITNET_CONFIG_PATH)/expert.cfm
KGL.DB.Connection.*.RootPasswordsFile: $(KREDITNET_CONFIG_PATH)/.root.passwords
KGL.DB.Connection.1.Activated: True
KGL.DB.Connection.1.Name: KreditNet
KGL.DB.Connection.1.DatabaseName: rknet
KGL.DB.Connection.1.ServerName: MSSQL_rknet
KGL.DB.Connection.1.ApplicationName: Main Kreditnet Database
KGL.DB.Connection.2.Activated: True
KGL.DB.Connection.2.Name: RateDB
KGL.DB.Connection.2.DatabaseName: rate
KGL.DB.Connection.2.ServerName: MSSQL_rate
KGL.DB.Connection.2.ApplicationName: Rate Element Database
KGL.DB.Connection.3.Activated: True
KGL.DB.Connection.3.Name: RateDBNR
KGL.DB.Connection.3.DatabaseName: rate
KGL.DB.Connection.3.ServerName: MSSQL_rate
KGL.DB.Connection.3.ApplicationName: Rate NR Element Database
KGL.DB.PsLogActive: False
KGL.DB.PsLogFileName: /home/fusionrisk/CMR/log/$(PROGRAM)_DBTraceFile.log
KGL.JmsRvBridge.Jms.Connection.BrokerUrl: tcp://framq:61616?connection.useAsyncSend=true&wireFormat.maxFrameSize=1000000000&connectionTimeout=120000&wireFormat.maxInactivityDuration=120000&wireFormat.maxInactivityDurationInitalDelay=30000&soTimeout=120000&socketBufferSize=131072&ioBufferSize=16384&wireFormat.cacheEnabled=true&wireFormat.cacheSize=2048&wireFormat.tightEncodingEnabled=true&connection.useCompression=true&jms.watchTopicAdvisories=false
KGL.JmsRvBridge.RendezVous.CmTransports.Service: 
KGL.JmsRvBridge.RendezVous.RmTransports.Service: 
KGL.JmsRvBridge.Bridge.PrintMessages.InboundJms: False
KGL.JmsRvBridge.Bridge.PrintMessages.OutboundJms: False
KreditNet.Config.*.DatabaseName: rknet
KreditNet.Config.*.DatabaseServer: MSSQL_rknet
KreditNet.Config.Client.*.MaskBehavior.UserDealStampEnable: False
KreditNet.Config.Client.*.Report.Transport.Daemon: tcp:fusion-risk-rvd-svc:7500
KreditNet.Config.Client.*.Report.Transport.Network: localhost
KreditNet.Config.Client.*.Report.WorkingDirectory: $(TEMP)
KreditNet.Config.Client.*.Trading.Transport.Daemon: tcp:fusion-risk-rvd-svc:7500
KreditNet.Config.Client.*.Trading.Transport.Network: localhost
KreditNet.Config.ClientCluster.*.Report.Transport.Service: 19038
KreditNet.Config.ClientCluster.*.Trading.Transport.Service: 19037
KreditNet.Config.Name: 
KreditNet.Config.Server.*.ClientExpiryDelay: 0
KreditNet.Config.Server.*.UserMaxConcurrentCnx: 3
KreditNet.Config.Server.*.JmsActivate: True
KreditNet.Config.Server.*.MaxNbProcs: 15
KreditNet.Config.Server.*.ReloadMvtEnable: False
KreditNet.Config.Server.*.Report.Transport.Daemon: tcp:fusion-risk-rvd-svc:7500
KreditNet.Config.Server.*.Report.Transport.Network: localhost
KreditNet.Config.Server.*.ServerMode: $(SERVER_MODE)
KreditNet.Config.Server.*.Trading.DefaultSourceShortName: MASTER_KREDITNET
KreditNet.Config.Server.*.Trading.Transport.Daemon: tcp:fusion-risk-rvd-svc:7500
KreditNet.Config.Server.*.Trading.Transport.Network: localhost
KreditNet.Config.ServerCluster.*.Transport.Service: 19039
KGL.KETAT.ReportWorkingDirectory : /home/fusionrisk/CMR/data/tmp/ketat
KreditNet.Config.TaskServer.*.NbTaskThreads: 4
KreditNet.Config.TaskServer.*.NbCollatRevalThreads: 1
KGL.Transport.RendezVous.MessageLog: 0
KreditNet.Config.KNS.MessageLog: 0
KreditNet.Config.KNS.ErrorHandling: recover
KreditNet.*.*.Activated: True
KreditNet.*.*.LogToFile: True
KreditNet.*.*.Distributed: True
KreditNet.*.*.*.IncludeDateTimePrefixInPowerTierLogFile: False
KreditNet.*.*.*.PowerTierLogFile: /home/fusionrisk/CMR/log/$(PROGRAM)_$(SERVER_MODE)_$(NUM)_DBTraceFile.log
KreditNet.*.*.TaskIndex.INFO.Activated: False
KreditNet.*.*.TaskIndex.WARNING.Activated: False
KreditNet.*.*.TaskIndex.ERROR.Activated: True
KreditNet.*.*.TaskIndex.*.File.Name: /home/fusionrisk/CMR/log/$(PROGRAM)_$(NUM)_TaskIndexTraceFile
KreditNet.Trace*ServerIndex.*.Activated: False
KreditNet.Trace*ServerIndex.*.File.Name: /home/fusionrisk/CMR/log/$(PROGRAM)_kml_log
KGL.KGRStartBatch.Trace.*.INFO.Activated: False
KGL.KGRStartBatch.Trace.*.WARNING.Activated: False
KGL.KGRStartBatch.Trace.*.ERROR.Activated: False
KGL.KGRStartBatch.Trace.*.*.File.Name: /home/fusionrisk/CMR/log/KGRStartBatch_TraceFile
KGL.KGRStartBatch.Log.*.INFO.Activated: False
KGL.KGRStartBatch.Log.*.WARNING.Activated: False
KGL.KGRStartBatch.Log.*.ERROR.Activated: False
KGL.KGRStartBatch.Log.*.*.File.Name: /home/fusionrisk/CMR/log/KGRStartBatch.log
KGL.KGRStartBatch*LogToFile: True
KGL.KGRStartBatch*Distributed: True
KGL.KGRStartBatch*File.ChangeEachDay: True
KGL.KGRStartBatch*File.ChangeFile: True
KGL.KGRStartBatch*File.FlushInterval: 10
KGL.KGRStartBatch*File.MaxFile: 5
KGL.KGRStartBatch*File.MaxSize: 10485760
KGL.KGRStartBatch*File.Suffixe.Date: True
KGL.KGRStartBatch*File.Suffixe.Pid: True
KGL.KGRStartBatch*File.Suffixe.Time: False
KreditNet.Config.*.MaxConnections: 50
KreditNet.Config.*.MinConnections: 1
KreditNet.Config.Server.*.MaxUserConnection : 10
KreditNet.Config.TaskServer.*.MaxNbProcs: 30
KreditNet.Config.Server.*.AppServerHostName: frcmr
KreditNet.Config.Server.*.AppServerHttpPort: 19084
KreditNet.Config.Server.*.AppServerHttpsPort: 19084
KreditNet.Config.Server.*.AppServerProtocol: https
KreditNet.Config.TaskServer.*.RTMServerHostName: frcmr
KreditNet.Config.TaskServer.*.RTMServerHttpPort: 19097
KreditNet.Config.TaskServer.*.RTMServerHttpsPort: 19097
KreditNet.Config.TaskServer.*.RTMWebApp: RiskTransparencyServices
KreditNet.Config.TaskServer.*.RTMTaskService: TaskService
KreditNet.Config.TaskServer.*.RTMServerProtocol: https
KGR.ImportServer.CacheTimeOut: 0
KGR.ImportServer.MaxMessageSent: 0
KGR.ImportServer.MaxMessageWait: 5
KGR.ImportServer.WriteBufferSize: 0
KGR.ImportServer.Login: kgr
KGR.ImportServer.Password: _GNs7uK8$QDwdqNPuwjLnFEgCzlBOCTiyvgoug29i_
RISKINSIGHT.LIMIT.URL: https://frcmr:19084/kgr/j_signon_ext_check
RISKINSIGHT.LIQUIDITY.URL: /topoffice
RISKINSIGHT.FFC.URL: http://:8072/mch-ui
RISKINSIGHT.FFC.PORT: 8072
RISKINSIGHT.FFC.HOST: 
RISKINSIGHT.REGULATORY.URL: http://frarc:8090
WEBAPI.QUERY.SIZE: 64
RISKINSIGHT.SERVER.HOSTNAME: frcargo
RISKINSIGHT.SERVER.URL: $(GENERICLIMITS_SERVER_PROTOCOL)://frcargo:8181
GENERICLIMITS.SERVER.PROTOCOL: http
GENERICLIMITS.SERVER.HOSTNAME: frcargo
GENERICLIMITS.SERVER.PORT: 8181
GENERICLIMITS.SERVER.HEARTBEAT_INTERVAL_MILLIS: 30000
GENERICLIMITS.POST.TRADE_PATH: akka.tcp://limits@frcargo:2552/user/RealtimeWebApi/WebTrade
GENERICLIMITS.POST.CONNECT_RETRY_MILLIS: 5000
GENERICLIMITS.POST.MAX_BEFORE_FLOW_CONTROL: 1000
GENERICLIMITS.POST.SEND_TIMEOUT_MILLIS: 3000
GENERICLIMITS.POST.MARKET_RISK_CONFIG_PATH:  
GENERICLIMITS.CHECK.PATH: akka.tcp://limits@frcargo:2552/user/Enquiry/check-actor
GENERICLIMITS.CHECK.CONNECT_RETRY_MILLIS: 2000
GENERICLIMITS.CHECK.MARKET_RISK_CONFIG_PATH:  
GENERICLIMITS.CHECK.SEND_TIMEOUT_MILLIS: 3000
GENERICLIMITS.LEGACY.POST_DEAL_ENABLED: false
GENERICLIMITS.LEGACY.CHECK_DEAL_ENABLED: false
GENERICLIMITS.LEGACY.CHECK_DEAL_PATH:  
GENERICLIMITS.LEGACY.CONNECT_RETRY_MILLIS: 2000
GENERICLIMITS.LEGACY.MAX_BEFORE_FLOW_CONTROL: 1000
GENERICLIMITS.LEGACY.SEND_TIMEOUT_MILLIS: 3000
KreditNet.Config.Server.*.AuthenticationUseCargo: true
USE_SECURE_AKKA: false
GENERICLIMITS_LEGACY_ENABLED_SOURCES:  
@include $(KREDITNET_CONFIG_PATH)/$(PROGRAM).cfm
