# scorm-encuesta

Generador de encuestas anónimas empaquetadas en archivos SCORM y utilizables desde Moodle (u otro LMS con soporte para SCORM) sobre Apache y MySQL.

Se pueden definir cuantas preguntas se quiera (del tipo valoración de 1 a 10). Todas las encuestas incluyen una pregunta "Comentario" al final de tipo texto libre y longitud 1000 caracteres.

## Introducción

Esta aplicación PHP sirve para generar encuestas anónimas. Las encuestas se componen de tres partes:
* Un paquete SCORM que se utiliza como actividad en un curso de Moodle.
  * Nota: El paquete SCORM generado no cumple del todo (o apenas) el estándar, al hacer referencia a recursos externos (acceso a la BD) y seguramente tenga otros problemas.
* Un script PHP en el lado del servidor que recoge los datos de cada encuesta y las graba en la base de datos.
* Una base de datos MySQL que almacena los datos de las encuestas.

Por ahora hay que tener los siguientes temas en cuenta:
* La aplicación no tiene control de acceso (ni usuario ni contraseña).
* Se pueden elegir las preguntas de la encuesta y organizarlas en pestañas. Todas las preguntas personalizables son del tipo valoración entre 1 y 10. Todas las encuestas incluyen una pregunta final de tipo texto libre y longitud 1000 caracteres.
* La parte que asegura el "anonimato" es la ausencia de guardado de logs por parte de Apache (se incluye configuración de ejemplo). Haciendo un seguimiento de las entradas en la BD y de los acceso a la actividad desde Moodle se podría saber quién responde qué y cómo. Por tanto es labor del administrador del sitio web configurar el sistema para garantizar en la medida de lo posible el anonimato.

## Instalación y configuración

### Requisitos de la aplicación

* Servidor web con soporte de PHP.
  * Se incluye configuración de ejemplo para Apache.
* Librería [Smarty](http://www.smarty.net/).

La máquina de desarrollo tiene las siguientes características:
* Servidor WAMP: [Bitnami Wampstack](https://bitnami.com/).
  * Versión utilizada en desarrollo `wampstack-5.4.11-0`
* Librería Smarty:
  * Versión utilizada en desarrollo `Smarty 3.1.13`.
  * Incluída en Bitnami.

### Requisitos del servidor receptor de la encuesta (donde reside el archivo PHP receptor)

* Servidor web con soporte de PHP.
  * Se incluye configuración de ejemplo para Apache.
* Servidor MySQL:
  * El script receptor utiliza MySQLi, pero se podría portar a otra librería (y otro servidor) y el SQL generado para definir la tabla y el usuario es genérico.

### Instalación

Usando un servidor Apache con soporte PHP:
1. En el directorio elegido ejecutar:
`git clone https://github.com/PedroBlanco/scorm-encuesta.git`
2. Añadir a la configuración de Apache la siguiente línea:
 * `CustomLog logs/access_log common env=!dontlog` - Sólo debe aparecer una vez y sirve para no registrar los accesos a la encuesta anónima.
 * Incluir el archivo `Include "<Ruta de la aplicación>/conf/httpd-scorm-encuesta.conf"` al final del archivo de configuración Apache.
3. Editar los directorios (y resto de valores) de los siguientes archivos (y crear una copia de ellos sin `.orig`):
 * `conf/httpd-scorm-encuesta.orig.conf`
 * `htdocs/generador/smarty/smarty_connect.orig.php`
4. Reiniciar Apache.

Usando [Bitnami WAMPStack/LAMPStack/MAMPStack](https://bitnami.com/).
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

Se pueden guardar todos los valores anteriores (excepto la contraseña) en el navegador para futuras visitas (mediante el API de HTML5 localStorage).

Los valores por defecto de la aplicación y de los paquetes generados se configuran en el archivo `htdocs/generador/generador.php`.

## Sugerencias y posibles mejoras

* Mirar las [incidencias abiertas](/../../issues).
* Interfaz de la encuesta:
  * [WISH]Disminuir el tamaño de la letra para que no ocupe tanto espacio, o aplicar diseño responsive.
  * Estudiar usar widgets más ligeros en vez de jQuery (que apenas si lo aprovechamos).
* Interfaz del generador:
  * Estudiar control de acceso
    * Mediante usuario y contraseña (es realmente necesario?).
* Generador:
  * [WISH]Estudiar la utilidad de no utilizar ficheros fuentes, sino construirlos sobre la marcha.
    * Ahora mismo no se aprecia una ventaja decisiva al construirlos sobre la marcha.
  * [WISH]Despliegue automático:
    * De la BD.
    * Del archivo PHP receptor al directorio de trabajo.
* Servidor:
  * [WISH]Abstraer configuración para no usar Bitnami, o incluso Apache.
* SCORM:
  * (Ver [#3](/../../issues/3))Comprobar el cumplimiento de los estándares (los que sean necesarios/recomendables).

## Problemas técnicos a solucionar (por actualizar)

`event.returnValue is deprecated.
Please use the standard event.preventDefault() instead. jquery-1.9.1.js:3345`
> ???

(Ver [#4](/../../issues/4)) `XMLHttpRequest cannot load http://localhost/encuesta-scorm/registro.php.
No 'Access-Control-Allow-Origin' header is present on the requested resource.
Origin 'http://localhost:82' is therefore not allowed access.`
> ¿Arreglado? en httpd-scorm-encuesta.conf - Configuración de CORS en el servidor
