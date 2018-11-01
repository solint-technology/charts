{{- define "collateral_server.conf" -}}
{
system {
    opendashboard {
        folder={{ .Values.system.opendashboard.folder }}
        user {
            model="{{ .Values.system.opendashboard.user.model }}"
        }
    }
    tibrv {
        libs {
            path={{ .Values.system.tibrv.libs.path }}
        }
    }
    yar {
        default {
            timeout={{ .Values.system.yar.default.timeout }}
        }
    }
}
com {
    trmsys {
        cargo {
            web {
                http={{ .Values.cargo.web.http }}
                httpPort={{ .Values.cargo.web.httpPort }}
                secure={{ .Values.cargo.web.secure }}
                httpsPort={{ .Values.cargo.web.httpsPort }}
                # crypted private key password
                keymanagerPassword="{{ .Values.cargo.web.keymanagerPassword }}"
                # crypted store password
                keystorePassword="{{ .Values.cargo.web.keystorePassword }}"
            }
            shield {
                oauth {
                    expirationTime=3600
                }
            }
            monitoring {
                collect {
                    #
                    # START MONITORING
                    #
                    enable={{ .Values.cargo.monitoring.collect.enable }}
                    # format can be LOG or CSV
                    format={{ .Values.cargo.monitoring.collect.format }}
                    # in seconds
                    period={{ .Values.cargo.monitoring.collect.period }}
                    # INDICATORS:
                    queries {
                        #
                        # JVM INDICATORS
                        #
                        "java.lang:type=Memory" {
                            alias=Memory
                            attributes=[
                                {
                                    keys=[
                                        used
                                    ]
                                    name=HeapMemoryUsage
                                },
                                {
                                    keys=[
                                        used
                                    ]
                                    name=NonHeapMemoryUsage
                                }
                            ]
                        }
                        "java.lang:type=OperatingSystem" {
                            alias=CPU
                            attributes=[
                                {
                                    name=SystemCpuLoad
                                },
                                {
                                    name=ProcessCpuLoad
                                }
                            ]
                        }
                        #
                        # APPLICATION INDICATORS
                        #
                        "com.trmsys.dasel.store:type=Domains,name=COLLATERALDATA" {
                            alias=CollateralData
                            attributes=[
                                {
                                    name=documentCount
                                }
                            ]
                        }
                        "com.trmsys.dasel.store:type=Domains,name=DomainTrade" {
                            alias=Trade
                            attributes=[
                                {
                                    name=documentCount
                                }
                            ]
                        }
                        "com.trmsys.cargo.management:type=CargoState" {
                            alias=CargoState
                            attributes=[
                                {
                                    name=state
                                }
                            ]
                        }
                    }
                }
            }
        }
        dasel {
            addon {
                doctypebuilder {
                    extensionTimeOut={{ .Values.dasel.extensionTimeOut }}
                }
            }
            dataflow {
                maxThreads={{ .Values.dasel.maxThreads }}
            }
        }
        bi {
            report {
                provider {
                    cube {
                        report {
                            aggregateReports={{ .Values.bi.aggregateReports }}
                        }
                    }
                }
            }
        }
        fabric {
            database {
                jdbc {
                    driver {
                        classname="{{ .Values.fabric.database.driver }}"
                    }
                    url="{{ .Values.fabric.database.url }}"
                    username="{{ .Values.fabric.database.username }}"
                    password="{{ .Values.fabric.database.password }}"
                }
            }
            # START FUNCTIONAL SERVICES CONFIG
            repository {
                xRefEnabled={{ .Values.fabric.repository.xRefEnabled }}
                xRefInitTimeOut={{ .Values.fabric.repository.xRefInitTimeOut }}
                repositoryConfig {
                    Trade {
                        stereotypeName="Trade"
                    }
                    legalentity {
                        stereotypeName="legalentity"
                    }
                    businesscenter {
                        stereotypeName="businesscenter"
                    }
                    currency {
                        stereotypeName="currency"
                    }
                    equity {
                        stereotypeName="equity"
                    }
                    currencypair {
                        stereotypeName="currencypair"
                    }
                    currefindex {
                        stereotypeName="currefindex"
                    }
                    floatingrate {
                        stereotypeName="floatingrate"
                    }
                    collateralagreement : {
                      stereotypeName : "collateralagreement"
                    }
                    margincall : {
                      stereotypeName : "margincall"
                    }
                    ccpmargincall : {
                      stereotypeName : "ccpmargincall"
                    }
                }
                xRefRepositoryConfig {
                    bond {
                        keyMappingProcessor=BondXRefKeyMapProc
                        ownership=Summit
                        ownershipProcessor=BondXRefOwnershipProc
                        stereotypeName=bond
                    }
                    businesscenter {
                        keyMappingProcessor=BusinessCenterXRefKeyMapProc
                        ownership=Summit
                        ownershipProcessor=BusinessCenterXRefOwnershipProc
                        stereotypeName=businesscenter
                    }
                    businessunit {
                        keyMappingProcessor=BusinessUnitXRefKeyMapProc
                        ownership=Summit
                        ownershipProcessor=BusinessUnitXRefOwnershipProc
                        stereotypeName=businessunit
                    }
                    currency {
                        keyMappingProcessor=CurrencyXRefKeyMapProc
                        ownership=Summit
                        ownershipProcessor=CurrencyXRefOwnershipProc
                        stereotypeName=currency
                    }
                    currencypair {
                        keyMappingProcessor=CurrencyPairXRefKeyMapProc
                        ownership=Summit
                        ownershipProcessor=CurrencyPairXRefOwnershipProc
                        stereotypeName=currencypair
                    }
                    equity {
                        keyMappingProcessor=EquityXRefKeyMapProc
                        ownership=Summit
                        ownershipProcessor=EquityXRefOwnershipProc
                        stereotypeName=equity
                    }
                    legalentity {
                        keyMappingProcessor=LegalEntityXRefKeyMapProc
                        ownership=Summit
                        ownershipProcessor=LegalEntityXRefOwnershipProc
                        stereotypeName=legalentity
                    }
                    swap {
                        keyMappingProcessor=SwapXRefKeyMapProc
                        ownership=Summit
                        ownershipProcessor=SwapXRefOwnershipProc
                        stereotypeName=swap
                    }
                    user {
                        keyMappingProcessor=UserXRefKeyMapProc
                        ownership=Summit
                        ownershipProcessor=UserXRefOwnershipProc
                        stereotypeName=user
                    }
                }
            }
            # END FUNCTIONAL SERVICES CONFIG
        }
        # LICENSING CONFIG
        fcgc {
            licensing {
                applicationName={{ .Values.fcgc.licensing.applicationName }}
                serviceName="{{ .Values.fcgc.licensing.serviceName }}"
            }
        }
        # END LICENSING CONFIG
        cmf {
            collateral {
                acadia {
                    #
                    # START COLLATERAL CONFIG
                    #
                    proxyinfo {
                        rootUrl="{{ .Values.collateral.acadia.proxyinfo.rootUrl }}"
                        username="{{ .Values.collateral.acadia.proxyinfo.username }}"
                        password="{{ .Values.collateral.acadia.proxyinfo.password }}"
                        timeFrame={{ .Values.collateral.acadia.proxyinfo.timeFrame }}
                        updateTimeFrame={{ .Values.collateral.acadia.proxyinfo.updateTimeFrame }}
                        proxyHost="{{ .Values.collateral.acadia.proxyinfo.proxyHost }}"
                        proxyPort="{{ .Values.collateral.acadia.proxyinfo.proxyPort }}"
                        proxyUsername="{{ .Values.collateral.acadia.proxyinfo.proxyUsername }}"
                        proxyPassword="{{ .Values.collateral.acadia.proxyinfo.proxyPassword }}"
                        isProxyEnabled={{ .Values.collateral.acadia.proxyinfo.isProxyEnabled }}
                        refreshRate={{ .Values.collateral.acadia.proxyinfo.refreshRate }}
                        automaticPollingEnable={{ .Values.collateral.acadia.proxyinfo.automaticPollingEnable }}
                    }
                }
                reporting {
                    reportingCurrency="{{ .Values.collateral.reporting.reportingCurrency }}"
                }
                spi {
                    cashService="{{ .Values.collateral.spi.cashService }}"
                    securityService="{{ .Values.collateral.spi.securityService }}"
                    securitiesInventoryService="{{ .Values.collateral.spi.securitiesInventoryService }}"
                    sensitivitiesService="{{ .Values.collateral.spi.sensitivitiesService }}"
                    cashMovementsBalancesService="{{ .Values.collateral.spi.cashMovementsBalancesService }}"
                }
                exposure {
                    data {
                        registry {
                            interest {
                                serviceName={{ .Values.collateral.exposure.serviceNames.interest }}
                            }
                            haircut {
                                serviceName={{ .Values.collateral.exposure.serviceNames.haircut }}
                            }
                            allinprice {
                                serviceName={{ .Values.collateral.exposure.serviceNames.allinprice }}
                            }
                            amount {
                                serviceName={{ .Values.collateral.exposure.serviceNames.amount }}
                            }
                            rate {
                                serviceName={{ .Values.collateral.exposure.serviceNames.rate }}
                            }
                            complete {
                                serviceName={{ .Values.collateral.exposure.serviceNames.complete }}
                            }
                        }
                    }
                }
                service {
                    bulkLoadWaitTime={{ .Values.collateral.service.bulkLoadWaitTime }}
                    tradeAssignmentWaitTime={{ .Values.collateral.service.tradeAssignmentWaitTime }}
                    waitForMtmEvents={{ .Values.collateral.service.waitForMtmEvents }}
                    loadAllReportsAtStartTime={{ .Values.collateral.service.loadAllReportsAtStartTime }}
                }
                impl {
                    asOfDate="{{ .Values.collateral.impl.asOfDate }}"
                }
                gateway {
                    provider {
                        marketdata {
                            repoRatesService="{{ .Values.collateral.gateway.provider.marketdata.repoRatesService }}"
                            fxForwardRatesService="{{ .Values.collateral.gateway.provider.marketdata.fxForwardRatesService }}"
                            oisRateService="{{ .Values.collateral.gateway.provider.marketdata.oisRateService }}"
                        }
                    }
                    endpoint {
                        rest {
                            optimizationInputTimeout={{ .Values.collateral.gateway.endpoint.rest.optimizationInputTimeout }}
                        }
                    }
                }
                mkdata {
                    addon {
                        #
                        # COLLATERAL ADDONS
                        #
                        csv {
                            pathToFileForRepoRates={{ .Values.collateral.mkdata.addon.csv.pathToFileForRepoRates }}
                            pathToFileForFxForwardRates={{ .Values.collateral.mkdata.addon.csv.pathToFileForFxForwardRates }}
                            pathToFileForOisRates={{ .Values.collateral.mkdata.addon.csv.pathToFileForOisRates }}
                        }
                    }
                }
                im {
                    addon {
                        acadia {
                            contextFactory="{{ .Values.collateral.im.addon.acadia.contextFactory }}"
                            providerUrl="{{ .Values.collateral.im.addon.acadia.providerUrl }}"
                            connectionFactory="{{ .Values.collateral.im.addon.acadia.connectionFactory }}"
                            timeout={{ .Values.collateral.im.addon.acadia.timeout }}
                            threadPoolSize={{ .Values.collateral.im.addon.acadia.threadPoolSize }}
                            requestQueueName="{{ .Values.collateral.im.addon.acadia.requestQueueName }}"
                            responseQueueName="{{ .Values.collateral.im.addon.acadia.responseQueueName }}"
                            username="{{ .Values.collateral.im.addon.acadia.username }}"
                            password="{{ .Values.collateral.im.addon.acadia.password }}"
                            tradeBatchSize={{ .Values.collateral.im.addon.acadia.tradeBatchSize }}
                        }
                        fusionrisk {
                            contextFactory="{{ .Values.collateral.im.addon.fusionrisk.contextFactory }}"
                            providerUrl="{{ .Values.collateral.im.addon.fusionrisk.providerUrl }}"
                            connectionFactory="{{ .Values.collateral.im.addon.fusionrisk.connectionFactory }}"
                            timeout={{ .Values.collateral.im.addon.fusionrisk.timeout }}
                            threadPoolSize={{ .Values.collateral.im.addon.fusionrisk.threadPoolSize }}
                            requestQueueName="{{ .Values.collateral.im.addon.fusionrisk.requestQueueName }}"
                            responseQueueName="{{ .Values.collateral.im.addon.fusionrisk.responseQueueName }}"
                            userName="{{ .Values.collateral.im.addon.fusionrisk.userName }}"
                            password="{{ .Values.collateral.im.addon.fusionrisk.password }}"
                            varType="{{ .Values.collateral.im.addon.fusionrisk.varType }}"
                            riskMeasure="{{ .Values.collateral.im.addon.fusionrisk.riskMeasure }}"
                            leftOrRightTail="{{ .Values.collateral.im.addon.fusionrisk.leftOrRightTail }}"
                            confidenceLevel={{ .Values.collateral.im.addon.fusionrisk.confidenceLevel }}
                            decayFactor={{ .Values.collateral.im.addon.fusionrisk.decayFactor }}
                            pnlCubeConfigurations=[
                            {{- range .Values.collateral.im.addon.fusionrisk.pnlCubeConfigurations }}
                                {
                                  currencyId={{ .currencyId }},
                                  pnlCubeId={{ .pnlCubeId }}
                                }
                            {{- end }}
                            ]
                        }
                    }
                }
                brokerstatement {
                    addon {
                        contextFactory="{{ .Values.collateral.brokerstatement.addon.contextFactory }}"
                        providerUrl="{{ .Values.collateral.brokerstatement.addon.providerUrl }}"
                        connectionFactory="{{ .Values.collateral.brokerstatement.addon.connectionFactory }}"
                        responseQueueName="{{ .Values.collateral.brokerstatement.addon.responseQueueName }}"
                        userName="{{ .Values.collateral.brokerstatement.addon.userName }}"
                        password="{{ .Values.collateral.brokerstatement.addon.password }}"
                    }
                }
		    }
		    integration {
		        #
                # START KONDOR INTEGRATION CONFIG
                #
                kondor {
                    common {
                        service {
                            impl {
                                database {
                                    jdbcClassname="{{ .Values.integration.kondor.common.database.jdbcClassname }}"
                                    jdbcUrl="{{ .Values.integration.kondor.common.database.jdbcUrl }}"
                                    jdbcUsername="{{ .Values.integration.kondor.common.database.jdbcUsername }}"
                                    jdbcPassword="{{ .Values.integration.kondor.common.database.jdbcPassword }}"
                                    kplusDbName="{{ .Values.integration.kondor.common.database.kplusDbName }}"
                                    kplustpDbName="{{ .Values.integration.kondor.common.database.kplustpDbName }}"
                                    instanceName="{{ .Values.integration.kondor.common.database.instanceName }}"
                                    maxActive="{{ .Values.integration.kondor.common.database.maxActive }}"
                                }
                                rdvstream {
                                    enabled={{ .Values.integration.kondor.common.rdvstream.enabled }}
                                    service={{ .Values.integration.kondor.common.rdvstream.service }}
                                    network={{ .Values.integration.kondor.common.rdvstream.network }}
                                    daemon="{{ .Values.integration.kondor.common.rdvstream.daemon }}"
                                    tibrvOemLicense={{ .Values.integration.kondor.common.rdvstream.tibrvOemLicense }}
                                }
                                dbstream {
                                    enabled={{ .Values.integration.kondor.common.dbstream.enabled }}
                                }
                                reportstream {
                                    enabled={{ .Values.integration.kondor.common.reportstream.enabled }}
                                }
                                codifier {
                                    enabled={{ .Values.integration.kondor.common.codifier.enabled }}
                                    codifier="{{ .Values.integration.kondor.common.codifier.codifier }}"
                                    isdacodifier="{{ .Values.integration.kondor.common.codifier.isdacodifier }}"
                                }
                                currency {
                                    identityCardId={{ .Values.integration.kondor.common.currency.identityCardId }}
                                }
                                versioning {
                                    useVersioning={{ .Values.integration.kondor.common.versioning.useVersioning }}
                                }
                            }
                        }
                    }
                    bo {
                        gateway {
                            ironurl="{{ .Values.integration.kondor.bo.gateway.ironurl }}"
                            kml {
                                applicationName={{ .Values.integration.kondor.bo.gateway.kml.applicationName }}
                                dbName={{ .Values.integration.kondor.bo.gateway.kml.dbName }}
                                dbUrl="{{ .Values.integration.kondor.bo.gateway.kml.dbUrl }}"
                                enabled="{{ .Values.integration.kondor.bo.gateway.kml.enabled }}"
                                password="{{ .Values.integration.kondor.bo.gateway.kml.password }}"
                                rvDaemon="{{ .Values.integration.kondor.bo.gateway.kml.rvDaemon }}"
                                rvNetWork={{ .Values.integration.kondor.bo.gateway.kml.rvNetWork }}
                                rvService={{ .Values.integration.kondor.bo.gateway.kml.rvService }}
                                user={{ .Values.integration.kondor.bo.gateway.kml.user }}
                            }
                        }
                        store {
                            impl {
                                asofdate {
                                    cityShortName="{{ .Values.integration.kondor.bo.store.impl.asofdate.cityShortName }}"
                                }
                            }
                        }
                    }
                    collateral {
                        domain {
                            impl {
                                pathToFileForSimmRiskPerimeters={{ .Values.integration.kondor.collateral.domain.impl.pathToFileForSimmRiskPerimeters }}
                            }
                        }
                        gateway {
                            callaccountsdeals {
                                adjusted={{ .Values.integration.kondor.collateral.callaccountsdeals.adjusted }}
                                adjustmentOn={{ .Values.integration.kondor.collateral.callaccountsdeals.adjustmentOn }}
                                amendmentType={{ .Values.integration.kondor.collateral.callaccountsdeals.amendmentType }}
                                averageFirstCoupon={{ .Values.integration.kondor.collateral.callaccountsdeals.averageFirstCoupon }}
                                calculationMethod={{ .Values.integration.kondor.collateral.callaccountsdeals.calculationMethod }}
                                clearingModesId={{ .Values.integration.kondor.collateral.callaccountsdeals.clearingModesId }}
                                dailyAccrualRounding={{ .Values.integration.kondor.collateral.callaccountsdeals.dailyAccrualRounding }}
                                dealStatus={{ .Values.integration.kondor.collateral.callaccountsdeals.dealStatus }}
                                dealType={{ .Values.integration.kondor.collateral.callaccountsdeals.dealType }}
                                endDateRollConvention={{ .Values.integration.kondor.collateral.callaccountsdeals.endDateRollConvention }}
                                eoma={{ .Values.integration.kondor.collateral.callaccountsdeals.eoma }}
                                eomaType={{ .Values.integration.kondor.collateral.callaccountsdeals.eomaType }}
                                floatingRatesShortName={{ .Values.integration.kondor.collateral.callaccountsdeals.floatingRatesShortName }}
                                foldersId={{ .Values.integration.kondor.collateral.callaccountsdeals.foldersId }}
                                foldersIdCaptured={{ .Values.integration.kondor.collateral.callaccountsdeals.foldersIdCaptured }}
                                fullCoupon={{ .Values.integration.kondor.collateral.callaccountsdeals.fullCoupon }}
                                inputMode={{ .Values.integration.kondor.collateral.callaccountsdeals.inputMode }}
                                interestType={{ .Values.integration.kondor.collateral.callaccountsdeals.interestType }}
                                isAModel={{ .Values.integration.kondor.collateral.callaccountsdeals.isAModel }}
                                isCollaterizedByAnnex={{ .Values.integration.kondor.collateral.callaccountsdeals.isCollaterizedByAnnex }}
                                mrLiable={{ .Values.integration.kondor.collateral.callaccountsdeals.mrLiable }}
                                noticePeriod={{ .Values.integration.kondor.collateral.callaccountsdeals.noticePeriod }}
                                paymentLagType={{ .Values.integration.kondor.collateral.callaccountsdeals.paymentLagType }}
                                resetInArrears={{ .Values.integration.kondor.collateral.callaccountsdeals.resetInArrears }}
                                rollConvention={{ .Values.integration.kondor.collateral.callaccountsdeals.rollConvention }}
                                typeOfCallAccount={{ .Values.integration.kondor.collateral.callaccountsdeals.typeOfCallAccount }}
                                typeOfEvent={{ .Values.integration.kondor.collateral.callaccountsdeals.typeOfEvent }}
                                typeOfInstrId={{ .Values.integration.kondor.collateral.callaccountsdeals.typeOfInstrId }}
                                usersId={{ .Values.integration.kondor.collateral.callaccountsdeals.usersId }}
                                valueDateConvention={{ .Values.integration.kondor.collateral.callaccountsdeals.valueDateConvention }}
                                ourInitialMarginId={{ .Values.integration.kondor.collateral.callaccountsdeals.ourInitialMarginId }}
                                theirInitialMarginId={{ .Values.integration.kondor.collateral.callaccountsdeals.theirInitialMarginId }}
                                variationMarginId={{ .Values.integration.kondor.collateral.callaccountsdeals.variationMarginId }}
                                netMarginId={{ .Values.integration.kondor.collateral.callaccountsdeals.netMarginId }}
                            }
                            repodeals {
                                adjustMaturityDate={{ .Values.integration.kondor.collateral.repodeals.adjustMaturityDate }}
                                adjusted={{ .Values.integration.kondor.collateral.repodeals.adjusted }}
                                basis={{ .Values.integration.kondor.collateral.repodeals.basis }}
                                brkPrdInterpolation={{ .Values.integration.kondor.collateral.repodeals.brkPrdInterpolation }}
                                brokenPeriod={{ .Values.integration.kondor.collateral.repodeals.brokenPeriod }}
                                calculationMethod={{ .Values.integration.kondor.collateral.repodeals.calculationMethod }}
                                callNoticesShortName="{{ .Values.integration.kondor.collateral.repodeals.callNoticesShortName }}"
                                capturedMarketValue={{ .Values.integration.kondor.collateral.repodeals.capturedMarketValue }}
                                capturedMaturity={{ .Values.integration.kondor.collateral.repodeals.capturedMaturity }}
                                clearingModesId={{ .Values.integration.kondor.collateral.repodeals.clearingModesId }}
                                compoundAverageFrequency={{ .Values.integration.kondor.collateral.repodeals.compoundAverageFrequency }}
                                computeConvexityBias={{ .Values.integration.kondor.collateral.repodeals.computeConvexityBias }}
                                conversionRate={{ .Values.integration.kondor.collateral.repodeals.conversionRate }}
                                costOfCarry={{ .Values.integration.kondor.collateral.repodeals.costOfCarry }}
                                couponsCumul={{ .Values.integration.kondor.collateral.repodeals.couponsCumul }}
                                dealStatus={{ .Values.integration.kondor.collateral.repodeals.dealStatus }}
                                deliveryMode={{ .Values.integration.kondor.collateral.repodeals.deliveryMode }}
                                discountMargin={{ .Values.integration.kondor.collateral.repodeals.discountMargin }}
                                endDateRollConvention={{ .Values.integration.kondor.collateral.repodeals.endDateRollConvention }}
                                eoma={{ .Values.integration.kondor.collateral.repodeals.eoma }}
                                eomaType={{ .Values.integration.kondor.collateral.repodeals.eomaType }}
                                feeIndexedAmount={{ .Values.integration.kondor.collateral.repodeals.feeIndexedAmount }}
                                fixedRate={{ .Values.integration.kondor.collateral.repodeals.fixedRate }}
                                fixingFrequency={{ .Values.integration.kondor.collateral.repodeals.fixingFrequency }}
                                foldersId={{ .Values.integration.kondor.collateral.repodeals.foldersId }}
                                forwardConversionRate={{ .Values.integration.kondor.collateral.repodeals.forwardConversionRate }}
                                frequency={{ .Values.integration.kondor.collateral.repodeals.frequency }}
                                haircutMethod={{ .Values.integration.kondor.collateral.repodeals.haircutMethod }}
                                ignoreCouponPayments={{ .Values.integration.kondor.collateral.repodeals.ignoreCouponPayments }}
                                imm={{ .Values.integration.kondor.collateral.repodeals.imm }}
                                indexation={{ .Values.integration.kondor.collateral.repodeals.indexation }}
                                indexedAdjFactor={{ .Values.integration.kondor.collateral.repodeals.indexedAdjFactor }}
                                indexedFwdAdjFactor={{ .Values.integration.kondor.collateral.repodeals.indexedFwdAdjFactor }}
                                indexedFwdFxRate1={{ .Values.integration.kondor.collateral.repodeals.indexedFwdFxRate1 }}
                                indexedFwdFxRate2={{ .Values.integration.kondor.collateral.repodeals.indexedFwdFxRate2 }}
                                indexedFxRate1={{ .Values.integration.kondor.collateral.repodeals.indexedFxRate1 }}
                                indexedFxRate2={{ .Values.integration.kondor.collateral.repodeals.indexedFxRate2 }}
                                inputMode={{ .Values.integration.kondor.collateral.repodeals.inputMode }}
                                interestCalcMethod={{ .Values.integration.kondor.collateral.repodeals.interestCalcMethod }}
                                isBooked={{ .Values.integration.kondor.collateral.repodeals.isBooked }}
                                isCollateralized={{ .Values.integration.kondor.collateral.repodeals.isCollateralized }}
                                isCollateralizedByAnnex={{ .Values.integration.kondor.collateral.repodeals.isCollateralizedByAnnex }}
                                isExponentiallyCompounded={{ .Values.integration.kondor.collateral.repodeals.isExponentiallyCompounded }}
                                japaneseRepo={{ .Values.integration.kondor.collateral.repodeals.japaneseRepo }}
                                lendingRate={{ .Values.integration.kondor.collateral.repodeals.lendingRate }}
                                line={{ .Values.integration.kondor.collateral.repodeals.line }}
                                mixedCollateralType={{ .Values.integration.kondor.collateral.repodeals.mixedCollateralType }}
                                mrLiable={{ .Values.integration.kondor.collateral.repodeals.mrLiable }}
                                override={{ .Values.integration.kondor.collateral.repodeals.override }}
                                paymentAt={{ .Values.integration.kondor.collateral.repodeals.paymentAt }}
                                paymentLag={{ .Values.integration.kondor.collateral.repodeals.paymentLag }}
                                paymentLagType={{ .Values.integration.kondor.collateral.repodeals.paymentLagType }}
                                paymentType={{ .Values.integration.kondor.collateral.repodeals.paymentType }}
                                priceOrigin={{ .Values.integration.kondor.collateral.repodeals.priceOrigin }}
                                quantoAdj={{ .Values.integration.kondor.collateral.repodeals.quantoAdj }}
                                rate={{ .Values.integration.kondor.collateral.repodeals.rate }}
                                refCostOfCarry={{ .Values.integration.kondor.collateral.repodeals.refCostOfCarry }}
                                refReinvestedCoupons={{ .Values.integration.kondor.collateral.repodeals.refReinvestedCoupons }}
                                referenceValue={{ .Values.integration.kondor.collateral.repodeals.referenceValue }}
                                reinvestedCoupons={{ .Values.integration.kondor.collateral.repodeals.reinvestedCoupons }}
                                resetInArrears={{ .Values.integration.kondor.collateral.repodeals.resetInArrears }}
                                resetLag={{ .Values.integration.kondor.collateral.repodeals.resetLag }}
                                rollConvention={{ .Values.integration.kondor.collateral.repodeals.rollConvention }}
                                roundingType={{ .Values.integration.kondor.collateral.repodeals.roundingType }}
                                scheduleGeneration={{ .Values.integration.kondor.collateral.repodeals.scheduleGeneration }}
                                scheduleMerging={{ .Values.integration.kondor.collateral.repodeals.scheduleMerging }}
                                typeOfEvent={{ .Values.integration.kondor.collateral.repodeals.typeOfEvent }}
                                typeOfInstrShortName={{ .Values.integration.kondor.collateral.repodeals.typeOfInstrShortName }}
                                useBrazilianRoundingRules={{ .Values.integration.kondor.collateral.repodeals.useBrazilianRoundingRules }}
                                used={{ .Values.integration.kondor.collateral.repodeals.used }}
                                usersId={{ .Values.integration.kondor.collateral.repodeals.usersId }}
                            }
                        }
                    }
                    data {
                        bonds {
                            load=true
                            whereClause=""
                            hideMaturedDeals=true
                        }
                        hierarchyentitylegal {
                            load=true
                        }
                    }
                    trades {
                      capfloor{
                        load=true
                        whereClause=""
                        hideMaturedDeals=true
                      }
                      creditswap{
                        load=true
                        whereClause=""
                        hideMaturedDeals=true
                      }
                      external{
                        load=false
                      }
                      eqotcopt{
                        load=true
                        whereClause=""
                        hideMaturedDeals=true
                      }
                      equityswap{
                        load=true
                        whereClause=""
                        hideMaturedDeals=true
                      }
                      forward{
                        load=true
                        whereClause=""
                        hideMaturedDeals=true
                      }
                      fra{
                        load=true
                        whereClause=""
                        hideMaturedDeals=true
                      }
                      fxoptions{
                        load=true
                        whereClause=""
                        hideMaturedDeals=true
                      }
                      fxswap{
                        load=true
                        whereClause=""
                        hideMaturedDeals=true
                      }
                      irs{
                        load=true
                        whereClause=""
                        hideMaturedDeals=true
                      }
                      swaption{
                        load=true
                        whereClause=""
                        hideMaturedDeals=true
                      }
                    }
                    insight {
                        service {
                            impl {
                                mtmreport {
                                    enableDataComputation={{ .Values.integration.kondor.insight.service.impl.mtmreport.enableDataComputation }}
                                    reportDatabase="{{ .Values.integration.kondor.insight.service.impl.mtmreport.reportDatabase }}"
                                    reportName="{{ .Values.integration.kondor.insight.service.impl.mtmreport.reportName }}"
                                    subReportName="{{ .Values.integration.kondor.insight.service.impl.mtmreport.subReportName }}"
                                    timeWaitingForFirstReport={{ .Values.integration.kondor.insight.service.impl.mtmreport.timeWaitingForFirstReport }}
                                    onReportFailureKeepListeningForNextReports={{ .Values.integration.kondor.insight.service.impl.mtmreport.onReportFailureKeepListeningForNextReports }}
                                }
                                simmreport {
                                    enableDataComputation={{ .Values.integration.kondor.insight.service.impl.simmreport.enableDataComputation }}
                                    reportDatabase="{{ .Values.integration.kondor.insight.service.impl.simmreport.reportDatabase }}"
                                    reportName="{{ .Values.integration.kondor.insight.service.impl.simmreport.reportName }}"
                                    subReportName="{{ .Values.integration.kondor.insight.service.impl.simmreport.subReportName }}"
                                    timeWaitingForFirstReport={{ .Values.integration.kondor.insight.service.impl.simmreport.timeWaitingForFirstReport }}
                                    onReportFailureKeepListeningForNextReports={{ .Values.integration.kondor.insight.service.impl.simmreport.onReportFailureKeepListeningForNextReports }}
                                }
                            }
                        }
                    }
                    soap {
                        locatorAddress="{{ .Values.integration.kondor.soap.locatorAddress }}"
                        useLocator="{{ .Values.integration.kondor.soap.useLocator }}"
                        kdewsFixedAddress="{{ .Values.integration.kondor.soap.kdewsFixedAddress }}"
                    }
                }
            }
        }
        ksg {
            asyncTimeout={{ .Values.ksg.asyncTimeout }}
            rvdDaemon="{{ .Values.ksg.rvdDaemon }}"
            rvdNetwork="{{ .Values.ksg.rvdNetwork }}"
            rvdService={{ .Values.ksg.rvdService }}
            rvdSubject="{{ .Values.ksg.rvdSubject }}"
            timeout={{ .Values.ksg.timeout }}
        }
        fcbo {
            crossassetdepo {
                domain {
                    impl {
                        sandbarDates=[
                            {{- range .Values.crossassetdepo.domain.impl.sandbarDates }}
                                {{ . }},
                            {{- end }}
                        ]
                        isInitialRun={{ .Values.crossassetdepo.domain.impl.isInitialRun }}
                    }
                }
            }
        }
    }
}
}
{{- end -}}