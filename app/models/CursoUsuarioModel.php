<?php


require_once __DIR__ . "/database/ConexionCapacitaciones.php";
require_once __DIR__ . "/../helpers/generarIdUnico.php";

class CursoUsuarioModel
{
    public function __construct()
    {
    }

    public function marcarItemCompletado($itemId, $cursoUsuarioId)
    {
        $pdo = ConexionCapacitaciones::getInstancia()->getConexion();
        try {
            // Verificar si ya existe el registro
            $query = "SELECT COUNT(*) FROM progreso_item WHERE id_item = :id_item AND id_curso_usuario = :id_curso_usuario";
            $stmt = $pdo->prepare($query);
            $stmt->execute(['id_item' => $itemId, 'id_curso_usuario' => $cursoUsuarioId]);
            $exists = $stmt->fetchColumn();

            if ($exists) {
                $query = "UPDATE progreso_item SET completado = 1 WHERE id_item = :id_item AND id_curso_usuario = :id_curso_usuario";
                $stmt = $pdo->prepare($query);
                $stmt->execute(['id_item' => $itemId, 'id_curso_usuario' => $cursoUsuarioId]);
            } else {
                $idProgresoItem = generarIdUnico("PRI");
                $query = "INSERT INTO progreso_item (id_progreso, id_item, id_curso_usuario, completado) VALUES (:id_progreso, :id_item, :id_curso_usuario, 1)";
                $stmt = $pdo->prepare($query);
                $stmt->execute(['id_progreso' => $idProgresoItem, 'id_item' => $itemId, 'id_curso_usuario' => $cursoUsuarioId]);
            }

            // Evaluar progreso total del curso_usuario
            $queryTotalItems = "SELECT COUNT(*) FROM tema_item ti
                                JOIN tema t ON ti.id_tema = t.id_tema
                                WHERE t.id_curso = (
                                    SELECT cu.id_curso FROM curso_usuario cu WHERE cu.id_curso_usuario = :id_curso_usuario
                                )";
            $stmtTotal = $pdo->prepare($queryTotalItems);
            $stmtTotal->execute(['id_curso_usuario' => $cursoUsuarioId]);
            $totalItems = $stmtTotal->fetchColumn();

            $queryCompletedItems = "SELECT COUNT(*) FROM progreso_item WHERE id_curso_usuario = :id_curso_usuario AND completado = 1";
            $stmtCompleted = $pdo->prepare($queryCompletedItems);
            $stmtCompleted->execute(['id_curso_usuario' => $cursoUsuarioId]);
            $completedItems = $stmtCompleted->fetchColumn();

            $progreso = ($completedItems / $totalItems) * 100;
            $updateCursoUsuarioQuery = "UPDATE curso_usuario SET progreso = :progreso WHERE id_curso_usuario = :id_curso_usuario";
            $updateStmt = $pdo->prepare($updateCursoUsuarioQuery);
            $updateStmt->execute(['progreso' => $progreso, 'id_curso_usuario' => $cursoUsuarioId]);

            return true;
        } catch (Exception $e) {
            return false;
        }
    }

    public function obtenerMisCursos($idUsuario)
    {
        $pdo = ConexionCapacitaciones::getInstancia()->getConexion();
        try {
            $query = "SELECT c.id_curso, c.nombre, c.descripcion, c.imagen, cu.fecha_inicio, cu.progreso
                      FROM curso_usuario cu
                      INNER JOIN curso c ON cu.id_curso = c.id_curso
                      WHERE cu.id_usuario = :id_usuario";
            $stmt = $pdo->prepare($query);
            $stmt->execute(['id_usuario' => $idUsuario]);
            return $stmt->fetchAll(PDO::FETCH_ASSOC);
        } catch (Exception $e) {
            return [];
        }
    }

    public function obtenerCursosCreadosPorUsuario($dniUsuario)
    {
        $pdo = ConexionCapacitaciones::getInstancia()->getConexion();
        try {
            $query = "SELECT c.*
                      FROM curso c
                      WHERE c.id_autor = :id_autor";
            $stmt = $pdo->prepare($query);
            $stmt->execute(['id_autor' => $dniUsuario]);
            return $stmt->fetchAll(PDO::FETCH_ASSOC);
        } catch (Exception $e) {
            return [];
        }
    }
}