# Microservices challengue

Este proyecto es un ecosistema de aplicaciones que se comunican por medio de http para obtener datos y generar diferentes interacciones, haciendo uso de las librerias integracion cloud de spring framework y docker. El ecosistema de aplicaciones consta de los siguientes componentes:

- config-server (spring)
- eureka-server (spring)
- api-gateway (spring)
- zipkin ( trazabilidad de logs)
- grafana ( graficas de rendimiento de los servicios )
- prometheus ( metricas de rendimiento de los servicios )
- keycloak server ( servidor de autorizacion )
- book-management-bff (bff, spring)
- rating-service (spring)
- book-service (spring)
- web-client (agular)

En el siguiente diagrama, se puede visualizar a grandes rasgos la arquitectura propuesta

![Container diagram for Internet Banking System](https://www.plantuml.com/plantuml/svg/jLLTRzis57tFh-2CFRJ070zPzp9WGDtOoO9ysF17ZEx5k9Ak9DOKgPAKZUJNxr9KLDfHMtlhdiIFUyyvz_2IUcyiQ5iLukmdBcDH9SXORcrf_XWCDEpECsxpAgeCwbX9YzAUnweOb0AaI-eRcmWU3IxVzQTkQNb_DoZ0MDIqjBwa3E0IzNbP4oIOqepTN4uUbhEx8sXiLKAYV_j2nsctdr94tvIQMpI3xSNvk_DVM-pH-D71ptyCU5DAWbktPrwnNFmlD1SjpzNaOJ5SZUUJ-_4FPQhNO8T65TZ__UNaWxe68BDAWFva_D5rH9JAs4oZ-IpMEwMJ0lJcgx65afbAeky7EfqowuxRisFWYc_4dPtT3JzEbelrOZ9TZoQhXpTlQMrA-qg-SN6_iDvbPImLgtiqdg8g1JARWsKICM6bLaaLMqERFtkd_kpL-BstPsqFlucKsjo3X0mBb7Q54K6zMdFuZNTkkCYH5PJEkBIeKuWRMalhSIF9xm7ninstUIYYFOKz8R6IAS_cgBU-jCd3rSqrcuzdZ-EP8_KcrfLgjUK9cffFu-UAQohNvrSQB5UIfLnGGAeqGuXpPWYMnnYgE3YKFIrOQTm0KOsNi_7jC53n2RQmfw51PWatiIBfJyToQB2qD_VfX3WRBcuUVC4tb-CEBbzl0XQOHW4MazfPvawBUJHpBBdB-KBzOJAv_PV4XXLjennB3YM_9fGTF177S7h3heUByMhuCQGUbfnbFeXPnNAGYK0MQsLClnRXJpn6BOylEarTiQGw4CreDIJ-0F6cxfjKA-bOhF8EdrpdAAfj7e6520msrAOsjdrbtEmbWkrorEXjzNRlk10iGcQiqfY4lE4xrStjEo9WdxKjqhltBrS7EHWLyzhTiAs-8QHz1BjLP1fIa414rtxKsn-EmEIH0btxNFf-OrocIXV-8aEaAljoompB4OJD3qWs-1GB1Hl2kss6lOFniBAvqlpPWpeur0Sen5wWpR4ollMRIQzhvgz5nHcKfU2nHwKAo0rkbVwEtcTURhWafB_hGIyOTQ9pkuzkDKW3iIVLy0mH5zm-CQZl1mCXMW74V3P3qVmmkXxxfN5HTL37TdXNmz3sNFTSkq8RvupcciU6fRJLX8TH-szFMGdXkxsEfnfi1Qv8b4bPAYwjwS3mVVbVKUZgdvHxm7hmnvgvid6Bfjdm_w3krFO7CyEC6rl_Beq56IDJiZibQF9749pq8hDgWv911YxRfwr7QYSFSr-_1GY96QmqjrzJsFQemKnZ1XJ8J0d49XFNTAIKqq05hNEwCMtYyRQibpxbH5lQfDEByvRk0xZ9j-qCByxnVeHvnzWHnfzQLfZghuA_uFJzQx6Opbk_WxYZxIQyq-gcXECAfi2J3_3EPvqaFZplJcTyM7XjkWBVeqogGlm3)]

En la siguiente tabla se encontraran los esquemas de despliegues para cada componente
| componente | docker url | local url |
| ------------------------ | :--------------------------: | ---------------------: |
| config-server | http://configserver:8071 | http://localhost:8071 |
| eureka-server | http://eurekaserver:10090 | http://localhost:10090 |
| apigateway | http://eurekaserver:8072 | http://localhost:8072 |
| zipkin | http://zipkin:9411 | http://localhost:9411 |
| books-service | http://books:10050 | http://localhost:10050 |
| books-service #replica1 | http://books-second:10051 | http://localhost:10051 |
| postgresql database | http://book-database:5432 | http://localhost:5450 |
| mongodb database | http://rating-database:27018 | http://localhost:27017 |
| rating-service | http://rating:11340 | http://localhost:11340 |
| rating-service #replica1 | http://rating-second:11341 | http://localhost:11341 |
| book-management-bff | http://bff:20120 | http://localhost:20210 |
| prometheus | http://prometheus:9090 | http://localhost:9090 |
| grafana | http://grafana:3000 | http://localhost:3000 |

Como podemos notar, tanto el servicio book-service como el de rating-service tienen replicas, esto para mejorar la disponibilidad del sistema, lo cual tambien brinda la oportunidad de usar balanceo de carga entre instancias. Esto ultimo se logro por medio del uso de la libreria openfeign que internamente hace uso de la libreria load-balancer, ambos del proyecto spring cloud.

Para correr el proyecto, se deben seguir los siguientes pasos:

1. Debemos clonar el siguiente repositorio para obtener los archivos de configuracion y el docker-compose

```
https://github.com/KingSatur/java_training-run-configurations.git
```

2. Debemos clonar todos los microservicios para poder ejecutarlos con el docker-compose, en este caso, les he proveido un .sh que les permite descargar los microservicios de manera que solo lo ejecuten y se descarguen todos los microservicios necesarios. Para ejecutarlo, basta con ubicarse en el directorio de repositorio java_training-run-configurations ( el cual acabamos de clonar ) y ejecutar por medio de la consola de comandos

```
./download_components.sh ----> #Linux o Mac
./download_components.bash ----> #Windows
```
