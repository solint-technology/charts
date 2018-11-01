
https://www.json2yaml.com/
https://jsoneditoronline.org/

Collateral
Migration from docker-compose to kubernetes resources and helm chart

Docker compose
https://scm-git-eur.misys.global.ad/projects/TO/repos/treasury-compose/browse/treasury/collateral/docker-compose.yml

Configuration
template from
https://scm-git-eur.misys.global.ad/projects/BUIL/repos/config-service/browse/treasury/dev-lab-daal/collateral/cargo/server.conf.yatmpl


values from
https://scm-git-eur.misys.global.ad/projects/BUIL/repos/config-service/browse/treasury/dev-lab-daal/collateral/cargo.json

replace '{{ ' by '{{ .Values.' 
Then run: helm lint

```console
==> Linting .
[ERROR] templates/: parse error in "collateral/templates/configs/server.conf.tpl": template: collateral/templates/configs/server.conf.tpl:371: function "v" not defined

Error: 1 chart(s) linted, 1 chart(s) failed

C:\Dev\Work\git\helm\treasury\collateral>helm lint .
==> Linting .
[ERROR] templates/: parse error in "collateral/templates/configs/server.conf.tpl": template: collateral/templates/configs/server.conf.tpl:683: function "v" not defined

Error: 1 chart(s) linted, 1 chart(s) failed
```

for loop, replacement, use "range" function:

```console
{% for v in crossassetdepo.domain.impl.sandbarDates.values() %}
    {{v}},
{% endfor %}

{% for v in collateral.im.addon.fusionrisk.pnlCubeConfigurations.values() %}
{
   currencyId={{v.currencyId}},
   pnlCubeId={{v.pnlCubeId}}
}
{% endfor %}
```


```console                            
{{- range .Values.crossassetdepo.domain.impl.sandbarDates }}
   {{ . }},
{{- end }}

{{- range .Values.collateral.im.addon.fusionrisk.pnlCubeConfigurations }}
{
  currencyId={{ .currencyId }},
  pnlCubeId={{ .pnlCubeId }}
}
{{- end }}
```


transformation of value
"pnlCubeConfigurations": {
            "USD": {
              "currencyId": "USD",
              "pnlCubeId": "CubeIdA"
            },
            "EUR": {
              "currencyId": "EUR",
              "pnlCubeId": "CubeIdB"
            }
          }

to


  "pnlCubeConfigurations": [
           {
              "currencyId": "USD",
              "pnlCubeId": "CubeIdA"
            },
            {
              "currencyId": "EUR",
              "pnlCubeId": "CubeIdB"
            }
          ]


values transformation
        pnlCubeConfigurations:
            - currencyId: USD
              pnlCubeId: CubeIdA
            - currencyId: EUR
              pnlCubeId: CubeIdB
