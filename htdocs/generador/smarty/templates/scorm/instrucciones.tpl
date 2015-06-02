# Encuesta SCORM "{$params.target}"

Encuesta anónima empaquetada en archivo SCORM y utilizable desde Moodle (u otro LMS con soporte para SCORM), generada por ["Generador de Encuestas SCORM v{$dato['GENERATOR_VERSION']}"](https://github.com/PedroBlanco/scorm-encuesta)

## Contenido del archivo

Esta archivo contiene todos los componentes necesarios para utilizar la encuesta generada:

* Un paquete SCORM (`{$package_files_array['scorm'][0]}`) que se utiliza como actividad en un curso de Moodle.
  * Nota: El paquete SCORM generado no cumple del todo (o apenas) el estándar, al hacer referencia a recursos externos (acceso a la BD) y seguramente tenga otros problemas.
* Un script PHP (`{$package_files_array['php'][0]}`) en el lado del servidor que recoge los datos de cada encuesta y las graba en la base de datos. Debe ser accesible en la URL {$params.target_url}
* Definición de la base de datos MySQL (`{$package_files_array['sql_table'][0]}`) que almacena los datos de las encuestas y del usuario (`{$package_files_array['sql_user'][0]}`) con acceso a la misma.

El paquete SCORM contiene un formulario HTML con las preguntas de la encuesta. Al pulsar "Enviar encuesta" el formulario envía mediante una petición `POST` al script PHP (mediante una petición `XmlHttpRequest`) que se encarga a su vez de guardar los datos recibidos en una base de datos. Además de las preguntas definidas en el generador, todas las encuestas incluyen una pregunta "Comentarios" al final de cada una, de tipo texto libre y longitud 1000 caracteres.

## Instalación y configuración

### Requisitos del servidor

* Servidor web con soporte de PHP.
  * Más adelante se incluyen los parámetros de configuración para el servidor Apache.
* Servidor de base de datos MySQL:
  * Ver los archivos `{$package_files_array['sql_table'][0]}` y `{$package_files_array['sql_user'][0]}` para la definición de la tabla donde se almacenan los datos y el usuario utilizado para insertarlos (respectivamente).
  * Nota: El script receptor PHP utiliza MySQLi para comunicarse con MySQL, pero se podría portar a otra librería (y otro sistema de base de datos), pues el SQL generado para definir la tabla y el usuario es genérico.
* Opcional: Instalación local de Moodle.
  * Es altamente recomendable que tanto el script PHP como la base de datos MySQL residan en el mismo servidor que la instalación de Moodle, puesto que los datos de la encuesta no se transmiten cifrados.

### Instalación

1. Copiar el script PHP `{$package_files_array['php'][0]}` a la carpeta del servidor apropiada para ser accesible mediante la URL `{$params.target_url}`
2. Configurar Apache:
  1. Añadir la siguiente línea a la configuración de Apache:
    * `CustomLog logs/access_log common env=!dontlog`
      * Sólo debe aparecer una vez y sirve para no registrar los accesos a la script PHP.
  2. Añadir a la sección de la carpeta donde reside el script PHP la siguiente línea:
    * `SetEnvIf Request_Method "POST" dontlog`
      * Esta línea evita que el servidor Apache registre en sus logs datos sobre las respuestas de la encuesta, lo que da cierto anonimato a las encuestas (siempre y cuando se configure así).
3. Reiniciar Apache.
4. Crear la base de datos y la tabla mediante el archivo `{$package_files_array['sql_table'][0]}`
5. Crear el usuario de acceso a la base de datos mediante el archivo `{$package_files_array['sql_user'][0]}`
6. En Moodle, añadir el archivo SCORM `{$package_files_array['scorm'][0]}` como actividad del curso con la siguiente configuración:
  * **TODO**

## Notas importantes

* El script PHP no tiene control de acceso (ni usuario ni contraseña), por lo que el directorio donde resida debería tener desactivado los índices.
* La parte que asegura el "anonimato" es la ausencia de guardado de logs por parte de Apache. Haciendo un seguimiento de las entradas en la BD y de los acceso a la actividad desde Moodle se podría saber quién responde qué y cómo. Por tanto es labor del administrador del sitio web configurar el sistema para garantizar en la medida de lo posible el anonimato.
