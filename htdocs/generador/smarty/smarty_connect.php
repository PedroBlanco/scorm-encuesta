<?php

// load Smarty library
require('Smarty.class.php');

class smarty_connect extends Smarty
{
    function __construct()
    {
    // Class Constructor.
    // These automatically get set with each new instance.
        parent::__construct();

        $_root = 'C:/BitNami/wampstack-5.4.11-0/apps/scorm-encuesta';
        $this->template_dir = "$_root/htdocs/generador/smarty/templates";
        $this->config_dir = "$_root/htdocs/generador/smarty/config";
        $this->compile_dir = "$_root/smarty/templates_c";
        $this->cache_dir = "$_root/smarty/cache";

        $this->caching = Smarty::CACHING_OFF;

        // Variable para definir nombre global de la aplicacion (aunque no es necesario)
        $this->assign('app_name', 'Generador de paquetes SCORM de Encuestas An&oacute;nimas');
    }
}
