<?php

require_once __DIR__ . "/../models/CursoModel.php";
require_once __DIR__ . "/../helpers/ApiRespuesta.php";
require_once __DIR__ . "/../helpers/AuthHelper.php";
require_once __DIR__ . "/../helpers/generarIdUnico.php";

date_default_timezone_set('America/Lima');

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

    public function apiObtenerTodosLosCursosTop()
    {
        $cursos = $this->cursoModel->listarCursosTop();

        echo ApiRespuesta::exitoso($cursos, "Cursos top obtenidos exitosamente");
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

        if (!empty($_POST['usuarios'])) {
            $usuarios = json_decode($_POST['usuarios'], true);
        } else {
            $usuarios = [];
        }

        if (!$datosCurso) {
            echo ApiRespuesta::error("Datos de curso inválidos");
            return;
        }

        $portada = $_FILES['imagen'] ?? null;

        if ($portada && $portada['error'] === UPLOAD_ERR_OK) {
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
            $idCurso = $this->cursoModel->editarCurso($datosCurso, $usuarios);
        } else {
            $idCurso = $this->cursoModel->crearNuevoCurso($datosCurso, $usuarios);
        }

        if ($idCurso) {
            echo ApiRespuesta::exitoso($idCurso, "Curso actualizado exitosamente");
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
            $extension = pathinfo($video['name'], PATHINFO_EXTENSION);
            $identificadorUnico = generarIdUnico('');
            $nombreArchivo = $identificadorUnico . '.' . $extension;
            $rutaDestino = VIDEOS . $nombreArchivo;
            $nombreArchivoPdf = $identificadorUnico . '.pdf';

            if (move_uploaded_file($video['tmp_name'], $rutaDestino)) {
                if (strtolower($extension) === 'pptx') {
                    
                    $rutaDestinoPdf = VIDEOS . $nombreArchivoPdf;

                    $libreOfficePath = '"C:\\Program Files\\LibreOffice\\program\\soffice.exe"';
                    $comando = $libreOfficePath . ' --headless --convert-to pdf:writer_pdf_Export --outdir ' . escapeshellarg(VIDEOS) . ' ' . escapeshellarg($rutaDestino);
                    exec($comando, $output, $returnCode);

                    unlink($rutaDestino);
                    $datosClase['video'] = $nombreArchivoPdf;
                } else {
                    $datosClase['video'] = $nombreArchivo;
                }
            }
        }

        if ($datosClase['id_clase']) {
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

        if ($datosTema['id_tema']) {
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

        if ($datosAnuncio['id_anuncio']) {
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

    public function apiGuardarEvaluacion()
    {
        if (
            !AuthHelper::verificarAccesoResponsable(
                ['gestionar_cursos'],
                'gestionar_cursos',
                'Guardar nueva evaluación'
            )
        ) {
            return;
        }

        $secretKey = CLAVE_TOKEN;
        $sesion = JWT::decode($_COOKIE['sepcon_session_token'], new Key($secretKey, 'HS256'));

        if (!empty($_POST['evaluacion'])) {
            $datosEvaluacion = json_decode($_POST['evaluacion'], true);
        } else {
            $datosEvaluacion = null;
        }

        if (!$datosEvaluacion) {
            echo ApiRespuesta::error("Datos de evaluación inválidos");
            return;
        }

        if ($datosEvaluacion['id_evaluacion']) {
            $evaluacion = $this->cursoModel->editarEvaluacion($datosEvaluacion);
        } else {
            $evaluacion = $this->cursoModel->guardarEvaluacion($datosEvaluacion);
        }

        if ($evaluacion) {
            echo ApiRespuesta::exitoso($evaluacion, "Cambios guardados exitosamente");
        } else {
            echo ApiRespuesta::error("Error al guardar la evaluación");
        }
    }

    public function apiCambiarEstadoCurso()
    {
        if (
            !AuthHelper::verificarAccesoResponsable(
                ['gestionar_cursos'],
                'gestionar_cursos',
                'Cambiar estado del curso'
            )
        ) {
            return;
        }

        $secretKey = CLAVE_TOKEN;
        $sesion = JWT::decode($_COOKIE['sepcon_session_token'], new Key($secretKey, 'HS256'));

        $idCurso = $_POST['id_curso'] ?? null;
        $nuevoEstado = $_POST['activo'] ?? null;

        if ($idCurso === null || $nuevoEstado === null) {
            echo ApiRespuesta::error("Parámetros 'id_curso' y 'activo' son obligatorios");
            return;
        }

        $resultado = $this->cursoModel->cambiarEstadoCurso($idCurso, $nuevoEstado);

        if ($resultado) {
            echo ApiRespuesta::exitoso(null, "Estado del curso cambiado exitosamente");
        } else {
            echo ApiRespuesta::error("Error al cambiar el estado del curso");
        }
    }

    public function apiCambiarEstadoItem()
    {
        if (
            !AuthHelper::verificarAccesoResponsable(
                ['gestionar_cursos'],
                'gestionar_cursos',
                'Cambiar estado del ítem'
            )
        ) {
            return;
        }

        $secretKey = CLAVE_TOKEN;
        $sesion = JWT::decode($_COOKIE['sepcon_session_token'], new Key($secretKey, 'HS256'));

        $idItem = $_POST['id_item'] ?? null;
        $nuevoEstado = $_POST['activo'] ?? null;

        if ($idItem === null || $nuevoEstado === null) {
            echo ApiRespuesta::error("Parámetros 'id_item' y 'activo' son obligatorios");
            return;
        }

        $resultado = $this->cursoModel->cambiarEstadoItem($idItem, $nuevoEstado);

        if ($resultado) {
            echo ApiRespuesta::exitoso(null, "Estado del ítem cambiado exitosamente");
        } else {
            echo ApiRespuesta::error("Error al cambiar el estado del ítem");
        }
    }

    public function apiObtenerComentariosPorItemId()
    {
        $idItem = $_GET['id_item'] ?? null;

        if (!$idItem) {
            echo ApiRespuesta::error("El parámetro 'id_item' es obligatorio");
            return;
        }

        $comentarios = $this->cursoModel->obtenerComentariosPorItemId($idItem);

        echo ApiRespuesta::exitoso($comentarios, "Comentarios obtenidos exitosamente");
    }

    public function apiGuardarComentario()
    {
        $secretKey = CLAVE_TOKEN;
        $sesion = JWT::decode($_COOKIE['sepcon_session_token'], new Key($secretKey, 'HS256'));

        if (!empty($_POST['id_item'])) {
            $idItem = $_POST['id_item'];
        } else {
            echo ApiRespuesta::error("El parámetro 'id_item' es obligatorio");
            return;
        }

        if (!empty($_POST['comentario'])) {
            $comentario = $_POST['comentario'];
        } else {
            echo ApiRespuesta::error("El parámetro 'comentario' es obligatorio");
            return;
        }

        $datosComentario = [
            'id_item' => $idItem,
            'dni_usuario' => $sesion->data->dni,
            'nombre_usuario' => $sesion->data->apellidos . ' ' . $sesion->data->nombres,
            'comentario' => $comentario,
            'fecha_creacion' => date('Y-m-d H:i:s')
        ];

        $comentario = $this->cursoModel->guardarComentario($datosComentario);

        if ($comentario) {
            echo ApiRespuesta::exitoso($comentario, "Comentario guardado exitosamente");
        } else {
            echo ApiRespuesta::error("Error al guardar el comentario");
        }
    }

    public function apiGuardarValoracionCurso()
    {
        if (
            !AuthHelper::verificarAccesoResponsable(
                ['gestionar_cursos'],
                'gestionar_cursos',
                'Cambiar estado del ítem'
            )
        ) {
            return;
        }
        $secretKey = CLAVE_TOKEN;
        $sesion = JWT::decode($_COOKIE['sepcon_session_token'], new Key($secretKey, 'HS256'));
        $idCurso = $_POST['id_curso'] ?? null;
        $valoracion = $_POST['valoracion'] ?? null;
        $comentario = $_POST['comentario'] ?? '';

        if ($idCurso === null || $valoracion === null) {
            echo ApiRespuesta::error("Parámetros 'id_curso' y 'valoracion' son obligatorios");
            return;
        }

        $resultado = $this->cursoModel->guardarValoracionCurso($idCurso, $sesion->data->dni, $valoracion, $comentario, $sesion->data->nombres . ' ' . $sesion->data->apellidos);

        if ($resultado) {
            $valoraciones = $this->cursoModel->obtenerValoracionesPorCursoId($idCurso);
            echo ApiRespuesta::exitoso($valoraciones, "Valoración del curso guardada exitosamente");
        } else {
            echo ApiRespuesta::error("Error al guardar la valoración del curso");
        }
    }


}