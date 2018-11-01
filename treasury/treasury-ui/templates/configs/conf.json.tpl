{{- define "conf.json" -}}
{
    "appName" : "misysboard",
    "port" : {{ .Values.service.port }},
    "model" : "./model",
    "data" : "./data",
    "maxMem" : "2048M",
    "home" : "./data/pm2",
    "addOnPath" : "./addons",
    "packagePath" : "./mb-package.json",
    "ssl" : true
}
{{- end -}}