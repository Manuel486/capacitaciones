<?php

require_once __DIR__ . "/database/ConexionCapacitaciones.php";
require_once __DIR__ . "/database/ConexionAquarius.php";
require_once __DIR__ . "/../helpers/generarIdUnico.php";
require_once __DIR__ . "/../helpers/crearCertificado.php";
require_once __DIR__ . '/../helpers/sendCertificado.php';

class CursoUsuarioModel
{
    public function __construct()
    {
    }

    public function marcarItemCompletado($itemId, $cursoUsuarioId, $datosUsuario, $nota = null, $nota_minima_aprobatoria = null)
    {
        $pdo = ConexionCapacitaciones::getInstancia()->getConexion();
        try {
            $query = "SELECT COUNT(*) FROM progreso_item WHERE id_item = :id_item AND id_curso_usuario = :id_curso_usuario";
            $stmt = $pdo->prepare($query);
            $stmt->execute(['id_item' => $itemId, 'id_curso_usuario' => $cursoUsuarioId]);
            $existe = $stmt->fetchColumn();

            if ($existe) {
                if ($nota !== null) {
                    $completado = 0;
                    if ($nota_minima_aprobatoria !== null) {
                        if ($nota >= $nota_minima_aprobatoria) {
                            $completado = 1;
                        }
                    }
                    $query = "UPDATE progreso_item SET completado = :completado, nota = :nota WHERE id_item = :id_item AND id_curso_usuario = :id_curso_usuario";
                    $stmt = $pdo->prepare($query);
                    $stmt->execute([
                        'nota' => $nota,
                        'id_item' => $itemId,
                        'id_curso_usuario' => $cursoUsuarioId,
                        'completado' => $completado
                    ]);
                } else {
                    $query = "UPDATE progreso_item SET completado = 1 WHERE id_item = :id_item AND id_curso_usuario = :id_curso_usuario";
                    $stmt = $pdo->prepare($query);
                    $stmt->execute(['id_item' => $itemId, 'id_curso_usuario' => $cursoUsuarioId]);
                }

            } else {
                if ($nota !== null) {
                    $completado = 0;
                    if ($nota_minima_aprobatoria !== null) {
                        if ($nota >= $nota_minima_aprobatoria) {
                            $completado = 1;
                        }
                    }
                    $idProgresoItem = generarIdUnico("PRI");
                    $query = "INSERT INTO progreso_item (id_progreso, id_item, id_curso_usuario, completado, nota) VALUES (:id_progreso, :id_item, :id_curso_usuario, :completado, :nota)";
                    $stmt = $pdo->prepare($query);
                    $stmt->execute([
                        'id_progreso' => $idProgresoItem,
                        'id_item' => $itemId,
                        'id_curso_usuario' => $cursoUsuarioId,
                        'completado' => $completado,
                        'nota' => $nota
                    ]);
                } else {
                    $idProgresoItem = generarIdUnico("PRI");
                    $query = "INSERT INTO progreso_item (id_progreso, id_item, id_curso_usuario, completado) VALUES (:id_progreso, :id_item, :id_curso_usuario, 1)";
                    $stmt = $pdo->prepare($query);
                    $stmt->execute(['id_progreso' => $idProgresoItem, 'id_item' => $itemId, 'id_curso_usuario' => $cursoUsuarioId]);
                }
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
                if ($item['tipo'] === 'clase') {
                    $sqlClase = "SELECT activo FROM clase WHERE id_clase = :id_clase AND activo = 1";
                    $stmtClase = $pdo->prepare($sqlClase);
                    $stmtClase->execute(['id_clase' => $item['id_referencia']]);
                    if ($stmtClase->fetch()) {
                        $totalItems++;
                    }
                } else if ($item['tipo'] === 'anuncio') {
                    $sqlAnuncio = "SELECT activo FROM anuncio WHERE id_anuncio = :id_anuncio AND activo = 1";
                    $stmtAnuncio = $pdo->prepare($sqlAnuncio);
                    $stmtAnuncio->execute(['id_anuncio' => $item['id_referencia']]);
                    if ($stmtAnuncio->fetch()) {
                        $totalItems++;
                    }
                } else if ($item['tipo'] === 'evaluacion') {
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

            if ($progreso >= 100) {
                $queryCurso = "SELECT c.tiene_certificacion, c.nombre  
                                FROM curso c
                                JOIN curso_usuario cu ON c.id_curso = cu.id_curso
                                WHERE cu.id_curso_usuario = :id_curso_usuario";
                $stmtCurso = $pdo->prepare($queryCurso);
                $stmtCurso->execute(['id_curso_usuario' => $cursoUsuarioId]);
                $curso = $stmtCurso->fetch(PDO::FETCH_ASSOC);

                if ($curso && $curso['tiene_certificacion'] == 1) {
                    $id_certificado = generarIdUnico("CER");
                    $updateCertificadoQuery = "UPDATE curso_usuario SET certificado = :certificado WHERE id_curso_usuario = :id_curso_usuario";
                    $updateCertificadoStmt = $pdo->prepare($updateCertificadoQuery);
                    $updateCertificadoStmt->execute(['certificado' => $id_certificado, 'id_curso_usuario' => $cursoUsuarioId]);

                    crearCertificado(
                        $datosUsuario->apellidos . ' ' . $datosUsuario->nombres,
                        $curso['nombre'],
                        $id_certificado
                    );

                    // Obtener información del usuario con el cursoUsuarioId
                    $sqlUsuario = "SELECT id_usuario FROM curso_usuario WHERE id_curso_usuario = :id_curso_usuario";
                    $stmtUsuario = $pdo->prepare($sqlUsuario);
                    $stmtUsuario->execute(['id_curso_usuario' => $cursoUsuarioId]);
                    $usuarioData = $stmtUsuario->fetch(PDO::FETCH_ASSOC);

                    if ($usuarioData) {
                        $correoUsuario = $this->obtenerInformacionDelUltimoIngreso($usuarioData['id_usuario']);
                        $nombreCertificado = $curso['nombre'] . ' - ' . $datosUsuario->apellidos . ' ' . $datosUsuario->nombres . '.pdf';

                        if ($correoUsuario && isset($correoUsuario['email']) && !empty($correoUsuario['email'])) {

                            $contenidoCertificado = file_get_contents(CERTIFICADOS . $id_certificado . ".pdf");
                            $adjuntos = [];
                            if ($contenidoCertificado != false) {
                                $adjuntos[] = [
                                    'path' => CERTIFICADOS . $id_certificado . ".pdf",
                                    'name' => $nombreCertificado,
                                    'mime' => 'application/pdf'
                                ];
                            }
                            // Correo usuario es un string

                            $datosCorreo = [
                                'funcion' => 'mailGenerico',
                                'para' => $correoUsuario['email'],
                                'cc' => '',
                                'asunto' => 'Certificado de Curso: ' . $curso['nombre'],
                                'mensaje' => 'Estimado(a) ' . $datosUsuario->nombres . ', adjuntamos su certificado por haber completado el curso "' . $curso['nombre'] . '".',
                                'remitenteNombre' => 'Sistema de Capacitaciones',
                                'correoRemitente' => 'fichas@sepcon.net',
                                'adjuntos' => $adjuntos,
                                "generar_eml" => "0"

                            ];
                            sendCertificado($datosCorreo);
                        }
                    }

                    // Enviar correo con el certificado


                }
            }

            return true;
        } catch (Exception $e) {
            return false;
        }
    }

    public function obtenerInformacionDelUltimoIngreso($dni)
    {
        $pdoDocumentos = ConexionAquarius::getInstancia()->getConexion();
        try {
            $sql = "SELECT TOP (1) ma.NUM_DOC_IDENTIDAD AS 'dni', ma.NUM_EMAIL AS 'email', pp.FEC_INGRESO AS 'fec_ingreso'
                    FROM MAE_AUXILIAR ma 
                    INNER JOIN PLA_PERSONAL pp ON pp.COD_AUXILIAR = ma.COD_AUXILIAR
                    WHERE ma.NUM_DOC_IDENTIDAD = :dni
                    ORDER BY pp.FEC_INGRESO DESC";
            $statement = $pdoDocumentos->prepare($sql);
            $statement->execute([
                'dni' => $dni
            ]);
            $ingreso = $statement->fetch(PDO::FETCH_ASSOC);
            return $ingreso ?: null;
        } catch (PDOException $e) {
            return null;
        }
    }

    public function obtenerMisCursos($idUsuario)
    {
        $pdo = ConexionCapacitaciones::getInstancia()->getConexion();
        try {
            $query = "SELECT c.id_curso, c.nombre, c.descripcion, c.imagen, cu.fecha_inicio, cu.progreso, cu.obligatorio, c.tiene_certificacion,
                      CASE
                        WHEN c.fecha_publicacion IS NOT NULL AND c.fecha_cierre IS NULL THEN 1
                        WHEN c.fecha_publicacion IS NOT NULL
                        AND c.fecha_cierre IS NOT NULL
                        AND CURRENT_DATE BETWEEN c.fecha_publicacion AND c.fecha_cierre
                        THEN 1
                        ELSE 0
                      END AS activo
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
            $query = "SELECT c.*,
                      CASE
                        WHEN c.fecha_publicacion IS NOT NULL AND c.fecha_cierre IS NULL THEN 1
                        WHEN c.fecha_publicacion IS NOT NULL
                        AND c.fecha_cierre IS NOT NULL
                        AND CURRENT_DATE BETWEEN c.fecha_publicacion AND c.fecha_cierre
                        THEN 1
                        ELSE 0
                      END AS activo
                      FROM curso c
                      WHERE c.id_autor = :id_autor";
            $stmt = $pdo->prepare($query);
            $stmt->execute(['id_autor' => $dniUsuario]);
            $cursos = $stmt->fetchAll(PDO::FETCH_ASSOC);

            if (count($cursos) > 0) {
                foreach ($cursos as $index => $curso) {
                    $queryInscritos = "SELECT COUNT(*) FROM curso_usuario WHERE id_curso = :id_curso";
                    $stmtInscritos = $pdo->prepare($queryInscritos);
                    $stmtInscritos->execute(['id_curso' => $curso['id_curso']]);
                    $cursos[$index]['inscritos'] = $stmtInscritos->fetchColumn();

                    $queryValoraciones = "SELECT * FROM curso_valoracion WHERE id_curso = :id_curso";
                    $stmtValoraciones = $pdo->prepare($queryValoraciones);
                    $stmtValoraciones->execute(['id_curso' => $cursos[$index]['id_curso']]);
                    $valoraciones = $stmtValoraciones->fetchAll(PDO::FETCH_ASSOC);

                    if (count($valoraciones) > 0) {
                        $sumaValoraciones = array_reduce($valoraciones, function ($sum, $valoracion) {
                            return $sum + $valoracion['valoracion'];
                        }, 0);
                        $cursos[$index]['valoracion_promedio'] = round($sumaValoraciones / count($valoraciones));
                    } else {
                        $cursos[$index]['valoracion_promedio'] = 0;
                    }
                }
            }

            return $cursos;
        } catch (Exception $e) {
            return [];
        }
    }

    public function obtenerCertificadoPorIdCursoIdUsuario($idCurso, $idUsuario)
    {
        $pdo = ConexionCapacitaciones::getInstancia()->getConexion();
        try {
            $query = "SELECT cu.certificado, c.nombre AS nombre_curso
                      FROM curso_usuario cu
                      INNER JOIN curso c ON cu.id_curso = c.id_curso
                      WHERE cu.id_curso = :id_curso AND cu.id_usuario = :id_usuario";
            $stmt = $pdo->prepare($query);
            $stmt->execute(['id_curso' => $idCurso, 'id_usuario' => $idUsuario]);
            return $stmt->fetchColumn();
        } catch (Exception $e) {
            return null;
        }
    }
}