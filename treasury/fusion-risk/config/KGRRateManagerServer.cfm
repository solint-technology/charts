!@ File automatically generated by macro
!@(#) $Id$ - Version : 36.0.01000
KGL.KETAT.ReportWorkingDirectory : /home/fusionrisk/CMR/data/tmp/ketat
KGL.KRMS.DefaultTimeSeries: DEMO DAY
KGL.KRMS.PriceDays: 30
KGL.KRMS.UseFastImport: True
KGL.KRMS.SchemaDirectory: $(KREDITNETHOME)/interface/rate/dataSchemas
KGL.KRMS.ScenarioDirectory: /home/fusionrisk/CMR/data/interface/scenarios
KGL.KRMS.SkipDetailedLogs: False
KGL.KRMS.RateImportNbThread: 8
KGL.KRMS.ImportDirectory: /home/fusionrisk/CMR/data/interface/rate
KGL.KRMS.TsAutoSynchro: True
KGL.KRMS.TsSynchroScriptFilePathName: $(KREDITNETHOME)/etc/rtmBatch
KGL.KRMS.Login: kgr
KGL.KRMS.Password: _GNs7uK8$QDwdqNPuwjLnFEgCzlBOCTiyvgoug29i_
KGL.Transport.RendezVous.Module.1.ConnectionName: Servers
KGL.Transport.RendezVous.Module.1.Mode: Reliable Mode
KGL.Transport.RendezVous.Module.1.Name: HEARTBEAT
KGL.Transport.RendezVous.Module.1.Subject: KREDITNET.2.6.HEARTBEAT.KRMS
KGL.Transport.RendezVous.Module.2.ConnectionName: Servers
KGL.Transport.RendezVous.Module.2.Mode: Reliable Mode
KGL.Transport.RendezVous.Module.2.Name: GENERIC.REPORT
KGL.Transport.RendezVous.Module.2.Subject: KREDITNET.2.6.REPORT.SERVERS.PUBLISH
KGL.DB.PowerSyncEnable : True
KGL.DB.PowerSyncDaemon: tcp:fusion-risk-rvd-svc:7500
KGL.DB.PowerSyncNetwork: localhost
KGL.DB.PowerSyncService: 8888
KGL.DB.PowerSyncEntryPoint : PS_createMessenger 
KGL.DB.PowerSyncSubject : KREDITNET.2.6.SERVER.CACHESYNC 
KGL.DB.PowerSyncLibName : libRv8SyncMessenger.so 
KGL.DB.PowerTierLibPath : $(KREDITNETHOME)/lib/$(ARCH)
KGL.Transport.RendezVous.Module.3.Name: FUNCTIONAL.LOGS
KGL.Transport.RendezVous.Module.3.ConnectionName: Servers
KGL.Transport.RendezVous.Module.3.Subject: KREDITNET.2.6.FUNCTIONAL.LOGS.PUBLISH
KGL.Transport.RendezVous.Module.3.Mode: Reliable Mode
KGL.Transport.RendezVous.Module.4.Name: ASYNC.FWK
KGL.Transport.RendezVous.Module.4.ConnectionName: Servers
KGL.Transport.RendezVous.Module.4.Subject: KREDITNET.2.6.ASYNC.FWK.PUBLISH
KGL.Transport.RendezVous.Module.4.Mode: Reliable Mode
KGL.Transport.RendezVous.Module.5.ConnectionName: Servers
KGL.Transport.RendezVous.Module.5.Mode: Reliable Mode
KGL.Transport.RendezVous.Module.5.Name: RATE.IMPORT
KGL.Transport.RendezVous.Module.5.Subject: KGL.30.RATEIMPORT.PUBLISH
KGL.Transport.RendezVous.Connection.1.Inbound.ReliableMode.Listener.1.Name: RateReport
KGL.Transport.RendezVous.Connection.1.Inbound.ReliableMode.Listener.1.Subject: RATEREPORT.REQUEST
KGL.Transport.RendezVous.Connection.1.Inbound.ReliableMode.Listener.1.OutOfBand: False
