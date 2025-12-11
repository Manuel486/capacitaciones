<?php


require_once __DIR__ . "/database/ConexionCapacitaciones.php";
require_once __DIR__ . "/../helpers/generarIdUnico.php";

class CursoModel
{
    public function __construct()
    {
    }

    public function listarCursos()
    {
        $pdo = ConexionCapacitaciones::getInstancia()->getConexion();
        try {
            $query = "SELECT id_curso, nombre, descripcion, imagen FROM curso";
            $stmt = $pdo->prepare($query);
            $stmt->execute();
            return $stmt->fetchAll(PDO::FETCH_ASSOC);
        } catch (Exception $e) {
            return [];
        }
    }

    public function obtenerCursoPorId($idCurso)
    {
        $pdo = ConexionCapacitaciones::getInstancia()->getConexion();
        try {
            $query = "SELECT c.id_curso, c.nombre, c.descripcion, c.imagen, c.activo, CONCAT(u.apellidos, ' ', u.nombres) AS instructor
                      FROM capacitaciones.curso c
                      LEFT JOIN rrhh.tabla_aquarius u ON u.dni = c.id_autor
                      WHERE id_curso = :id_curso";
            $stmt = $pdo->prepare($query);
            $stmt->execute(['id_curso' => $idCurso]);
            $curso = $stmt->fetch(PDO::FETCH_ASSOC);

            // Obtener temas
            $temas = [];
            $queryTemas = "SELECT id_tema, id_curso, nombre, orden, activo FROM tema WHERE id_curso = :id_curso ORDER BY orden ASC";
            $stmtTemas = $pdo->prepare($queryTemas);
            $stmtTemas->execute(['id_curso' => $idCurso]);
            $temas = $stmtTemas->fetchAll(PDO::FETCH_ASSOC);

            if (count($temas) > 0) {
                // Obtener items por tema
                foreach ($temas as $tema) {
                    $queryItems = "SELECT id_item, id_tema, tipo, id_referencia, orden FROM tema_item WHERE id_tema = :id_tema ORDER BY orden ASC";
                    $stmtItems = $pdo->prepare($queryItems);
                    $stmtItems->execute(['id_tema' => $tema['id_tema']]);
                    $items = $stmtItems->fetchAll(PDO::FETCH_ASSOC);

                    // Obtener detalle de clase o anuncio según el tipo
                    foreach ($items as &$item) {
                        if ($item['tipo'] === 'clase') {
                            $queryClase = "SELECT id_clase, titulo, descripcion, video, activo FROM clase WHERE id_clase = :id_clase";
                            $stmtClase = $pdo->prepare($queryClase);
                            $stmtClase->execute(['id_clase' => $item['id_referencia']]);
                            $item['detalle'] = $stmtClase->fetch(PDO::FETCH_ASSOC);
                        } elseif ($item['tipo'] === 'anuncio') {
                            $queryAnuncio = "SELECT id_anuncio, titulo, descripcion, anuncio, activo FROM anuncio WHERE id_anuncio = :id_anuncio";
                            $stmtAnuncio = $pdo->prepare($queryAnuncio);
                            $stmtAnuncio->execute(['id_anuncio' => $item['id_referencia']]);
                            $item['detalle'] = $stmtAnuncio->fetch(PDO::FETCH_ASSOC);
                        } elseif ($item['tipo'] === 'evaluacion') {
                            $queryEvaluacion = "SELECT id_evaluacion, titulo, descripcion, activo FROM evaluacion WHERE id_evaluacion = :id_evaluacion";
                            $stmtEvaluacion = $pdo->prepare($queryEvaluacion);
                            $stmtEvaluacion->execute(['id_evaluacion' => $item['id_referencia']]);
                            $item['detalle'] = $stmtEvaluacion->fetch(PDO::FETCH_ASSOC);
                        }
                    }
                    unset($item);

                    $tema['items'] = $items;
                    $curso['temas'][] = $tema;
                }
            } else {
                $curso['temas'] = [];
            }

            // Obtener cantidad de estudiantes inscritos
            $queryEstudiantes = "SELECT COUNT(*) AS total_estudiantes FROM curso_usuario WHERE id_curso = :id_curso";
            $stmtEstudiantes = $pdo->prepare($queryEstudiantes);
            $stmtEstudiantes->execute(['id_curso' => $idCurso]);
            $totalEstudiantes = $stmtEstudiantes->fetch(PDO::FETCH_ASSOC)['total_estudiantes'];
            if ($curso) {
                $curso['totalEstudiantes'] = (int) $totalEstudiantes;
                return $curso;
            }
            return null;
        } catch (Exception $e) {
            return null;
        }
    }

