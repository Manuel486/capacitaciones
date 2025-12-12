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
            $query = "SELECT COUNT(*) FROM progreso_item WHERE id_item = :id_item AND id_curso_usuario = :id_curso_usuario";
            $stmt = $pdo->prepare($query);
            $stmt->execute(['id_item' => $itemId, 'id_curso_usuario' => $cursoUsuarioId]);
            $existe = $stmt->fetchColumn();

            if ($existe) {
                $query = "UPDATE progreso_item SET completado = 1 WHERE id_item = :id_item AND id_curso_usuario = :id_curso_usuario";
                $stmt = $pdo->prepare($query);
                $stmt->execute(['id_item' => $itemId, 'id_curso_usuario' => $cursoUsuarioId]);
            } else {
                $idProgresoItem = generarIdUnico("PRI");
                $query = "INSERT INTO progreso_item (id_progreso, id_item, id_curso_usuario, completado) VALUES (:id_progreso, :id_item, :id_curso_usuario, 1)";
                $stmt = $pdo->prepare($query);
                $stmt->execute(['id_progreso' => $idProgresoItem, 'id_item' => $itemId, 'id_curso_usuario' => $cursoUsuarioId]);
            }

            $queryItems = "SELECT ti.id_referencia, ti.tipo FROM tema_item ti
                                JOIN tema t ON ti.id_tema = t.id_tema
                                WHERE t.id_curso = (
                                    SELECT cu.id_curso FROM curso_usuario cu WHERE cu.id_curso_usuario = :id_curso_usuario
                                )";
            $stmtItems = $pdo->prepare($queryItems);
            $stmtItems->execute(['id_curso_usuario' => $cursoUsuarioId]);
            $items = $stmtItems->fetchAll(PDO::FETCH_ASSOC);

            $totalItems = 0;
            foreach ($items as $item) {
                if($item['tipo'] === 'clase') {
                    $sqlClase = "SELECT activo FROM clase WHERE id_clase = :id_clase AND activo = 1";
                    $stmtClase = $pdo->prepare($sqlClase);
                    $stmtClase->execute(['id_clase' => $item['id_referencia']]);
                    if ($stmtClase->fetch()) {
                        $totalItems++;
                    }
                } else if($item['tipo'] === 'anuncio') {
                    $sqlAnuncio = "SELECT activo FROM anuncio WHERE id_anuncio = :id_anuncio AND activo = 1";
                    $stmtAnuncio = $pdo->prepare($sqlAnuncio);
                    $stmtAnuncio->execute(['id_anuncio' => $item['id_referencia']]);
                    if ($stmtAnuncio->fetch()) {
                        $totalItems++;
                    }
                } else if($item['tipo'] === 'evaluacion') {
                    $sqlEvaluacion = "SELECT activo FROM evaluacion WHERE id_evaluacion = :id_evaluacion AND activo = 1";
                    $stmtEvaluacion = $pdo->prepare($sqlEvaluacion);
                    $stmtEvaluacion->execute(['id_evaluacion' => $item['id_referencia']]);
                    if ($stmtEvaluacion->fetch()) {
                        $totalItems++;
                    }
                }
            }

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
            $query = "SELECT c.id_curso, c.nombre, c.descripcion, c.imagen, cu.fecha_inicio, cu.progreso, cu.obligatorio
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
            $cursos = $stmt->fetchAll(PDO::FETCH_ASSOC);

            if(count($cursos) > 0){
                foreach ($cursos as $index => $curso) {
                    $queryInscritos = "SELECT COUNT(*) FROM curso_usuario WHERE id_curso = :id_curso";
                    $stmtInscritos = $pdo->prepare($queryInscritos);
                    $stmtInscritos->execute(['id_curso' => $curso['id_curso']]);
                    $cursos[$index]['inscritos'] = $stmtInscritos->fetchColumn();

                    // $queryValoracion = "SELECT AVG(valoracion) FROM curso_valoracion WHERE id_curso = :id_curso";
                    // $stmtValoracion = $pdo->prepare($queryValoracion);
                    // $stmtValoracion->execute(['id_curso' => $curso['id_curso']]);
                    // $cursos[$index]['valoracion'] = round($stmtValoracion->fetchColumn(), 1);

                    // $queryDuracion = "SELECT SUM(duracion) FROM tema_item ti
                    //                   JOIN tema t ON ti.id_tema = t.id_tema
                    //                   WHERE t.id_curso = :id_curso AND ti.tipo = 'clase'";
                    // $stmtDuracion = $pdo->prepare($queryDuracion);
                    // $stmtDuracion->execute(['id_curso' => $curso['id_curso']]);
                    // $cursos[$index]['duracion'] = $stmtDuracion->fetchColumn();
                }
            }

            return $cursos;
        } catch (Exception $e) {
            return [];
        }
    }
}