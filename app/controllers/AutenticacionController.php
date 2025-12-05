<?php

require_once __DIR__ . "/../models/UsuarioModel.php";
require_once __DIR__ . "/../models/AuditoriaLogger.php";
require_once __DIR__ . "/../helpers/ApiRespuesta.php";
require_once __DIR__ . "/../helpers/AuthHelper.php";

use \Firebase\JWT\JWT;
use \Firebase\JWT\Key;

class AutenticacionController
{
    private $usuarioModel;

    public function __construct()
    {
        $this->usuarioModel = new UsuarioModel();
    }

    public function login()
    {
        if ($_SERVER["REQUEST_METHOD"] == "POST") {
            $usuario = $_POST["usuario"] ?? '';
            $password = $_POST["password"] ?? '';

            $data = $this->usuarioModel->verificarExistenciaUsuario($usuario, $password);

            if (!empty($data["exitoso"])) {
                $secretKey = CLAVE_TOKEN;
                $payload = [
                    "iat" => time(),
                    "exp" => time() + 28800,
                    "data" => [
                        "apellidos" => $data["apellidos"],
                        "nombres" => $data["nombres"],
                        "dni" => $data["dni"],
                        "cargo" => $data["dcargo"],
                        "estado" => $data["estado"],
                        "id" => $data["internal"],
                        "accesos" => ["tomar_curso"]
                    ]
                ];

                $jwt = JWT::encode($payload, $secretKey, 'HS256');

                setcookie(
                    "sepcon_session_token",
                    $jwt,
                    [
                        "expires" => time() + 28800,
                        "path" => "/",
                        "secure" => true,
                        "httponly" => true,
                        "samesite" => "Lax"
                    ]
                );

                AuditoriaLogger::log(
                    "autenticacion",
                    "Login",
                    true,
                    "Inicio de sesión exitoso del responsable."
                );

                echo ApiRespuesta::exitoso(
                    $data,
                    "Inicio de sesión exitoso."
                );
            } else {
                AuditoriaLogger::log(
                    "autenticacion",
                    "Login",
                    false,
                    "Intento fallido de inicio de sesión: " . ($data["error"] ?? "desconocido")
                );

                echo ApiRespuesta::error($data["error"] ?? "Error desconocido al iniciar sesión.");
            }
        }
    }

    public function logout()
    {
        setcookie(
            "sepcon_session_token",
            "",
            [
                "expires" => time() - 30000,
                "path" => "/",
                "secure" => true,
                "httponly" => true,
                "samesite" => "Lax"
            ]
        );

        AuditoriaLogger::log(
            "autenticacion",
            "Logout",
            true,
            "El responsable cerró sesión correctamente."
        );

        echo ApiRespuesta::exitoso("Cierre de sesión exitoso.");
    }

    public function verificarToken()
    {
        if (!AuthHelper::verificarTokenGenerado("autenticacion", "Verificar Token")) {
            return;
        }

        // Acceder a la cookie y decodificar el token
        $token = $_COOKIE["sepcon_session_token"] ?? '';
        $secretKey = CLAVE_TOKEN;
        try {
            $decoded = JWT::decode($token, new Key($secretKey, 'HS256'));
            // $tokenValido = true;
            $respuesta = $decoded->data;
        } catch (Exception $e) {
            // $tokenValido = false;
            $respuesta = null;
        }

        echo ApiRespuesta::exitoso($respuesta, "Token Verificado", true, true);
    }
}