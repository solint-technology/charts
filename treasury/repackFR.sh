rm treasury/charts/fusion-risk-0.1.0.tgz 
rm fusion-risk/charts/*

helm package fusion-risk-services/frcmr 
helm package fusion-risk-services/frcargo
helm package thirdparties/rendezvous
helm package thirdparties/activeMQ

mv frcmr-0.1.0.tgz fusion-risk/charts/ 
mv frcargo-0.1.0.tgz fusion-risk/charts/
mv rendezvous-0.1.0.tgz fusion-risk/charts/
mv activeMQ-0.1.0.tgz fusion-risk/charts/

helm package fusion-risk 
mv fusion-risk-0.1.0.tgz treasury/charts/