    public function obtenerEstructuraCurso($idCurso, $idUsuario)
    {
        $pdo = ConexionCapacitaciones::getInstancia()->getConexion();
        try {
            $queryCurso = "SELECT id_curso, nombre, descripcion, activo FROM curso WHERE id_curso = :id_curso";
            $stmtCurso = $pdo->prepare($queryCurso);
            $stmtCurso->execute(['id_curso' => $idCurso]);
            $curso = $stmtCurso->fetch(PDO::FETCH_ASSOC);

            if (!$curso) {
                return null;
            }

            // Buscar en curso_usuario para ver si ya está inscrito el usuario
            $queryCursoUsuario = "SELECT id_curso_usuario, id_curso, id_usuario, progreso FROM curso_usuario WHERE id_curso = :id_curso AND id_usuario = :id_usuario";
            $stmtCursoUsuario = $pdo->prepare($queryCursoUsuario);
            $stmtCursoUsuario->execute(['id_curso' => $idCurso, 'id_usuario' => $idUsuario]);
            $cursoUsuario = $stmtCursoUsuario->fetch(PDO::FETCH_ASSOC);

            // Si no está inscrito, inscribirlo automáticamente
            if (!$cursoUsuario) {
                $idCursoUsuario = generarIdUnico("CUU");
                $insertQuery = "INSERT INTO curso_usuario (id_curso_usuario,id_curso, id_usuario, fecha_inicio, progreso) VALUES (:id_curso_usuario, :id_curso, :id_usuario, NOW(), 0)";
                $insertStmt = $pdo->prepare($insertQuery);
                $insertStmt->execute(['id_curso_usuario' => $idCursoUsuario, 'id_curso' => $idCurso, 'id_usuario' => $idUsuario]);
                $cursoUsuario = [
                    'id_curso_usuario' => $idCursoUsuario,
                    'id_curso' => $idCurso,
                    'id_usuario' => $idUsuario,
                    'progreso' => 0
                ];
            }

            $curso["curso_usuario_id"] = $cursoUsuario['id_curso_usuario'];
            $curso["progreso"] = $cursoUsuario['progreso'];

            $query = "SELECT id_tema, id_curso, nombre, orden, activo FROM tema WHERE id_curso = :id_curso ORDER BY orden ASC";
            $stmt = $pdo->prepare($query);
            $stmt->execute(['id_curso' => $idCurso]);
            $temas = $stmt->fetchAll(PDO::FETCH_ASSOC);

            foreach ($temas as &$tema) {
                $queryTemaItem = "SELECT id_item, id_tema, tipo, id_referencia, orden FROM tema_item WHERE id_tema = :id_tema ORDER BY orden ASC";
                $stmtItem = $pdo->prepare($queryTemaItem);
                $stmtItem->execute(['id_tema' => $tema['id_tema']]);
                $items = $stmtItem->fetchAll(PDO::FETCH_ASSOC);

                if (empty($items)) {
                    $tema['items'] = [];
                    continue;
                }

                // Buscar el progreso en progreso_item
                $itemsConDetalle = [];
                foreach ($items as $item) {
                    $sqlProgreso = "SELECT id_progreso , id_curso_usuario, id_item, completado FROM progreso_item WHERE id_curso_usuario = :id_curso_usuario AND id_item = :id_item";
                    $stmtProgreso = $pdo->prepare($sqlProgreso);
                    $stmtProgreso->execute([
                        'id_curso_usuario' => $cursoUsuario['id_curso_usuario'],
                        'id_item' => $item['id_item']
                    ]);
                    $progresoItem = $stmtProgreso->fetch(PDO::FETCH_ASSOC);
                    $item['completado'] = $progresoItem ? (int) $progresoItem['completado'] : 0;

                    // Agregar el atributo progreso
                    if ($item['tipo'] === 'clase') {
                        $queryClase = "SELECT id_clase, titulo, descripcion, video, activo FROM clase WHERE id_clase = :id_clase";
                        $stmtClase = $pdo->prepare($queryClase);
                        $stmtClase->execute(['id_clase' => $item['id_referencia']]);
                        $clase = $stmtClase->fetch(PDO::FETCH_ASSOC);
                        $item['detalle'] = $clase;
                    }

                    if ($item['tipo'] === 'anuncio') {
                        $queryAnuncio = "SELECT id_anuncio, titulo, descripcion, anuncio, activo FROM anuncio WHERE id_anuncio = :id_anuncio";
                        $stmtAnuncio = $pdo->prepare($queryAnuncio);
                        $stmtAnuncio->execute(['id_anuncio' => $item['id_referencia']]);
                        $anuncio = $stmtAnuncio->fetch(PDO::FETCH_ASSOC);
                        $item['detalle'] = $anuncio;
                    }

                    if ($item['tipo'] === 'evaluacion') {
                        $queryEvaluacion = "SELECT id_evaluacion, titulo, descripcion, activo FROM evaluacion WHERE id_evaluacion = :id_evaluacion";
                        $stmtEvaluacion = $pdo->prepare($queryEvaluacion);
                        $stmtEvaluacion->execute(['id_evaluacion' => $item['id_referencia']]);
                        $evaluacion = $stmtEvaluacion->fetch(PDO::FETCH_ASSOC);

                        if ($evaluacion) {
                            $queryPreguntas = "SELECT id_pregunta, id_evaluacion, contenido FROM pregunta WHERE id_evaluacion = :id_evaluacion";
                            $stmtPreguntas = $pdo->prepare($queryPreguntas);
                            $stmtPreguntas->execute(['id_evaluacion' => $item['id_referencia']]);
                            $preguntas = $stmtPreguntas->fetchAll(PDO::FETCH_ASSOC);

                            foreach ($preguntas as $i => $pregunta) {
                                $queryAlternativas = "SELECT id_alternativa, id_pregunta, contenido, es_respuesta FROM alternativa WHERE id_pregunta = :id_pregunta";
                                $stmtAlternativas = $pdo->prepare($queryAlternativas);
                                $stmtAlternativas->execute(['id_pregunta' => $pregunta['id_pregunta']]);
                                $alternativas = $stmtAlternativas->fetchAll(PDO::FETCH_ASSOC);
                                $preguntas[$i]['alternativas'] = $alternativas;
                            }

                            $evaluacion['preguntas'] = $preguntas;
                        }

                        $item['detalle'] = $evaluacion;
                    }

                    $itemsConDetalle[] = $item;
                }
                $tema['items'] = $itemsConDetalle;
            }
            $curso['temas'] = $temas;
            return $curso;

        } catch (Exception $e) {
            return null;
        }
    }

