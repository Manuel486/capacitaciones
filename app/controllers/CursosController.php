<?php

require_once __DIR__ . "/../models/CursoModel.php";
require_once __DIR__ . "/../helpers/ApiRespuesta.php";
require_once __DIR__ . "/../helpers/AuthHelper.php";

use \Firebase\JWT\JWT;
use \Firebase\JWT\Key;

class CursosController
{
    private $cursoModel;

    public function __construct()
    {
        $this->cursoModel = new CursoModel();
    }

    public function apiObtenerTodosLosCurso()
    {
        $cursos = $this->cursoModel->listarCursos();

        echo ApiRespuesta::exitoso($cursos, "Cursos obtenidos exitosamente");
    }

    public function apiObtenerEstructuraCurso()
    {
        if (
            !AuthHelper::verificarAccesoResponsable(
                ['tomar_curso'],
                'curso',
                'Obtener estructura del curso'
            )
        ) {
            return;
        }

        
        $secretKey = CLAVE_TOKEN;
        $sesion = JWT::decode($_COOKIE['sepcon_session_token'], new Key($secretKey, 'HS256'));


        $idCurso = $_GET['id_curso'] ?? null;

        if (!$idCurso) {
            echo ApiRespuesta::error("El parámetro 'id_curso' es obligatorio");
            return;
        }

        $idUsuario = $sesion->data->id;

        $estructura = $this->cursoModel->obtenerEstructuraCurso($idCurso, $idUsuario);

        if ($estructura) {
            echo ApiRespuesta::exitoso($estructura, "Estructura del curso obtenida exitosamente");
        } else {
            echo ApiRespuesta::error("Curso no encontrado");
        }
    }

    public function apiObtenerCursoPorId()
    {
        $idCurso = $_GET['id_curso'] ?? null;

        if (!$idCurso) {
            echo ApiRespuesta::error("El parámetro 'id_curso' es obligatorio");
            return;
        }

        $curso = $this->cursoModel->obtenerCursoPorId($idCurso);

        if (!empty($curso)) {
            echo ApiRespuesta::exitoso($curso, "Curso obtenido exitosamente");
        } else {
            echo ApiRespuesta::error("Curso no encontrado");
        }
    }

    public function apiCursoBuscarPorTermino()
    {
        $termino = $_POST['termino'] ?? '';

        if (empty($termino)) {
            echo ApiRespuesta::error("El parámetro 'termino' es obligatorio");
            return;
        }

        $cursos = $this->cursoModel->buscarCursos($termino);

        echo ApiRespuesta::exitoso($cursos, "Cursos encontrados exitosamente");
    }



}