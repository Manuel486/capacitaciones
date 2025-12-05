<?php

require_once __DIR__ . "/database/ConexionCapacitaciones.php";

use Firebase\JWT\JWT;
use Firebase\JWT\Key;

class AuditoriaLogger
{
    public static function log(
        string $modulo,
        string $accion,
        bool $exito,
        ?string $mensaje = null,
        ?string $tabla_afectada = null,
        ?string $id_afectado = null
    ) {
        $secretKey = CLAVE_TOKEN;
        $idUsuario = null;

        try {
            if (!empty($_COOKIE['responsable_auth_token'])) {
                $user = JWT::decode($_COOKIE['responsable_auth_token'], new Key($secretKey, 'HS256'));
                $idUsuario = $user->data->id ?? null;
            } elseif (!empty($_COOKIE['postulante_auth_token'])) {
                $user = JWT::decode($_COOKIE['postulante_auth_token'], new Key($secretKey, 'HS256'));
                $idUsuario = $user->data->idreg ?? null;
            }
        } catch (\Exception $e) {
            error_log("JWT inválido o expirado: " . $e->getMessage());
        }

        $pdo = ConexionCapacitaciones::getInstancia()->getConexion();

        try {
            $sql = "INSERT INTO auditoria (
                id_usuario,
                ip_usuario,
                user_agent,
                modulo,
                accion,
                metodo_http,
                url,
                tabla_afectada,
                id_afectado,
                datos_entrada,
                exito,
                mensaje
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            $stmt = $pdo->prepare($sql);
            $stmt->execute([
                $idUsuario,
                self::obtenerIPUsuario(),
                $_SERVER['HTTP_USER_AGENT'] ?? 'CLI/unknown',
                $modulo,
                $accion,
                $_SERVER['REQUEST_METHOD'] ?? 'CLI',
                $_SERVER['REQUEST_URI'] ?? 'CLI',
                $tabla_afectada,
                $id_afectado,
                json_encode(self::sanearDatos($_POST ?: $_GET)),
                $exito ? 1 : 0,
                $mensaje
            ]);
        } catch (\Exception $e) {
            error_log("Error al guardar en auditoría: " . $e->getMessage());
        }
    }

    private static function obtenerIPUsuario(): string
    {
        if (!empty($_SERVER['HTTP_X_FORWARDED_FOR'])) {
            $ips = explode(',', $_SERVER['HTTP_X_FORWARDED_FOR']);
            return trim($ips[0]);
        }

        $ip = $_SERVER['REMOTE_ADDR'] ?? '0.0.0.0';
        return $ip === '::1' ? '127.0.0.1' : $ip;
    }

    private static function sanearDatos(array $datos): array
    {
        $sensibles = ['password', 'clave', 'contrasena', 'pass'];
        foreach ($sensibles as $campo) {
            if (isset($datos[$campo])) {
                $datos[$campo] = '[PROTEGIDO]';
            }
        }
        return $datos;
    }
}