    public function buscarCursos($termino)
    {
        $pdo = ConexionCapacitaciones::getInstancia()->getConexion();
        try {
            $query = "SELECT id_curso, nombre, descripcion, imagen FROM curso WHERE nombre LIKE :termino";
            $stmt = $pdo->prepare($query);
            $likeTermino = '%' . $termino . '%';
            $stmt->execute(['termino' => $likeTermino]);
            return $stmt->fetchAll(PDO::FETCH_ASSOC);
        } catch (Exception $e) {
            return [];
        }
    }

    public function crearNuevoCurso($datosCurso, $idsUsuarios)
    {
        $pdo = ConexionCapacitaciones::getInstancia()->getConexion();
        try {
            $idCurso = generarIdUnico("CUR");
            $query = "INSERT INTO curso (id_curso, nombre, descripcion, dificultad, duracion, id_autor, imagen, activo, acceso_libre) 
                      VALUES (:id_curso, :nombre, :descripcion, :dificultad, :duracion, :id_autor, :imagen, :activo, :acceso_libre)";
            $stmt = $pdo->prepare($query);
            $stmt->execute([
                'id_curso' => $idCurso,
                'nombre' => $datosCurso['nombre'],
                'descripcion' => $datosCurso['descripcion'],
                'dificultad' => $datosCurso['dificultad'],
                'duracion' => $datosCurso['duracion'],
                'id_autor' => $datosCurso['id_autor'],
                'imagen' => $datosCurso['imagen'],
                'activo' => 1,
                'acceso_libre' => $datosCurso['acceso_libre']
            ]);

            if (!empty($idsUsuarios) && is_array($idsUsuarios)) {
                $insertInscripcionQuery = "INSERT INTO curso_usuario (id_curso_usuario, id_curso, id_usuario, fecha_inicio, progreso) 
                                           VALUES (:id_curso_usuario, :id_curso, :id_usuario, NOW(), 0)";
                $stmtInscripcion = $pdo->prepare($insertInscripcionQuery);

                foreach ($idsUsuarios as $idUsuario) {
                    $idCursoUsuario = generarIdUnico("CUU");
                    $stmtInscripcion->execute([
                        'id_curso_usuario' => $idCursoUsuario,
                        'id_curso' => $idCurso,
                        'id_usuario' => $idUsuario
                    ]);
                }
            }

            return $idCurso;
        } catch (Exception $e) {
            return null;
        }
    }

