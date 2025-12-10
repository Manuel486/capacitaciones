<?php

require_once __DIR__ . "/../helpers/ApiRespuesta.php";
require_once __DIR__ . "/../helpers/AuthHelper.php";

class CapacitacionesController
{
    public function __construct() {}

    public function vistaApp()
    {
        $vista = 'app';
        include VIEWS_PATH . '/app.php';
    }

    public function vistaInicio()
    {
        $vista = 'inicio';
        ob_start();
        include VIEWS_PATH . '/inicio.php';
        $contenido = ob_get_clean();
        include VIEWS_PATH . '/app.php';
    }

    public function vistaTomarCurso()
    {
        if (
            !AuthHelper::verificarAccesoVista(
                ['tomar_curso'],
                'tomar_curso',
                'Vista de Tomar Curso'
            )
        ) {
            return;
        }

        $vista = 'tomar_curso';
        ob_start();
        include VIEWS_PATH . '/tomar_curso.php';
        $contenido = ob_get_clean();
        include VIEWS_PATH . '/app.php';
    }

    public function vistaCursos()
    {
        $vista = 'cursos';
        ob_start();
        include VIEWS_PATH . '/cursos.php';
        $contenido = ob_get_clean();
        include VIEWS_PATH . '/app.php';
    }

    public function vistaCurso()
    {
        $vista = 'curso';
        ob_start();
        include VIEWS_PATH . '/curso.php';
        $contenido = ob_get_clean();
        include VIEWS_PATH . '/app.php';
    }

    public function vistaMisCursos()
    {
        if (
            !AuthHelper::verificarAccesoVista(
                ['mis_cursos'],
                'tomar_curso',
                'Vista de Tomar Curso'
            )
        ) {
            return;
        }

        $vista = 'mis_cursos';
        ob_start();
        include VIEWS_PATH . '/mis_cursos.php';
        $contenido = ob_get_clean();
        include VIEWS_PATH . '/app.php';
    }
}
