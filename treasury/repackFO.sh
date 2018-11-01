rm treasury/charts/kondor-0.1.0.tgz
rm kondor/charts/*

helm package thirdparties/rendezvous
helm package kondor-servers/kserver
helm package kondor-servers/webaccess
helm package kondor-servers/portal-ems

mv rendezvous-0.1.0.tgz kondor/charts/
mv kserver-0.1.0.tgz kondor/charts/
mv portal-ems-0.1.0.tgz kondor/charts/
mv webaccess-0.1.0.tgz kondor/charts/

helm package kondor
mv kondor-0.1.0.tgz treasury/charts/
