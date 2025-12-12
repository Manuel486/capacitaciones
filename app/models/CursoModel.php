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
            $query = "SELECT id_curso, nombre, descripcion, imagen FROM curso WHERE activo = 1 AND acceso_libre = 1";
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
                $curso['temas'] = [];
                foreach ($temas as $tema) {
                    $queryItems = "SELECT ti.id_item, ti.id_tema, ti.tipo, ti.id_referencia, ti.orden 
                                   FROM tema_item ti
                                   WHERE ti.id_tema = :id_tema 
                                   ORDER BY orden ASC";
                    $stmtItems = $pdo->prepare($queryItems);
                    $stmtItems->execute(['id_tema' => $tema['id_tema']]);
                    $items = $stmtItems->fetchAll(PDO::FETCH_ASSOC);

                    $itemsFiltrados = [];
                    foreach ($items as &$item) {
                        if ($item['tipo'] === 'clase') {
                            $queryClase = "SELECT id_clase, titulo, descripcion, video, activo FROM clase WHERE id_clase = :id_clase AND activo = 1";
                            $stmtClase = $pdo->prepare($queryClase);
                            $stmtClase->execute(['id_clase' => $item['id_referencia']]);
                            $clase = $stmtClase->fetch(PDO::FETCH_ASSOC);
                            if (!$clase) {
                                continue;
                            }
                            $item['detalle'] = $clase;
                        } elseif ($item['tipo'] === 'anuncio') {
                            $queryAnuncio = "SELECT id_anuncio, titulo, descripcion, anuncio, activo FROM anuncio WHERE id_anuncio = :id_anuncio AND activo = 1";
                            $stmtAnuncio = $pdo->prepare($queryAnuncio);
                            $stmtAnuncio->execute(['id_anuncio' => $item['id_referencia']]);
                            $anuncio = $stmtAnuncio->fetch(PDO::FETCH_ASSOC);
                            if (!$anuncio) {
                                continue;
                            }
                            $item['detalle'] = $anuncio;
                        } elseif ($item['tipo'] === 'evaluacion') {
                            $queryEvaluacion = "SELECT id_evaluacion, titulo, descripcion, activo FROM evaluacion WHERE id_evaluacion = :id_evaluacion AND activo = 1";
                            $stmtEvaluacion = $pdo->prepare($queryEvaluacion);
                            $stmtEvaluacion->execute(['id_evaluacion' => $item['id_referencia']]);
                            $evaluacion = $stmtEvaluacion->fetch(PDO::FETCH_ASSOC);
                            if (!$evaluacion) {
                                continue;
                            }
                            $item['detalle'] = $evaluacion;
                        }
                        $itemsFiltrados[] = $item;
                    }
                    unset($item);

                    $tema['items'] = $itemsFiltrados;
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

            $queryCursoUsuario = "SELECT id_curso_usuario, id_curso, id_usuario, progreso FROM curso_usuario WHERE id_curso = :id_curso AND id_usuario = :id_usuario";
            $stmtCursoUsuario = $pdo->prepare($queryCursoUsuario);
            $stmtCursoUsuario->execute(['id_curso' => $idCurso, 'id_usuario' => $idUsuario]);
            $cursoUsuario = $stmtCursoUsuario->fetch(PDO::FETCH_ASSOC);

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

                    if ($item['tipo'] === 'clase') {
                        $queryClase = "SELECT id_clase, titulo, descripcion, video, activo FROM clase WHERE id_clase = :id_clase AND activo = 1";
                        $stmtClase = $pdo->prepare($queryClase);
                        $stmtClase->execute(['id_clase' => $item['id_referencia']]);
                        $clase = $stmtClase->fetch(PDO::FETCH_ASSOC);

                        if (!$clase) {
                            continue;
                        }
                        $item['detalle'] = $clase;
                    }

                    if ($item['tipo'] === 'anuncio') {
                        $queryAnuncio = "SELECT id_anuncio, titulo, descripcion, anuncio, activo FROM anuncio WHERE id_anuncio = :id_anuncio AND activo = 1";
                        $stmtAnuncio = $pdo->prepare($queryAnuncio);
                        $stmtAnuncio->execute(['id_anuncio' => $item['id_referencia']]);
                        $anuncio = $stmtAnuncio->fetch(PDO::FETCH_ASSOC);

                        if (!$anuncio) {
                            continue;
                        }
                        $item['detalle'] = $anuncio;
                    }

                    if ($item['tipo'] === 'evaluacion') {
                        $queryEvaluacion = "SELECT id_evaluacion, titulo, descripcion, activo FROM evaluacion WHERE id_evaluacion = :id_evaluacion AND activo = 1";
                        $stmtEvaluacion = $pdo->prepare($queryEvaluacion);
                        $stmtEvaluacion->execute(['id_evaluacion' => $item['id_referencia']]);
                        $evaluacion = $stmtEvaluacion->fetch(PDO::FETCH_ASSOC);

                        if (!$evaluacion) {
                            continue;
                        }

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
                $insertInscripcionQuery = "INSERT INTO curso_usuario (id_curso_usuario, id_curso, id_usuario, fecha_inicio, progreso, obligatorio) 
                                           VALUES (:id_curso_usuario, :id_curso, :id_usuario, NOW(), 0, 1)";
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
                $insertQuery = "INSERT INTO curso_usuario (id_curso_usuario, id_curso, id_usuario, fecha_inicio, progreso, obligatorio) VALUES (:id_curso_usuario, :id_curso, :id_usuario, NOW(), 0, 1)";
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

                // Obtener temas e items
                $queryTemas = "SELECT id_tema, id_curso, nombre, orden, activo FROM tema WHERE id_curso = :id_curso ORDER BY orden ASC";
                $stmtTemas = $pdo->prepare($queryTemas);
                $stmtTemas->execute(['id_curso' => $idCurso]);
                $temas = $stmtTemas->fetchAll(PDO::FETCH_ASSOC);

                if (count($temas) > 0) {
                    foreach ($temas as $i => $tema) {
                        $queryItems = "SELECT id_item, id_tema, tipo, id_referencia, orden FROM tema_item WHERE id_tema = :id_tema ORDER BY orden ASC";
                        $stmtItems = $pdo->prepare($queryItems);
                        $stmtItems->execute(['id_tema' => $tema['id_tema']]);
                        $items = $stmtItems->fetchAll(PDO::FETCH_ASSOC);

                        foreach ($items as $j => $item) {
                            if ($item['tipo'] === 'clase') {
                                $queryClase = "SELECT id_clase, titulo, descripcion, video, activo FROM clase WHERE id_clase = :id_clase";
                                $stmtClase = $pdo->prepare($queryClase);
                                $stmtClase->execute(['id_clase' => $item['id_referencia']]);
                                $items[$j]['detalle'] = $stmtClase->fetch(PDO::FETCH_ASSOC);
                            } elseif ($item['tipo'] === 'anuncio') {
                                $queryAnuncio = "SELECT id_anuncio, titulo, descripcion, anuncio, activo FROM anuncio WHERE id_anuncio = :id_anuncio";
                                $stmtAnuncio = $pdo->prepare($queryAnuncio);
                                $stmtAnuncio->execute(['id_anuncio' => $item['id_referencia']]);
                                $items[$j]['detalle'] = $stmtAnuncio->fetch(PDO::FETCH_ASSOC);
                            } elseif ($item['tipo'] === 'evaluacion') {
                                $queryEvaluacion = "SELECT id_evaluacion, titulo, descripcion, activo FROM evaluacion WHERE id_evaluacion = :id_evaluacion";
                                $stmtEvaluacion = $pdo->prepare($queryEvaluacion);
                                $stmtEvaluacion->execute(['id_evaluacion' => $item['id_referencia']]);
                                $evaluacion = $stmtEvaluacion->fetch(PDO::FETCH_ASSOC);

                                if ($evaluacion) {
                                    $queryPreguntas = "SELECT id_pregunta, id_evaluacion, contenido FROM pregunta WHERE id_evaluacion = :id_evaluacion";
                                    $stmtPreguntas = $pdo->prepare($queryPreguntas);
                                    $stmtPreguntas->execute(['id_evaluacion' => $item['id_referencia']]);
                                    $preguntas = $stmtPreguntas->fetchAll(PDO::FETCH_ASSOC);

                                    foreach ($preguntas as $k => $pregunta) {
                                        $queryAlternativas = "SELECT id_alternativa, id_pregunta, contenido, es_respuesta FROM alternativa WHERE id_pregunta = :id_pregunta";
                                        $stmtAlternativas = $pdo->prepare($queryAlternativas);
                                        $stmtAlternativas->execute(['id_pregunta' => $pregunta['id_pregunta']]);
                                        $preguntas[$k]['alternativas'] = $stmtAlternativas->fetchAll(PDO::FETCH_ASSOC);
                                    }

                                    $evaluacion['preguntas'] = $preguntas;
                                }

                                $items[$j]['detalle'] = $evaluacion;
                            }
                        }
                        $temas[$i]['items'] = $items;
                    }
                    $curso['temas'] = $temas;
                } else {
                    $curso['temas'] = [];
                }
            }
            return $curso;
        } catch (Exception $e) {
            return null;
        }
    }

    public function guardarClase($datosClase)
    {
        $pdo = ConexionCapacitaciones::getInstancia()->getConexion();
        try {
            $idClase = generarIdUnico("CLA");
            $query = "INSERT INTO clase (id_clase, titulo, descripcion, video, activo) 
                          VALUES (:id_clase, :titulo, :descripcion, :video, :activo)";
            $stmt = $pdo->prepare($query);
            $stmt->execute([
                'id_clase' => $idClase,
                'titulo' => $datosClase['titulo'],
                'descripcion' => $datosClase['descripcion'],
                'video' => $datosClase['video'],
                'activo' => $datosClase['activo']
            ]);

            // Registrar en tema_item
            $idItem = generarIdUnico("ITEM");
            $queryItem = "INSERT INTO tema_item (id_item, id_tema, tipo, id_referencia, orden) 
                          VALUES (:id_item, :id_tema, :tipo, :id_referencia, :orden)";
            $stmtItem = $pdo->prepare($queryItem);
            $stmtItem->execute([
                'id_item' => $idItem,
                'id_tema' => $datosClase['id_tema'],
                'tipo' => 'clase',
                'id_referencia' => $idClase,
                'orden' => $datosClase['orden']
            ]);

            // Obtener el item y su detalle para retornar
            $item = [
                'id_item' => $idItem,
                'id_tema' => $datosClase['id_tema'],
                'tipo' => 'clase',
                'id_referencia' => $idClase,
                'orden' => $datosClase['orden'],
                'detalle' => [
                    'id_clase' => $idClase,
                    'titulo' => $datosClase['titulo'],
                    'descripcion' => $datosClase['descripcion'],
                    'video' => $datosClase['video'],
                    'activo' => $datosClase['activo']
                ]
            ];

            return $item;
        } catch (Exception $e) {
            return null;
        }
    }

    public function editarClase($datosClase)
    {
        $pdo = ConexionCapacitaciones::getInstancia()->getConexion();
        try {
            $query = "UPDATE clase SET titulo = :titulo, descripcion = :descripcion, video = :video, activo = :activo WHERE id_clase = :id_clase";
            $stmt = $pdo->prepare($query);
            $stmt->execute([
                'id_clase' => $datosClase['id_clase'],
                'titulo' => $datosClase['titulo'],
                'descripcion' => $datosClase['descripcion'],
                'video' => $datosClase['video'],
                'activo' => $datosClase['activo']
            ]);

            if (isset($datosClase['id_item']) && isset($datosClase['orden'])) {
                $queryItem = "UPDATE tema_item SET orden = :orden WHERE id_item = :id_item";
                $stmtItem = $pdo->prepare($queryItem);
                $stmtItem->execute([
                    'id_item' => $datosClase['id_item'],
                    'orden' => $datosClase['orden']
                ]);
            }

            $item = [
                'id_item' => $datosClase['id_item'] ?? null,
                'id_tema' => $datosClase['id_tema'] ?? null,
                'tipo' => 'clase',
                'id_referencia' => $datosClase['id_clase'],
                'orden' => $datosClase['orden'] ?? null,
                'detalle' => [
                    'id_clase' => $datosClase['id_clase'],
                    'titulo' => $datosClase['titulo'],
                    'descripcion' => $datosClase['descripcion'],
                    'video' => $datosClase['video'],
                    'activo' => $datosClase['activo']
                ]
            ];

            return $item;
        } catch (Exception $e) {
            return null;
        }
    }

    public function guardarAnuncio($datosAnuncio)
    {
        $pdo = ConexionCapacitaciones::getInstancia()->getConexion();
        try {
            $idAnuncio = generarIdUnico("ANA");
            $query = "INSERT INTO anuncio (id_anuncio, titulo, descripcion, anuncio, activo) 
                          VALUES (:id_anuncio, :titulo, :descripcion, :anuncio, :activo)";
            $stmt = $pdo->prepare($query);
            $stmt->execute([
                'id_anuncio' => $idAnuncio,
                'titulo' => $datosAnuncio['titulo'],
                'descripcion' => $datosAnuncio['descripcion'],
                'anuncio' => $datosAnuncio['anuncio'],
                'activo' => $datosAnuncio['activo']
            ]);

            // Registrar en tema_item
            $idItem = generarIdUnico("ITEM");
            $queryItem = "INSERT INTO tema_item (id_item, id_tema, tipo, id_referencia, orden) 
                          VALUES (:id_item, :id_tema, :tipo, :id_referencia, :orden)";
            $stmtItem = $pdo->prepare($queryItem);
            $stmtItem->execute([
                'id_item' => $idItem,
                'id_tema' => $datosAnuncio['id_tema'],
                'tipo' => 'anuncio',
                'id_referencia' => $idAnuncio,
                'orden' => $datosAnuncio['orden']
            ]);

            // Obtener el item y su detalle para retornar
            $item = [
                'id_item' => $idItem,
                'id_tema' => $datosAnuncio['id_tema'],
                'tipo' => 'anuncio',
                'id_referencia' => $idAnuncio,
                'orden' => $datosAnuncio['orden'],
                'detalle' => [
                    'id_anuncio' => $idAnuncio,
                    'titulo' => $datosAnuncio['titulo'],
                    'descripcion' => $datosAnuncio['descripcion'],
                    'anuncio' => $datosAnuncio['anuncio'],
                    'activo' => $datosAnuncio['activo']
                ]
            ];

            return $item;
        } catch (Exception $e) {
            return null;
        }
    }

    public function editarAnuncio($datosAnuncio)
    {
        $pdo = ConexionCapacitaciones::getInstancia()->getConexion();
        try {
            $query = "UPDATE anuncio SET titulo = :titulo, descripcion = :descripcion, anuncio = :anuncio, activo = :activo WHERE id_anuncio = :id_anuncio";
            $stmt = $pdo->prepare($query);
            $stmt->execute([
                'id_anuncio' => $datosAnuncio['id_anuncio'],
                'titulo' => $datosAnuncio['titulo'],
                'descripcion' => $datosAnuncio['descripcion'],
                'anuncio' => $datosAnuncio['anuncio'],
                'activo' => $datosAnuncio['activo']
            ]);

            if (isset($datosAnuncio['id_item']) && isset($datosAnuncio['orden'])) {
                $queryItem = "UPDATE tema_item SET orden = :orden WHERE id_item = :id_item";
                $stmtItem = $pdo->prepare($queryItem);
                $stmtItem->execute([
                    'id_item' => $datosAnuncio['id_item'],
                    'orden' => $datosAnuncio['orden']
                ]);
            }

            $item = [
                'id_item' => $datosAnuncio['id_item'] ?? null,
                'id_tema' => $datosAnuncio['id_tema'] ?? null,
                'tipo' => 'anuncio',
                'id_referencia' => $datosAnuncio['id_anuncio'],
                'orden' => $datosAnuncio['orden'] ?? null,
                'detalle' => [
                    'id_anuncio' => $datosAnuncio['id_anuncio'],
                    'titulo' => $datosAnuncio['titulo'],
                    'descripcion' => $datosAnuncio['descripcion'],
                    'anuncio' => $datosAnuncio['anuncio'],
                    'activo' => $datosAnuncio['activo']
                ]
            ];

            return $item;
        } catch (Exception $e) {
            return null;
        }
    }

    public function guardarTema($datosTema)
    {
        $pdo = ConexionCapacitaciones::getInstancia()->getConexion();
        try {
            $idTema = generarIdUnico("TEM");
            $query = "INSERT INTO tema (id_tema, id_curso, nombre, orden, activo) 
                          VALUES (:id_tema, :id_curso, :nombre, :orden, :activo)";
            $stmt = $pdo->prepare($query);
            $stmt->execute([
                'id_tema' => $idTema,
                'id_curso' => $datosTema['id_curso'],
                'nombre' => $datosTema['nombre'],
                'orden' => $datosTema['orden'],
                'activo' => $datosTema['activo']
            ]);

            return [
                'id_tema' => $idTema,
                'id_curso' => $datosTema['id_curso'],
                'nombre' => $datosTema['nombre'],
                'orden' => $datosTema['orden'],
                'activo' => $datosTema['activo']
            ];
        } catch (Exception $e) {
            return null;
        }
    }

    public function editarTema($datosTema)
    {
        $pdo = ConexionCapacitaciones::getInstancia()->getConexion();
        try {
            $query = "UPDATE tema SET nombre = :nombre, orden = :orden, activo = :activo WHERE id_tema = :id_tema";
            $stmt = $pdo->prepare($query);
            $stmt->execute([
                'id_tema' => $datosTema['id_tema'],
                'nombre' => $datosTema['nombre'],
                'orden' => $datosTema['orden'],
                'activo' => $datosTema['activo']
            ]);

            return [
                'id_tema' => $datosTema['id_tema'],
                'id_curso' => $datosTema['id_curso'],
                'nombre' => $datosTema['nombre'],
                'orden' => $datosTema['orden'],
                'activo' => $datosTema['activo']
            ];
        } catch (Exception $e) {
            return null;
        }
    }

    public function guardarEvaluacion($datosEvaluacion)
    {
        $pdo = ConexionCapacitaciones::getInstancia()->getConexion();
        try {
            $idEvaluacion = generarIdUnico("EVA");
            $query = "INSERT INTO evaluacion (id_evaluacion, titulo, descripcion, activo) 
                          VALUES (:id_evaluacion, :titulo, :descripcion, :activo)";
            $stmt = $pdo->prepare($query);
            $stmt->execute([
                'id_evaluacion' => $idEvaluacion,
                'titulo' => $datosEvaluacion['titulo'],
                'descripcion' => $datosEvaluacion['descripcion'],
                'activo' => $datosEvaluacion['activo']
            ]);

            // Registrar en tema_item
            $idItem = generarIdUnico("ITEM");
            $queryItem = "INSERT INTO tema_item (id_item, id_tema, tipo, id_referencia, orden) 
                          VALUES (:id_item, :id_tema, :tipo, :id_referencia, :orden)";
            $stmtItem = $pdo->prepare($queryItem);
            $stmtItem->execute([
                'id_item' => $idItem,
                'id_tema' => $datosEvaluacion['id_tema'],
                'tipo' => 'evaluacion',
                'id_referencia' => $idEvaluacion,
                'orden' => $datosEvaluacion['orden']
            ]);

            // Registrar preguntas y alternativas si existen
            if (isset($datosEvaluacion['preguntas']) && is_array($datosEvaluacion['preguntas'])) {
                foreach ($datosEvaluacion['preguntas'] as $preguntaData) {
                    $idPregunta = generarIdUnico("PRE");
                    $queryPregunta = "INSERT INTO pregunta (id_pregunta, id_evaluacion, contenido) 
                                      VALUES (:id_pregunta, :id_evaluacion, :contenido)";
                    $stmtPregunta = $pdo->prepare($queryPregunta);
                    $stmtPregunta->execute([
                        'id_pregunta' => $idPregunta,
                        'id_evaluacion' => $idEvaluacion,
                        'contenido' => $preguntaData['contenido']
                    ]);

                    if (isset($preguntaData['alternativas']) && is_array($preguntaData['alternativas'])) {
                        foreach ($preguntaData['alternativas'] as $alternativaData) {
                            $idAlternativa = generarIdUnico("ALT");
                            $queryAlternativa = "INSERT INTO alternativa (id_alternativa, id_pregunta, contenido, es_respuesta) 
                                                 VALUES (:id_alternativa, :id_pregunta, :contenido, :es_respuesta)";
                            $stmtAlternativa = $pdo->prepare($queryAlternativa);
                            $stmtAlternativa->execute([
                                'id_alternativa' => $idAlternativa,
                                'id_pregunta' => $idPregunta,
                                'contenido' => $alternativaData['contenido'],
                                'es_respuesta' => $alternativaData['es_respuesta']
                            ]);
                        }
                    }
                }
            }

            // Obtener el item y su detalle para retornar
            $item = [
                'id_item' => $idItem,
                'id_tema' => $datosEvaluacion['id_tema'],
                'tipo' => 'evaluacion',
                'id_referencia' => $idEvaluacion,
                'orden' => $datosEvaluacion['orden'],
                'detalle' => [
                    'id_evaluacion' => $idEvaluacion,
                    'titulo' => $datosEvaluacion['titulo'],
                    'descripcion' => $datosEvaluacion['descripcion'],
                    'activo' => $datosEvaluacion['activo'],
                    'preguntas' => $datosEvaluacion['preguntas'] ?? []
                ]
            ];

            return $item;
        } catch (Exception $e) {
            return null;
        }
    }

    public function editarEvaluacion($datosEvaluacion)
    {
        $pdo = ConexionCapacitaciones::getInstancia()->getConexion();
        try {
            $query = "UPDATE evaluacion SET titulo = :titulo, descripcion = :descripcion, activo = :activo WHERE id_evaluacion = :id_evaluacion";
            $stmt = $pdo->prepare($query);
            $stmt->execute([
                'id_evaluacion' => $datosEvaluacion['id_evaluacion'],
                'titulo' => $datosEvaluacion['titulo'],
                'descripcion' => $datosEvaluacion['descripcion'],
                'activo' => $datosEvaluacion['activo']
            ]);

            if (isset($datosEvaluacion['id_item']) && isset($datosEvaluacion['orden'])) {
                $queryItem = "UPDATE tema_item SET orden = :orden WHERE id_item = :id_item";
                $stmtItem = $pdo->prepare($queryItem);
                $stmtItem->execute([
                    'id_item' => $datosEvaluacion['id_item'],
                    'orden' => $datosEvaluacion['orden']
                ]);
            }

            // Eliminar preguntas y alternativas relacionadas a la evaluación
            $queryEliminarPreguntas = "SELECT id_pregunta FROM pregunta WHERE id_evaluacion = :id_evaluacion";
            $stmtEliminarPreguntas = $pdo->prepare($queryEliminarPreguntas);
            $stmtEliminarPreguntas->execute(['id_evaluacion' => $datosEvaluacion['id_evaluacion']]);
            $preguntasExistentes = $stmtEliminarPreguntas->fetchAll(PDO::FETCH_COLUMN, 0);

            if (!empty($preguntasExistentes)) {
                $inQueryPreguntas = implode(',', array_fill(0, count($preguntasExistentes), '?'));

                $queryEliminarAlternativas = "DELETE FROM alternativa WHERE id_pregunta IN ($inQueryPreguntas)";
                $stmtEliminarAlternativas = $pdo->prepare($queryEliminarAlternativas);
                $stmtEliminarAlternativas->execute($preguntasExistentes);

                $queryEliminarPreguntasFinal = "DELETE FROM pregunta WHERE id_evaluacion = :id_evaluacion";
                $stmtEliminarPreguntasFinal = $pdo->prepare($queryEliminarPreguntasFinal);
                $stmtEliminarPreguntasFinal->execute(['id_evaluacion' => $datosEvaluacion['id_evaluacion']]);
            }

            // Registrar nuevas preguntas y alternativas si existen
            if (isset($datosEvaluacion['preguntas']) && is_array($datosEvaluacion['preguntas'])) {
                foreach ($datosEvaluacion['preguntas'] as $preguntaData) {
                    $idPregunta = generarIdUnico("PRE");
                    $queryPregunta = "INSERT INTO pregunta (id_pregunta, id_evaluacion, contenido) 
                                      VALUES (:id_pregunta, :id_evaluacion, :contenido)";
                    $stmtPregunta = $pdo->prepare($queryPregunta);
                    $stmtPregunta->execute([
                        'id_pregunta' => $idPregunta,
                        'id_evaluacion' => $datosEvaluacion['id_evaluacion'],
                        'contenido' => $preguntaData['contenido']
                    ]);

                    if (isset($preguntaData['alternativas']) && is_array($preguntaData['alternativas'])) {
                        foreach ($preguntaData['alternativas'] as $alternativaData) {
                            $idAlternativa = generarIdUnico("ALT");
                            $queryAlternativa = "INSERT INTO alternativa (id_alternativa, id_pregunta, contenido, es_respuesta) 
                                                 VALUES (:id_alternativa, :id_pregunta, :contenido, :es_respuesta)";
                            $stmtAlternativa = $pdo->prepare($queryAlternativa);
                            $stmtAlternativa->execute([
                                'id_alternativa' => $idAlternativa,
                                'id_pregunta' => $idPregunta,
                                'contenido' => $alternativaData['contenido'],
                                'es_respuesta' => $alternativaData['es_respuesta']
                            ]);
                        }
                    }
                }
            }

            $item = [
                'id_item' => $datosEvaluacion['id_item'] ?? null,
                'id_tema' => $datosEvaluacion['id_tema'] ?? null,
                'tipo' => 'evaluacion',
                'id_referencia' => $datosEvaluacion['id_evaluacion'],
                'orden' => $datosEvaluacion['orden'] ?? null,
                'detalle' => [
                    'id_evaluacion' => $datosEvaluacion['id_evaluacion'],
                    'titulo' => $datosEvaluacion['titulo'],
                    'descripcion' => $datosEvaluacion['descripcion'],
                    'activo' => $datosEvaluacion['activo'],
                    'preguntas' => $datosEvaluacion['preguntas'] ?? []
                ]
            ];

            return $item;
        } catch (Exception $e) {
            return null;
        }
    }

    public function cambiarEstadoCurso($idCurso, $nuevoEstado)
    {
        $pdo = ConexionCapacitaciones::getInstancia()->getConexion();
        try {
            $query = "UPDATE curso SET activo = :activo WHERE id_curso = :id_curso";
            $stmt = $pdo->prepare($query);
            $stmt->execute([
                'id_curso' => $idCurso,
                'activo' => $nuevoEstado
            ]);
            return true;
        } catch (Exception $e) {
            return false;
        }
    }

    public function cambiarEstadoItem($idItem, $nuevoEstado)
    {
        $pdo = ConexionCapacitaciones::getInstancia()->getConexion();
        try {
            $queryTipo = "SELECT tipo, id_referencia FROM tema_item WHERE id_item = :id_item";
            $stmtTipo = $pdo->prepare($queryTipo);
            $stmtTipo->execute(['id_item' => $idItem]);
            $item = $stmtTipo->fetch(PDO::FETCH_ASSOC);

            if (!$item) {
                return false;
            }

            $tabla = '';
            switch ($item['tipo']) {
                case 'clase':
                    $tabla = 'clase';
                    break;
                case 'anuncio':
                    $tabla = 'anuncio';
                    break;
                case 'evaluacion':
                    $tabla = 'evaluacion';
                    break;
                default:
                    return false;
            }

            $queryActualizar = "UPDATE $tabla SET activo = :activo WHERE " . ($item['tipo'] === 'clase' ? 'id_clase' : ($item['tipo'] === 'anuncio' ? 'id_anuncio' : 'id_evaluacion')) . " = :id_referencia";
            $stmtActualizar = $pdo->prepare($queryActualizar);
            $stmtActualizar->execute([
                'activo' => $nuevoEstado,
                'id_referencia' => $item['id_referencia']
            ]);

            return true;
        } catch (Exception $e) {
            return false;
        }
    }

    public function obtenerComentariosPorItemId($idItem)
    {
        $pdo = ConexionCapacitaciones::getInstancia()->getConexion();
        try {
            $query = "SELECT c.id_comentario, c.id_item, c.dni_usuario, c.nombre_usuario, c.comentario, c.fecha_creacion
                      FROM comentario c
                      WHERE c.id_item = :id_item
                      ORDER BY c.fecha_creacion DESC";
            $stmt = $pdo->prepare($query);
            $stmt->execute(['id_item' => $idItem]);
            return $stmt->fetchAll(PDO::FETCH_ASSOC);
        } catch (Exception $e) {
            return [];
        }
    }

    public function guardarComentario($datosComentario)
    {
        $pdo = ConexionCapacitaciones::getInstancia()->getConexion();
        try {
            $idComentario = generarIdUnico("COM");
            $query = "INSERT INTO comentario (id_comentario, id_item, dni_usuario, nombre_usuario, comentario, fecha_creacion) 
                      VALUES (:id_comentario, :id_item, :dni_usuario, :nombre_usuario, :comentario, :fecha_creacion)";
            $stmt = $pdo->prepare($query);
            $stmt->execute([
                'id_comentario' => $idComentario,
                'id_item' => $datosComentario['id_item'],
                'dni_usuario' => $datosComentario['dni_usuario'],
                'nombre_usuario' => $datosComentario['nombre_usuario'],
                'comentario' => $datosComentario['comentario'],
                'fecha_creacion' => $datosComentario['fecha_creacion'] ?? date('Y-m-d H:i:s')
            ]);

            return [
                'id_comentario' => $idComentario,
                'id_item' => $datosComentario['id_item'],
                'dni_usuario' => $datosComentario['dni_usuario'],
                'nombre_usuario' => $datosComentario['nombre_usuario'],
                'comentario' => $datosComentario['comentario'],
                'fecha_creacion' => $datosComentario['fecha_creacion'] ?? date('Y-m-d H:i:s')
            ];
        } catch (Exception $e) {
            return null;
        }
    }

}