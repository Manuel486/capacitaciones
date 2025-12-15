<?php

require_once __DIR__ . "/database/ConexionCapacitaciones.php";
require_once __DIR__ . "/database/ConexionRRHH.php";
require_once __DIR__ . "/database/ConexionDocumentos.php";

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
                // if ($usuarioData['estado'] !== "AC") {
                //     return ["exitoso" => false, "error" => "Usuario inactivo. Por favor, contacte al administrador."];
                // }

                $sqlRol = "SELECT r.nombre
                           FROM usuario_rol ur
                           INNER JOIN rol r ON r.id_rol = ur.id_rol
                           WHERE ur.id_usuario = :id_usuario";

                $statementRol = $pdoCapacitaciones->prepare($sqlRol);
                $statementRol->execute([
                    'id_usuario' => $usuarioData['dni']
                ]);

                $roles = $statementRol->fetchAll(PDO::FETCH_COLUMN);

                if (empty($roles)) {
                    // ROL_ESTUDIANTE => 3
                    $sqlAsignarRol = "INSERT INTO usuario_rol (id_usuario, id_rol) VALUES (:id_usuario, 3)";
                    $statementAsignarRol = $pdoCapacitaciones->prepare($sqlAsignarRol);
                    $statementAsignarRol->execute([
                        'id_usuario' => $usuarioData['dni']
                    ]);

                    // Obtener los roles nuevamente con una nueva consulta
                    $sqlRolNuevo = "SELECT r.nombre
                                    FROM usuario_rol ur
                                    INNER JOIN rol r ON r.id_rol = ur.id_rol
                                    WHERE ur.id_usuario = :id_usuario";
                    $statementRolNuevo = $pdoCapacitaciones->prepare($sqlRolNuevo);
                    $statementRolNuevo->execute([
                        'id_usuario' => $usuarioData['dni']
                    ]);
                    $roles = $statementRolNuevo->fetchAll(PDO::FETCH_COLUMN);
                }

                $accesos = [];
                if (!empty($roles)) {
                    $placeholders = implode(',', array_fill(0, count($roles), '?'));
                    $sqlAccesos = "SELECT DISTINCT a.permiso 
                                   FROM acceso a
                                   INNER JOIN rol_acceso ra ON ra.id_acceso = a.id_acceso
                                   INNER JOIN rol r ON r.id_rol = ra.id_rol
                                   WHERE r.nombre IN ($placeholders)";
                    $statementAccesos = $pdoCapacitaciones->prepare($sqlAccesos);
                    $statementAccesos->execute(array_values($roles));
                    $accesos = $statementAccesos->fetchAll(PDO::FETCH_COLUMN);
                }

                $usuarioData['roles'] = $roles;
                $usuarioData["exitoso"] = true;
                $usuarioData["accesos"] = $accesos;

                return $usuarioData;
            }

            return ["exitoso" => false, "error" => "Usuario o contraseña incorrectos."];
        } catch (PDOException $e) {
            return ["exitoso" => false, "error" => "Error del sistema."];
        }
    }

    public function obtenerInfoUsuarioPorDni($dni)
    {
        $pdoRRHH = ConexionRRHH::getInstancia()->getConexion();
        $pdoCapacitaciones = ConexionCapacitaciones::getInstancia()->getConexion();
        $pdoDocumentos = ConexionDocumentos::getInstancia()->getConexion();
        try {
            $sqlUsuario = "SELECT * FROM tabla_aquarius tb WHERE dni = :dni";
            $statementUsuario = $pdoRRHH->prepare($sqlUsuario);
            $statementUsuario->execute([
                'dni' => $dni
            ]);
            $usuarioData = $statementUsuario->fetch(PDO::FETCH_ASSOC);

            if (!$usuarioData) {
                return ["exitoso" => false, "error" => "Usuario no encontrado."];
            }

            // Obtener roles
            $sqlRol = "SELECT r.nombre
                       FROM usuario_rol ur
                       INNER JOIN rol r ON r.id_rol = ur.id_rol
                       WHERE ur.id_usuario = :dni";
            $statementRol = $pdoCapacitaciones->prepare($sqlRol);
            $statementRol->execute([
                'dni' => $dni
            ]);
            $roles = $statementRol->fetchAll(PDO::FETCH_COLUMN);

            // Obtener accesos
            $accesos = [];
            if (!empty($roles)) {
                $placeholders = implode(',', array_fill(0, count($roles), '?'));
                $sqlAccesos = "SELECT DISTINCT a.permiso 
                               FROM acceso a
                               INNER JOIN rol_acceso ra ON ra.id_acceso = a.id_acceso
                               INNER JOIN rol r ON r.id_rol = ra.id_rol
                               WHERE r.nombre IN ($placeholders)";
                $statementAccesos = $pdoCapacitaciones->prepare($sqlAccesos);
                $statementAccesos->execute(array_values($roles));
                $accesos = $statementAccesos->fetchAll(PDO::FETCH_COLUMN);
            }

            $usuarioData['roles'] = $roles;
            $usuarioData['accesos'] = $accesos;

            // Obtener foto desde postulantes
            $sqlPostulaciones = "SELECT idreg FROM postulante WHERE documento = :dni ORDER BY registro DESC LIMIT 1";
            $statementPostulaciones = $pdoDocumentos->prepare($sqlPostulaciones);
            $statementPostulaciones->execute([
                'dni' => $usuarioData['dni']
            ]);
            $postulacion = $statementPostulaciones->fetch(PDO::FETCH_ASSOC);
            if ($postulacion) {
                // $usuarioData['foto'] = $postulacion['idreg'];
                $usuarioData['foto'] = null;
            } else {
                $usuarioData['foto'] = null;
            }
            

            $usuarioData['exitoso'] = true;
            return $usuarioData;
        } catch (PDOException $e) {
            return ["exitoso" => false, "error" => "Error del sistema."];
        }
    }

    public function obtenerTodosLosUsuarios()
    {
        $pdo = ConexionRRHH::getInstancia()->getConexion();
        try {
            $sql = "SELECT * FROM tabla_aquarius ta
                    WHERE ta.freg = (
                        SELECT MAX(freg) FROM tabla_aquarius WHERE dni = ta.dni
                    )
                    GROUP BY ta.dni
                    ORDER BY ta.apellidos, ta.nombres";
            $statement = $pdo->prepare($sql);
            $statement->execute();
            $usuarios = $statement->fetchAll(PDO::FETCH_ASSOC);
            return $usuarios;
        } catch (PDOException $e) {
            return [];
        }
    }
}
