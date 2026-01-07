<?php

require_once __DIR__ . "/../helpers/ApiRespuesta.php";
require_once __DIR__ . "/../helpers/AuthHelper.php";

use \Firebase\JWT\JWT;
use \Firebase\JWT\Key;

class ArchivosController
{
    public function __construct()
    {
    }

    public function apiObtenerArchivoPorNombre()
    {
        $nombreArchivo = $_GET['nombre'] ?? null;

        if (!$nombreArchivo) {
            echo ApiRespuesta::error("El parámetro 'nombre' es obligatorio");
            return;
        }

        $rutaArchivo = VIDEOS . $nombreArchivo;

        if (!file_exists($rutaArchivo)) {
            echo ApiRespuesta::error("Archivo no encontrado");
            return;
        }

        $extension = strtolower(pathinfo($rutaArchivo, PATHINFO_EXTENSION));
        $mimeTypes = [
            'pdf' => 'application/pdf',
            'ppt' => 'application/vnd.ms-powerpoint',
            'pptx' => 'application/vnd.openxmlformats-officedocument.presentationml.presentation',
            'xls' => 'application/vnd.ms-excel',
            'xlsx' => 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
            'doc' => 'application/msword',
            'docx' => 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
        ];

        $contentType = $mimeTypes[$extension] ?? 'application/octet-stream';

        header('Content-Description: File Transfer');
        header('Content-Type: ' . $contentType);
        header('Content-Disposition: inline; filename="' . basename($rutaArchivo) . '"');
        header('Expires: 0');
        header('Cache-Control: must-revalidate');
        header('Pragma: public');
        header('Content-Length: ' . filesize($rutaArchivo));
        readfile($rutaArchivo);
        exit;
    }
}