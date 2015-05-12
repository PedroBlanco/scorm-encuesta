# scorm-encuesta

** Atención: Software experimental, usar con cuidado **

Generador de encuestas anónimas empaquetadas en archivos SCORM y utilizables desde Moodle sobre Apache y MySQL.

## Introducción

Esta aplicación PHP sirve para generar encuestas anónimas. Las encuestas se componen de tres partes:
* Un paquete SCORM que se utiliza como actividad en un curso de Moodle.
* Un script PHP en el lado del servidor que recoge los datos de cada encuesta y las graba en la base de datos.
* Una base de datos MySQL que almacena los datos de las encuestas.

## Instalación y configuración

### Requisitos

* (Opcional) Instalación funcional de [Bitnami Wampstack/Lampstack/Xampstack](https://bitnami.com/).
  * Versión utilizada en desarrollo `wampstack-5.4.11-0`
  * En vez de Bitnami se puede usar cualquier Apache+MySQL+PHP si se modifican algunos valores.
* Instalación de [Smarty](http://www.smarty.net/)
  * Versión utilizada en desarrollo `Smarty 3.1.13`
  * Incluída en Bitnami (por confirmar).

### Instalación

1. En el directorio de Bitnami `apps` ejecutar:
`git clone ...`
2. Añadir a `httpd.conf` las siguientes líneas:
 * `CustomLog logs/access_log common env=!dontlog` Sólo debe aparecer una vez y sirve para no registrar los accesos a la encuesta anónima.
 * Añadir al final `Include "<Directorio de Bitnami>/apps/scorm-encuesta/conf/httpd-scorm-encuesta.conf"`, donde <Directorio de Bitnami> es el directorio de instalación de Bitnami (obviamente).
3. Editar los directorios (y resto de valores) de:
 * `conf/httpd-scorm-encuesta.conf`
 * `htdocs/generador/smarty/smarty_connect.php`

### Configuración

Los valores por defecto de los paquetes generados se configuran en `htdocs/generador/generador.php`.

## Sugerencias y posibles mejoras

* Disminuir el tamaño de la letra para que no ocupe tanto espacio.
* Aclarar el uso de la barra de desplazamiento para puntuar.

## Problemas técnicos a solucionar (por actualizar)

`event.returnValue is deprecated.
Please use the standard event.preventDefault() instead. jquery-1.9.1.js:3345`
> ???

`XMLHttpRequest cannot load http://localhost/encuesta-scorm/registro.php.
No 'Access-Control-Allow-Origin' header is present on the requested resource.
Origin 'http://localhost:82' is therefore not allowed access.`
> ¿Arreglado? en httpd-scorm-encuesta.conf - Configuración de CORS en el servidor
