<?php

define("VIEWS_PATH", __DIR__ . "/../views/");
define("CONTROLLERS_PATH", __DIR__ . "/../controllers/");
define("PORTADAS", __DIR__ . "/../../public/assets/portadas/");
define("VIDEOS", __DIR__ . "/../videos/");
define("CERTIFICADOS", __DIR__ . "/../certificados/");
define("DATABASE_CAPACITACIONES_URL","mysql:dbname=capacitaciones;host=localhost");
define("DATABASE_CAPACITACIONES_USER","root");
define("DATABASE_CAPACITACIONES_PASSWORD","");
define("DATABASE_RRHH_URL","mysql:dbname=rrhh;host=localhost");
define("DATABASE_RRHH_USER","root");
define("DATABASE_RRHH_PASSWORD","");
define("DATABASE_AQUARIUS_URL","sqlsrv:Server=192.168.1.243,1433;Database=DB_SERPETBOL");
define("DATABASE_AQUARIUS_USER","sa");
define("DATABASE_AQUARIUS_PASSWORD","Abc123456");
define("DATABASE_DOCUMENTOS_URL","mysql:dbname=documentos;host=localhost");
define("DATABASE_DOCUMENTOS_USER","root");
define("DATABASE_DOCUMENTOS_PASSWORD","");
define("BASE_URL", "/capacitaciones/");

define('APP_VERSION', '1.0.4');

define('CLAVE_TOKEN', 'sepconRRHH2025');

define('RUTA_API_CORREO', 'http://179.49.67.42/master/inc/correoGenerico.inc.php');