# scorm-encuesta

:warning:**Atención: Software experimental, usar con cuidado**:warning:

Generador de encuestas anónimas empaquetadas en archivos SCORM y utilizables desde Moodle (u otro LMS con soporte para SCORM) sobre Apache y MySQL.

Las encuestas generadas tienen las mismas preguntas que las encuestas de los cursos de formación homologados por [Instituto Andaluz de Administración Pública (IAAP)](http://www.juntadeandalucia.es/haciendayadministracionpublica/).

**IMPORTANTE: Este organismo (IAAP) no es responsable de manera alguna de este paquete y no tiene relación con el mismo más allá de que las encuestas generadas contienen las mismas preguntas que las encuestas de las actividades de formación de dicho organismo. Además, no se garantiza ningún tipo de aceptación ni utilidad de los resultados derivados de las encuestas generadas por este software.**

## Introducción

Esta aplicación PHP sirve para generar encuestas anónimas. Las encuestas se componen de tres partes:
* Un paquete SCORM que se utiliza como actividad en un curso de Moodle.
  * Nota: El paquete SCORM generado no cumple del todo (o apenas) el estándar, al hacer referencia a recursos externos (acceso a la BD) y seguramente tenga otros problemas.
* Un script PHP en el lado del servidor que recoge los datos de cada encuesta y las graba en la base de datos.
* Una base de datos MySQL que almacena los datos de las encuestas.

Por ahora hay que tener los siguientes temas en cuenta:
* La aplicación no tiene control de acceso (ni usuario ni contraseña).
* FIXME: Las preguntas de las encuestas generadas son fijas y para editarlas hay que editar el código fuente:
  * Ver #2. En desarrollo la posibilidad de definir las preguntas, que serán de dos tipos: puntuación del 1 al 10 y texto libre.
* El generador sólo se ha probado en un servidor web local, aunque los paquetes generados sí ha entrado en producción.
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
  * [WISH]Disminuir el tamaño de la letra para que no ocupe tanto espacio, o aplicar diseño responsive.
  * [WISH]Ayuda contextual:
    * Aclarar el uso de la barra de desplazamiento para puntuar.
  * Estudiar usar widgets más ligeros en vez de jQuery (que apenas si lo aprovechamos).
* Interfaz del generador:
  * Estudiar control de acceso
    * Mediante usuario y contraseña (es realmente necesario?).
    * Acceso libre:
      * Tal vez podría almacenar datos en el cliente con localStorage (autor, URL del servidor, host de DB, conjuntos de preguntas personalizados, ...).
  * (Ver [#1](/../../issues/1)) Mejora visual del generador.
* Contenido de la encuesta:
  * (Ver [#2](/../../issues/2)) Separar las preguntas (y definir sus tipos) de la encuesta para que sea fácil cambiarlas.
* Generador:
  * [WISH]Estudiar la utilidad de no utilizar ficheros fuentes, sino construirlos sobre la marcha.
    * Ahora mismo no se aprecia una ventaja decisiva al construirlos sobre la marcha.
  * [WISH]Despliegue automático:
    * De la BD.
    * Del archivo PHP receptor al directorio de trabajo.
* Servidor:
  * [WISH]Abstraer configuración para no usar Bitnami, o incluso Apache.
  * [WISH]Comprobar que el SQL sea portable.
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
