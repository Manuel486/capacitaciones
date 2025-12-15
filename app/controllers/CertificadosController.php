<?php

require_once __DIR__ . "/../helpers/ApiRespuesta.php";
require_once __DIR__ . "/../helpers/AuthHelper.php";

require_once __DIR__ . "/../models/CursoUsuarioModel.php";

use \Firebase\JWT\JWT;
use \Firebase\JWT\Key;

class CertificadosController
{
    private $cursoUsuarioModel;
    public function __construct()
    {
        $this->cursoUsuarioModel = new CursoUsuarioModel();
    }

    public function apiObtenerCertificadoPorIdCursoIdUsuario()
    {
        if (
            !AuthHelper::verificarAccesoResponsable(
                ['mis_cursos'],
                'certificado',
                'Obtener certificado por ID de curso usuario'
            )
        ) {
            return;
        }

        $sesion = JWT::decode($_COOKIE['sepcon_session_token'], new Key(CLAVE_TOKEN, 'HS256'));

        $idCurso = $_GET['id_curso'] ?? null;

        if (!$idCurso) {
            echo ApiRespuesta::error("El parámetro 'id_curso' es obligatorio");
            return;
        }

        $certificado = $this->cursoUsuarioModel->obtenerCertificadoPorIdCursoIdUsuario($idCurso, $sesion->data->id);

        $rutaCertificado = CERTIFICADOS . $certificado . ".pdf";

        if (!file_exists($rutaCertificado)) {
            echo ApiRespuesta::error("Certificado no encontrado");
            return;
        }

        header('Content-Type: application/pdf');
        header('Content-Disposition: inline; filename="' . $certificado["nombre_curso"] . '.pdf"');
        readfile($rutaCertificado);
    }
}