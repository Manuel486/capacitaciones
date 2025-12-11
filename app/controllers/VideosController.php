<?php

require_once __DIR__ . "/../helpers/ApiRespuesta.php";
require_once __DIR__ . "/../helpers/AuthHelper.php";

use \Firebase\JWT\JWT;
use \Firebase\JWT\Key;

class VideosController
{
    public function __construct()
    {
    }

    public function apiObtenerVideoPorNombre()
    {
        if (
            !AuthHelper::verificarAccesoResponsable(
                ['tomar_curso'],
                'video',
                'Obtener video por ID'
            )
        ) {
            return;
        }

        $secretKey = CLAVE_TOKEN;
        $sesion = JWT::decode($_COOKIE['sepcon_session_token'], new Key($secretKey, 'HS256'));

        $idVideo = $_GET['nombre'] ?? null;

        if (!$idVideo) {
            echo ApiRespuesta::error("El parámetro 'nombre' es obligatorio");
            return;
        }

        $rutaVideo = VIDEOS . $idVideo;

        if (!file_exists($rutaVideo)) {
            echo ApiRespuesta::error("Video no encontrado");
            return;
        }

        $this->streamVideo($rutaVideo);
    }

    private function streamVideo($filePath)
    {
        $fileSize = filesize($filePath);
        $start = 0;
        $end = $fileSize - 1;

        header('Content-Type: video/mp4');
        header('Accept-Ranges: bytes');

        if (isset($_SERVER['HTTP_RANGE'])) {
            $range = $_SERVER['HTTP_RANGE'];
            $range = str_replace('bytes=', '', $range);
            $range = explode('-', $range);
            
            $start = intval($range[0]);
            if (isset($range[1]) && $range[1] != '') {
                $end = intval($range[1]);
            }

            if ($start > $end || $start >= $fileSize || $end >= $fileSize) {
                header("HTTP/1.1 416 Requested Range Not Satisfiable");
                header("Content-Range: bytes */$fileSize");
                exit;
            }

            header('HTTP/1.1 206 Partial Content');
            header("Content-Range: bytes $start-$end/$fileSize");
        } else {
            header('HTTP/1.1 200 OK');
        }

        $length = $end - $start + 1;
        header("Content-Length: $length");

        $fp = fopen($filePath, 'rb');
        fseek($fp, $start);

        $buffer = 1024 * 8; // 8KB buffer
        while (!feof($fp) && ($pos = ftell($fp)) <= $end) {
            if ($pos + $buffer > $end) {
                $buffer = $end - $pos + 1;
            }
            echo fread($fp, $buffer);
            flush();
        }

        fclose($fp);
        exit;
    }
}