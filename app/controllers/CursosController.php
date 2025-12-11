<?php

require_once __DIR__ . "/../models/CursoModel.php";
require_once __DIR__ . "/../helpers/ApiRespuesta.php";
require_once __DIR__ . "/../helpers/AuthHelper.php";
require_once __DIR__ . "/../helpers/generarIdUnico.php";

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

    public function apiFormularioCurso()
    {
        if (
            !AuthHelper::verificarAccesoResponsable(
                ['gestionar_cursos'],
                'gestionar_cursos',
                'Guardar nuevo curso'
            )
        ) {
            return;
        }

        $secretKey = CLAVE_TOKEN;
        $sesion = JWT::decode($_COOKIE['sepcon_session_token'], new Key($secretKey, 'HS256'));

        $modoEdicion = isset($_POST['editar']) ? filter_var($_POST['editar'], FILTER_VALIDATE_BOOLEAN) : false;

        if (!empty($_POST['curso'])) {
            $datosCurso = json_decode($_POST['curso'], true);
        } else {
            $datosCurso = null;
        }

        if (!empty($_POST['ids_usuarios'])) {
            $idUsuarios = json_decode($_POST['ids_usuarios'], true);
        } else {
            $idUsuarios = [];
        }

        if (!$datosCurso) {
            echo ApiRespuesta::error("Datos de curso inválidos");
            return;
        }

        $portada = $_FILES['imagen'] ?? null;

        if ($portada && $portada['error'] === UPLOAD_ERR_OK) {
            // Obtener la extensión del archivo
            $extension = pathinfo($portada['name'], PATHINFO_EXTENSION);
            $nombreArchivo = generarIdUnico('PORTADA_') . '.' . $extension;
            $rutaDestino = PORTADAS . $nombreArchivo;
            if (move_uploaded_file($portada['tmp_name'], $rutaDestino)) {
                $datosCurso['imagen'] = $nombreArchivo;
            }
        }

        $datosCurso['imagen'] = $nombreArchivo ?? $datosCurso['imagen'] ?? null;
        $datosCurso['id_autor'] = $sesion->data->dni;

        if ($modoEdicion) {
            $idCurso = $this->cursoModel->editarCurso($datosCurso, $idUsuarios);
        } else {
            $idCurso = $this->cursoModel->crearNuevoCurso($datosCurso, $idUsuarios);
        }

        if ($idCurso) {
            echo ApiRespuesta::exitoso($idCurso, "Curso creado exitosamente");
        } else {
            echo ApiRespuesta::error("Error al crear el curso");
        }
    }

    public function apiObtenerCursoFormularioPorId()
    {
        $idCurso = $_GET['id_curso'] ?? null;

        if (!$idCurso) {
            echo ApiRespuesta::error("El parámetro 'id_curso' es obligatorio");
            return;
        }

        $curso = $this->cursoModel->obtenerCursoFormularioPorId($idCurso);

        if (!empty($curso)) {
            echo ApiRespuesta::exitoso($curso, "Curso obtenido exitosamente");
        } else {
            echo ApiRespuesta::error("Curso no encontrado");
        }
    }

    public function apiGuardarClase()
    {
        if (
            !AuthHelper::verificarAccesoResponsable(
                ['gestionar_cursos'],
                'gestionar_cursos',
                'Guardar nueva clase'
            )
        ) {
            return;
        }

        $secretKey = CLAVE_TOKEN;
        $sesion = JWT::decode($_COOKIE['sepcon_session_token'], new Key($secretKey, 'HS256'));

        if (!empty($_POST['clase'])) {
            $datosClase = json_decode($_POST['clase'], true);
        } else {
            $datosClase = null;
        }

        if (!$datosClase) {
            echo ApiRespuesta::error("Datos de clase inválidos");
            return;
        }

        $video = $_FILES['video'] ?? null;

        if ($video && $video['error'] === UPLOAD_ERR_OK) {
            // Obtener la extensión del archivo
            $extension = pathinfo($video['name'], PATHINFO_EXTENSION);
            $nombreArchivo = generarIdUnico('VIDEO_') . '.' . $extension;
            $rutaDestino = VIDEOS . $nombreArchivo;
            if (move_uploaded_file($video['tmp_name'], $rutaDestino)) {
                $datosClase['video'] = $nombreArchivo;
            }
        }

        if($datosClase['id_clase']) {
            $clase = $this->cursoModel->editarClase($datosClase);
        } else {
            $clase = $this->cursoModel->guardarClase($datosClase);
        }

        if ($clase) {
            echo ApiRespuesta::exitoso($clase, "Cambios guardados exitosamente");
        } else {
            echo ApiRespuesta::error("Error al guardar la clase");
        }
    }

    public function apiGuardarTema()
    {
        if (
            !AuthHelper::verificarAccesoResponsable(
                ['gestionar_cursos'],
                'gestionar_cursos',
                'Guardar nuevo tema'
            )
        ) {
            return;
        }

        $secretKey = CLAVE_TOKEN;
        $sesion = JWT::decode($_COOKIE['sepcon_session_token'], new Key($secretKey, 'HS256'));

        if (!empty($_POST['tema'])) {
            $datosTema = json_decode($_POST['tema'], true);
        } else {
            $datosTema = null;
        }

        if (!$datosTema) {
            echo ApiRespuesta::error("Datos de tema inválidos");
            return;
        }

        if($datosTema['id_tema']) {
            $tema = $this->cursoModel->editarTema($datosTema);
        } else {
            $tema = $this->cursoModel->guardarTema($datosTema);
        }

        if ($tema) {
            echo ApiRespuesta::exitoso($tema, "Cambios guardados exitosamente");
        } else {
            echo ApiRespuesta::error("Error al guardar el tema");
        }
    }

    public function apiGuardarAnuncio()
    {
        if (
            !AuthHelper::verificarAccesoResponsable(
                ['gestionar_cursos'],
                'gestionar_cursos',
                'Guardar nuevo anuncio'
            )
        ) {
            return;
        }

        $secretKey = CLAVE_TOKEN;
        $sesion = JWT::decode($_COOKIE['sepcon_session_token'], new Key($secretKey, 'HS256'));

        if (!empty($_POST['anuncio'])) {
            $datosAnuncio = json_decode($_POST['anuncio'], true);
        } else {
            $datosAnuncio = null;
        }

        if (!$datosAnuncio) {
            echo ApiRespuesta::error("Datos de anuncio inválidos");
            return;
        }

        if($datosAnuncio['id_anuncio']) {
            $anuncio = $this->cursoModel->editarAnuncio($datosAnuncio);
        } else {
            $anuncio = $this->cursoModel->guardarAnuncio($datosAnuncio);
        }

        if ($anuncio) {
            echo ApiRespuesta::exitoso($anuncio, "Cambios guardados exitosamente");
        } else {
            echo ApiRespuesta::error("Error al guardar el anuncio");
        }
    }



}