<?php

require_once __DIR__ . "/../models/CursoUsuarioModel.php";
require_once __DIR__ . "/../helpers/ApiRespuesta.php";
require_once __DIR__ . "/../helpers/AuthHelper.php";

use \Firebase\JWT\JWT;
use \Firebase\JWT\Key;
class CursoUsuarioController
{
    private $cursoUsuarioModel;

    public function __construct()
    {
        $this->cursoUsuarioModel = new CursoUsuarioModel();
    }

    public function apiMisCursos()
    {
        if (
            !AuthHelper::verificarAccesoResponsable(
                ['mis_cursos'],
                'curso',
                'Obtener estructura del curso'
            )
        ) {
            return;
        }

        $sesion = JWT::decode($_COOKIE['sepcon_session_token'], new Key(CLAVE_TOKEN, 'HS256'));

        $cursos = $this->cursoUsuarioModel->obtenerMisCursos($sesion->data->id);

        echo ApiRespuesta::exitoso($cursos, "Mis cursos obtenidos exitosamente");
    }

    public function apiMarcarItemCompletado()
    {
        if (
            !AuthHelper::verificarAccesoResponsable(
                ['tomar_curso'],
                'tomar_curso',
                'Marcar ítem como completado'
            )
        ) {
            return;
        }

        $sesion = JWT::decode($_COOKIE['sepcon_session_token'], new Key(CLAVE_TOKEN, 'HS256'));


        $itemId = $_POST['item_id'] ?? null;
        $cursoUsuarioId = $_POST['curso_usuario_id'] ?? null;
        $nota = $_POST['nota'] ?? null;
        $nota_minima_aprobatoria = $_POST['nota_minima_aprobatoria'] ?? null;

        if (!$itemId || !$cursoUsuarioId) {
            echo ApiRespuesta::error("Los parámetros 'item_id' y 'curso_usuario_id' son obligatorios");
            return;
        }
        $actualizado = $this->cursoUsuarioModel->marcarItemCompletado($itemId, $cursoUsuarioId, $sesion->data, $nota, $nota_minima_aprobatoria);

        echo ApiRespuesta::exitoso($actualizado, "Marcaddo como completado exitosamente");
    }

    public function apiObtenerCursosCreados()
    {
        if (
            !AuthHelper::verificarAccesoResponsable(
                ['gestionar_cursos'],
                'gestionar_cursos',
                'Obtener cursos creados'
            )
        ) {
            return;
        }

        $secretKey = CLAVE_TOKEN;
        $sesion = JWT::decode($_COOKIE['sepcon_session_token'], new Key($secretKey, 'HS256'));

        $cursos = $this->cursoUsuarioModel->obtenerCursosCreadosPorUsuario($sesion->data->dni);

        echo ApiRespuesta::exitoso($cursos, "Cursos creados obtenidos exitosamente");
    }

}