    public function editarCurso($datosCurso, $idsUsuarios)
    {
        $pdo = ConexionCapacitaciones::getInstancia()->getConexion();
        try {
            $query = "UPDATE curso SET nombre = :nombre, descripcion = :descripcion, dificultad = :dificultad, duracion = :duracion, imagen = :imagen, acceso_libre = :acceso_libre WHERE id_curso = :id_curso";
            $stmt = $pdo->prepare($query);
            $stmt->execute([
                'id_curso' => $datosCurso['id_curso'],
                'nombre' => $datosCurso['nombre'],
                'descripcion' => $datosCurso['descripcion'],
                'dificultad' => $datosCurso['dificultad'],
                'duracion' => $datosCurso['duracion'],
                'imagen' => $datosCurso['imagen'],
                'acceso_libre' => $datosCurso['acceso_libre']
            ]);

            $queryUsuariosActuales = "SELECT id_usuario FROM curso_usuario WHERE id_curso = :id_curso";
            $stmtUsuariosActuales = $pdo->prepare($queryUsuariosActuales);
            $stmtUsuariosActuales->execute(['id_curso' => $datosCurso['id_curso']]);
            $usuariosActuales = $stmtUsuariosActuales->fetchAll(PDO::FETCH_COLUMN, 0);


            $idsUsuarios = is_array($idsUsuarios) ? $idsUsuarios : [];
            $usuariosAEliminar = array_diff($usuariosActuales, $idsUsuarios);
            $usuariosAAgregar = array_diff($idsUsuarios, $usuariosActuales);

            if (!empty($usuariosAEliminar)) {
                $inQuery = implode(',', array_fill(0, count($usuariosAEliminar), '?'));
                $deleteQuery = "DELETE FROM curso_usuario WHERE id_curso = ? AND id_usuario IN ($inQuery)";
                $stmtDelete = $pdo->prepare($deleteQuery);
                $stmtDelete->execute(array_merge([$datosCurso["id_curso"]], $usuariosAEliminar));
            }

            if (!empty($usuariosAAgregar)) {
                $insertQuery = "INSERT INTO curso_usuario (id_curso_usuario, id_curso, id_usuario, fecha_inicio, progreso) VALUES (:id_curso_usuario, :id_curso, :id_usuario, NOW(), 0)";
                $stmtInsert = $pdo->prepare($insertQuery);
                foreach ($usuariosAAgregar as $idUsuario) {
                    $idCursoUsuario = generarIdUnico("CUU");
                    $stmtInsert->execute([
                        'id_curso_usuario' => $idCursoUsuario,
                        'id_curso' => $datosCurso['id_curso'],
                        'id_usuario' => $idUsuario
                    ]);
                }
            }

            return $datosCurso['id_curso'];
        } catch (Exception $e) {
            return false;
        }
    }

    public function obtenerCursoFormularioPorId($idCurso)
    {
        $pdo = ConexionCapacitaciones::getInstancia()->getConexion();
        try {
            $query = "SELECT id_curso, nombre, descripcion, dificultad, duracion, imagen, activo, acceso_libre FROM curso WHERE id_curso = :id_curso";
            $stmt = $pdo->prepare($query);
            $stmt->execute(['id_curso' => $idCurso]);
            $curso = $stmt->fetch(PDO::FETCH_ASSOC);

            if ($curso) {
                // Obtener usuarios inscritos
                $queryUsuarios = "SELECT cu.id_usuario
                                  FROM curso_usuario cu
                                  WHERE cu.id_curso = :id_curso";
                $stmtUsuarios = $pdo->prepare($queryUsuarios);
                $stmtUsuarios->execute(['id_curso' => $idCurso]);
                $usuarios = $stmtUsuarios->fetchAll(PDO::FETCH_ASSOC);
                $curso['usuariosInscritos'] = array_map(function ($u) {
                    return $u['id_usuario'];
                }, $usuarios);
            }
            return $curso;
        } catch (Exception $e) {
            return null;
        }
    }
}