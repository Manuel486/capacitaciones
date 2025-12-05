<?php

require_once __DIR__ . "/database/ConexionCapacitaciones.php";
require_once __DIR__ . "/database/ConexionRRHH.php";

class UsuarioModel
{

    public function __construct()
    {
    }

    public function verificarExistenciaUsuario($usuario, $password)
    {
        $pdoRRHH = ConexionRRHH::getInstancia()->getConexion();
        $pdoCapacitaciones = ConexionCapacitaciones::getInstancia()->getConexion();
        try {
            $claveEncriptada = sha1($password);
            $usuario = strtolower($usuario);
            $sql = "SELECT * FROM tabla_aquarius WHERE LOWER(usuario) = :usuario AND clave = :clave";
            $statement = $pdoRRHH->prepare($sql);
            $statement->execute([
                'usuario' => $usuario,
                'clave' => $claveEncriptada
            ]);

            $usuarioData = $statement->fetch(PDO::FETCH_ASSOC);

            if ($usuarioData) {
                if ($usuarioData['estado'] !== "AC") {
                    return ["exitoso" => false, "error" => "Usuario inactivo. Por favor, contacte al administrador."];
                }

                // Buscar el rol que tiene
                $sqlRol = "SELECT a.permiso
                           FROM usuario_rol ur
                           INNER JOIN rol_acceso ra ON ra.id_rol = ur.id_rol
                           INNER JOIN acceso a ON a.id_acceso = ra.id_acceso
                           WHERE ur.id_usuario = :id_usuario";

                $statementRol = $pdoCapacitaciones->prepare($sqlRol);
                $statementRol->execute([
                    'id_usuario' => $usuarioData['dni']
                ]);

                $roles = $statementRol->fetchAll(PDO::FETCH_COLUMN);

                // Verificar si tiene roles asignados
                if (empty($roles)) {
                    // ROL_ESTUDIANTE => 3
                    $sqlAsignarRol = "INSERT INTO usuario_rol (id_usuario, id_rol) VALUES (:id_usuario, 3)";
                    $statementAsignarRol = $pdoCapacitaciones->prepare($sqlAsignarRol);
                    $statementAsignarRol->execute([
                        'id_usuario' => $usuarioData['dni']
                    ]);

                    // Obtener los roles nuevamente
                    $statementRol->execute([
                        'id_usuario' => $usuarioData['dni']
                    ]);
                    $roles = $statementRol->fetchAll(PDO::FETCH_COLUMN);
                }

                // Obtener arreglo de accesos
                $sqlAccesos = "SELECT permiso FROM acceso WHERE permiso IN (" . implode(',', array_map(function ($r) {
                    return "'" . $r . "'";
                }, $roles)) . ")";
                $statementAccesos = $pdoCapacitaciones->prepare($sqlAccesos);
                $statementAccesos->execute();

                $usuarioData['roles'] = $roles;
                $usuarioData["exitoso"] = true;
                return $usuarioData;
            }

            return ["exitoso" => false, "error" => "Usuario o contraseña incorrectos."];
        } catch (PDOException $e) {
            return ["exitoso" => false, "error" => "Error del sistema."];
        }
    }
}
