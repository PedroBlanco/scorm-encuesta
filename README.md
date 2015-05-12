# scorm-encuesta

** Atención: Software experimental, usar con cuidado **

Generador de encuestas anónimas empaquetadas en archivos SCORM y utilizables desde Moodle (u otro LMS con soporte para SCORM) sobre Apache y MySQL.

## Introducción

Esta aplicación PHP sirve para generar encuestas anónimas. Las encuestas se componen de tres partes:
* Un paquete SCORM que se utiliza como actividad en un curso de Moodle.
  * Nota: El paquete SCORM generado no cumple del todo (o apenas) el estándar, al hacer referencia a recursos externos (acceso a la BD) y seguramente tenga otros problemas.
* Un script PHP en el lado del servidor que recoge los datos de cada encuesta y las graba en la base de datos.
* Una base de datos MySQL que almacena los datos de las encuestas.

Por ahora hay que tener los siguientes temas en cuenta:
* La aplicación no tiene control de acceso (ni usuario ni contraseña).
* El generador sólo se ha probado en local, aunque los paquetes generados sí ha entrado en producción.
* La parte que asegura el "anonimato" es la ausencia de guardado de logs por parte de Apache. Haciendo un seguimiento de las entradas en la BD y de los acceso a la actividad desde Moodle se podría saber quién responde qué y cómo.

## Instalación y configuración

### Requisitos

* (Opcional) Instalación funcional de [Bitnami Wampstack/Lampstack/Xampstack](https://bitnami.com/).
  * Versión utilizada en desarrollo `wampstack-5.4.11-0`
  * En vez de Bitnami se puede usar cualquier Apache+MySQL+PHP si se modifican algunos valores.
* Instalación de [Smarty](http://www.smarty.net/) operativa
  * Versión utilizada en desarrollo `Smarty 3.1.13`
  * Incluída en Bitnami (por confirmar).

### Instalación

1. En el directorio `apps` de Bitnami ejecutar:
`git clone https://github.com/PedroBlanco/scorm-encuesta.git`
2. Añadir a `httpd.conf` de Bitnami las siguientes líneas:
 * `CustomLog logs/access_log common env=!dontlog` - Sólo debe aparecer una vez y sirve para no registrar los accesos a la encuesta anónima.
 * Añadir al final `Include "<Directorio de Bitnami>/apps/scorm-encuesta/conf/httpd-scorm-encuesta.conf"`, donde <Directorio de Bitnami> es el directorio de instalación de Bitnami (obviamente).
3. Editar los directorios (y resto de valores) de los siguientes archivos (y crear una copia de ellos sin `.orig`):
 * `conf/httpd-scorm-encuesta.orig.conf`
 * `htdocs/generador/smarty/smarty_connect.orig.php`
4. Reiniciar Apache.

### Configuración de la encuesta

El interfaz web permite configurar los siguientes valores:
* Denominación simple del formulario
* URL de destino de los datos
* Comentario
* Host de la BD
* Usuario de la BD
* Contraseña de la BD
* Nombre de la BD
* Nombre de la tabla de la BD
* Puerto de la BD

Los valores por defecto de la aplicación y de los paquetes generados se configuran en el archivo `htdocs/generador/generador.php`.

## Sugerencias y posibles mejoras

* Interfaz de la encuesta:
  * Disminuir el tamaño de la letra para que no ocupe tanto espacio, o aplicar diseño responsive.
  * Aclarar el uso de la barra de desplazamiento para puntuar.
  * Usar widgets más ligeros en vez de jQuery (que apenas si lo aprovechamos).
* Interfaz del generador:
  * Acceso mediante usuario y contraseña.
  * Mejora visual del generador.
* Generador:
  * No utilizar ficheros fuentes, sino construirlos sobre la marcha.
  * Despliegue automático:
    * De la BD.
    * Del archivo PHP receptor al directorio de trabajo.
* Servidor:
  * Abstraer configuración para no usar Bitnami, o incluso Apache.
  * Comprobar que el SQL sea portable.
* SCORM:
  * Comprobar el cumplimiento de los estándares (los que sean necesarios/recomendables).

## Problemas técnicos a solucionar (por actualizar)

`event.returnValue is deprecated.
Please use the standard event.preventDefault() instead. jquery-1.9.1.js:3345`
> ???

`XMLHttpRequest cannot load http://localhost/encuesta-scorm/registro.php.
No 'Access-Control-Allow-Origin' header is present on the requested resource.
Origin 'http://localhost:82' is therefore not allowed access.`
> ¿Arreglado? en httpd-scorm-encuesta.conf - Configuración de CORS en el servidor
