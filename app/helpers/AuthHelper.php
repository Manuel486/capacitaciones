<?php

require_once __DIR__ . "/../models/AuditoriaLogger.php";
require_once __DIR__ . '/ApiRespuesta.php';

use \Firebase\JWT\JWT;
use \Firebase\JWT\Key;

class AuthHelper
{
    private static $secretKey = CLAVE_TOKEN;

    public static function validarToken($nombre_cookie)
    {
        $token = $_COOKIE[$nombre_cookie] ?? null;

        if (!$token) {
            return false;
        }

        try {
            $decoded = JWT::decode($token, new Key(self::$secretKey, 'HS256'));

            if (time() >= $decoded->exp) {
                return false;
            }

            return $decoded;
        } catch (Exception $e) {
            return false;
        }
    }

    public static function verificarAccesoVista(array $permisosRequeridos, string $modulo, string $accion): bool
    {
        $decoded = self::validarToken("sepcon_session_token");

        if (!$decoded) {
            setcookie("sepcon_session_token", "", time() - 30000, "/");
            header("Location: " . BASE_URL . "inicio");
            exit;
        }

        $accesos = $decoded->data->accesos ?? [];

        foreach ($permisosRequeridos as $permiso) {
            if (in_array($permiso, $accesos)) {
                return true;
            }
        }

        AuditoriaLogger::log(
            $modulo,
            "$accion sin permisos",
            false,
            "Acceso denegado: no tiene permisos requeridos"
        );

        header("Location: " . BASE_URL . "inicio");
        exit;
    }

    public static function verificarAccesoResponsable(array $permisosRequeridos, string $modulo, string $accion): bool
    {
        $decoded = self::validarToken("sepcon_session_token");

        if (!$decoded) {
            AuditoriaLogger::log(
                $modulo,
                "$accion sin token",
                false,
                "Acceso denegado: token inválido o expirado"
            );
            echo ApiRespuesta::error("Token inválido o expirado, vuelva a iniciar sesión.", false, false);
            return false;
        }

        $accesos = $decoded->data->accesos ?? [];

        foreach ($permisosRequeridos as $permiso) {
            if (in_array($permiso, $accesos)) {
                return true;
            }
        }

        AuditoriaLogger::log(
            $modulo,
            "$accion sin permisos",
            false,
            "Acceso denegado: no tiene permisos requeridos"
        );

        echo ApiRespuesta::error("No tiene permisos para esta operación", true, false);
        return false;
    }

    public static function verificarTokenGenerado(string $modulo, string $accion): bool
    {
        $decoded = self::validarToken("sepcon_session_token");

        if (!$decoded) {
            AuditoriaLogger::log(
                $modulo,
                "$accion sin token",
                false,
                "Acceso denegado: token inválido o expirado"
            );
            echo ApiRespuesta::error("Token inválido o expirado, vuelva a iniciar sesión.", false, false);
            return false;
        }

        return true;
    }

    public static function verificarAccesoResponsableArchivo(array $permisosRequeridos, string $modulo, string $accion): bool
    {
        $decoded = self::validarToken("sepcon_session_token");

        if (!$decoded) {
            AuditoriaLogger::log(
                $modulo,
                "$accion sin token",
                false,
                "Acceso denegado: token inválido o expirado"
            );
            echo ApiRespuesta::error("Token inválido o expirado, vuelva a iniciar sesión.", false, false);
            include VIEWS_PATH . '/token_expirado.php';
            return false;
        }

        $accesos = $decoded->data->accesos ?? [];

        foreach ($permisosRequeridos as $permiso) {
            if (in_array($permiso, $accesos)) {
                return true;
            }
        }

        AuditoriaLogger::log(
            $modulo,
            "$accion sin permisos",
            false,
            "Acceso denegado: no tiene permisos requeridos"
        );

        echo ApiRespuesta::error("No tiene permisos para esta operación", true, false);
        include VIEWS_PATH . '/token_expirado.php';
        return false;
    }

    // public static function verificarAdminVista(string $modulo, string $accion): bool
    // {
    //     $decoded = self::validarToken("responsable_auth_token");

    //     if (!$decoded) {
    //         setcookie("responsable_auth_token", "", time() - 30000, "/");
    //         header("Location: " . BASE_URL . "responsable/login");
    //         exit;
    //     }

    //     if (($decoded->data->rol ?? null) !== 'ROL_ADMINISTRADOR') {
    //         AuditoriaLogger::log(
    //             $modulo,
    //             "$accion sin rol de administrador",
    //             false,
    //             "Acceso denegado: requiere el rol ROL_ADMINISTRADOR"
    //         );
    //         header("Location: " . BASE_URL . "responsable/perfil");
    //         exit;
    //     }

    //     return true;
    // }

    public static function verificarSoloAdministrador(string $modulo, string $accion): bool
    {
        $decoded = self::validarToken("responsable_auth_token");

        if (!$decoded) {
            echo ApiRespuesta::error("Token inválido o expirado, vuelva a iniciar sesión.", false, false);
            return false;
        }

        if (($decoded->data->rol ?? null) !== 'ROL_ADMINISTRADOR') {
            AuditoriaLogger::log(
                $modulo,
                "$accion sin rol de administrador",
                false,
                "Acceso denegado: requiere el rol ROL_ADMINISTRADOR"
            );
            echo ApiRespuesta::error("Acceso denegado: solo permitido para administradores");
            return false;
        }

        return true;
    }

    public static function obtenerUsuario()
    {
        $decoded = self::validarToken("sepcon_session_token");
        return $decoded ? $decoded->data : null;
    }

    public static function verificarPostulante(string $modulo, string $accion): bool
    {
        $decoded = self::validarToken("postulante_auth_token");

        if (!$decoded) {
            AuditoriaLogger::log(
                $modulo,
                "$accion sin token",
                false,
                "Acceso denegado: token inválido o expirado"
            );
            echo ApiRespuesta::error("Token inválido o expirado, vuelva a iniciar sesión.", false, false);
            return false;
        }

        return true;
    }

    // public static function verificarVistaPostulante(string $modulo, string $accion): bool
    // {
    //     $decoded = self::validarToken("postulante_auth_token");

    //     if (!$decoded) {
    //         header("Location: " . BASE_URL . "postulante/login");
    //         exit;
    //     }

    //     return true;
    // }
}
