<?php

class ApiRespuesta {
    public static function exitoso($respuesta, $mensaje = null,$token_valido = true,$tiene_permisos = true) {
        $respuesta = [
            'exitoso' => true,
            'mensaje' => $mensaje,
            'respuesta' => $respuesta,
            'token_valido' => $token_valido,
            'tiene_permisos' => $tiene_permisos
        ];
        
        header('Content-Type: application/json');
        return json_encode($respuesta);
    }

    public static function error($mensaje,$token_valido = true, $tiene_permisos = true) {
        $respuesta = [
            'exitoso' => false,
            'mensaje' => $mensaje,
            'token_valido' => $token_valido,
            'tiene_permisos' => $tiene_permisos
        ];

        header('Content-Type: application/json');
        return json_encode($respuesta);
    }
}
