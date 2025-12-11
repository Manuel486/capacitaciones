<?php

require_once '../app/config/config.local.php';
// require_once '../app/config/config.prod.php';

require __DIR__ . '/../vendor/autoload.php';

$router = new AltoRouter();
$router->setBasePath('/capacitaciones');

// Función auxiliar para registrar rutas
function route($router, $metodo, $path, $controlador, $accion) {
    $router->map($metodo, $path, function () use ($controlador, $accion) {
        require_once CONTROLLERS_PATH . "/{$controlador}.php";
        $ctrl = new $controlador();
        $ctrl->$accion();
    });
}
   
$router->map('GET', '/', function () {
    header('Location: /capacitaciones/inicio');
    exit;
});

// =============== AUTENTICACION CONTROLLER ===============
route($router, 'POST', '/login', 'AutenticacionController', 'login');
route($router, 'GET', '/logout', 'AutenticacionController', 'logout');
route($router, 'GET', '/verificar_token', 'AutenticacionController', 'verificarToken');


// =============== CAPACITACIONES CONTROLLER ===============
// route($router, 'GET', '/app', 'CapacitacionesController', 'vistaApp');
route($router, 'GET', '/inicio', 'CapacitacionesController', 'vistaInicio');
route($router, 'GET', '/tomar_curso', 'CapacitacionesController', 'vistaTomarCurso');
route($router, 'GET', '/curso', 'CapacitacionesController', 'vistaCurso');
route($router, 'GET', '/cursos', 'CapacitacionesController', 'vistaCursos');
route($router, 'GET', '/mis_cursos', 'CapacitacionesController', 'vistaMisCursos');
route($router, 'GET', '/gestionar_cursos', 'CapacitacionesController', 'vistaGestionarCursos');
route($router, 'GET', '/formulario_curso', 'CapacitacionesController', 'vistaFormularioCurso');


// =============== CURSOS CONTROLLER ===============
route($router, 'GET', '/api/cursos', 'CursosController', 'apiObtenerTodosLosCurso');
route($router, 'GET', '/api/curso_detalle', 'CursosController', 'apiObtenerCursoPorId');
route($router, 'GET', '/api/curso', 'CursosController', 'apiObtenerCursoFormularioPorId');
route($router, 'GET', '/api/curso_estructura', 'CursosController', 'apiObtenerEstructuraCurso');
route($router, 'POST', '/api/cursos/buscar', 'CursosController', 'apiCursoBuscarPorTermino');
route($router, 'POST', '/api/mis_cursos', 'CursoUsuarioController', 'apiMisCursos');
route($router, 'POST', '/api/formulario_curso', 'CursosController', 'apiFormularioCurso');

// =============== CURSO USUARIO CONTROLLER ===============
route($router, 'POST', '/api/marcar_completado', 'CursoUsuarioController', 'apiMarcarItemCompletado');
route($router, 'GET', '/api/obtener_cursos_creados', 'CursoUsuarioController', 'apiObtenerCursosCreados');

// =============== USUARIO CONTROLLER ===============
route($router, 'GET', '/api/obtener_todos_usuarios', 'UsuariosController', 'apiObtenerTodosLosUsuarios');

$match = $router->match();

if ($match && is_callable($match['target'])) {
    call_user_func_array($match['target'], $match['params']);
} else {
    header($_SERVER["SERVER_PROTOCOL"] . ' 404 Not Found');
    include_once VIEWS_PATH . '/404.php';
}
