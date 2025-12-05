-- ============================================================
--                  CREACIÓN DE ESQUEMA
-- ============================================================
DROP DATABASE IF EXISTS capactia;
CREATE DATABASE capactia;
USE capactia;

SET FOREIGN_KEY_CHECKS = 0;

-- ============================================================
--                    TABLA: Usuario
-- ============================================================
CREATE TABLE usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    correo VARCHAR(150) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    documento VARCHAR(20),
    cargo VARCHAR(100),
    foto VARCHAR(255),
    telefono VARCHAR(20),
    activo TINYINT(1) DEFAULT 1,
    last_login DATETIME,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- ============================================================
--                      TABLA: Rol
-- ============================================================
CREATE TABLE rol (
    id_rol INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT
) ENGINE=InnoDB;

-- ============================================================
--                    TABLA: Acceso (Permisos)
-- ============================================================
CREATE TABLE acceso (
    id_acceso INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    codigo VARCHAR(100) NOT NULL UNIQUE,
    descripcion TEXT
) ENGINE=InnoDB;

-- ============================================================
--                  TABLA PIVOT: Usuario_Rol
-- ============================================================
CREATE TABLE usuario_rol (
    id_usuario INT NOT NULL,
    id_rol INT NOT NULL
) ENGINE=InnoDB;

-- ============================================================
--                TABLA PIVOT: Rol_Acceso
-- ============================================================
CREATE TABLE rol_acceso (
    id_rol INT NOT NULL,
    id_acceso INT NOT NULL,
    fecha_asignacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_rol, id_acceso),
    FOREIGN KEY (id_rol) REFERENCES rol(id_rol) ON DELETE CASCADE,
    FOREIGN KEY (id_acceso) REFERENCES acceso(id_acceso) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ============================================================
--                       TABLA: Ruta
-- ============================================================
CREATE TABLE ruta (
    id_ruta INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT,
    imagen VARCHAR(255),
    activo TINYINT(1) DEFAULT 1
) ENGINE=InnoDB;

-- ============================================================
--                     TABLA: Curso
-- ============================================================
CREATE TABLE curso (
    id_curso INT AUTO_INCREMENT PRIMARY KEY,
    id_ruta INT NULL,
    id_curso_base INT NULL, -- Referencia al curso plantilla (si es edición)
    codigo VARCHAR(50) UNIQUE, -- Código único: "IND-RRHH-011225"
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT,
    imagen VARCHAR(255),
    dificultad ENUM('baja','media','alta') DEFAULT 'media',
    duracion INT,
    fecha_edicion DATE NULL, -- Fecha de la edición (para cursos programados)
    id_autor INT,
    activo TINYINT(1) DEFAULT 1,
    es_edicion TINYINT(1) DEFAULT 0, -- 1 si es edición de un curso base
    FOREIGN KEY (id_ruta) REFERENCES ruta(id_ruta) ON DELETE SET NULL,
    FOREIGN KEY (id_autor) REFERENCES usuario(id_usuario) ON DELETE SET NULL,
    FOREIGN KEY (id_curso_base) REFERENCES curso(id_curso) ON DELETE SET NULL,
    INDEX idx_curso_base (id_curso_base),
    INDEX idx_edicion (es_edicion, fecha_edicion)
) ENGINE=InnoDB;

-- ============================================================
--                        TABLA: Tema
-- ============================================================
CREATE TABLE tema (
    id_tema INT AUTO_INCREMENT PRIMARY KEY,
    id_curso INT NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    orden INT DEFAULT 0,
    activo TINYINT(1) DEFAULT 1,
    FOREIGN KEY (id_curso) REFERENCES curso(id_curso) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ============================================================
--                    TABLA: Clase
-- ============================================================
CREATE TABLE clase (
    id_clase INT AUTO_INCREMENT PRIMARY KEY,
    id_tema INT NOT NULL,
    titulo VARCHAR(255) NOT NULL,
    descripcion TEXT,
    video VARCHAR(255),
    activo TINYINT(1) DEFAULT 1,
    visible TINYINT(1) DEFAULT 1, -- Control de visibilidad para estudiantes
    fecha_publicacion DATETIME, -- Fecha desde la cual es visible
    FOREIGN KEY (id_tema) REFERENCES tema(id_tema) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ============================================================
--                 TABLA: Comentario_clase
-- ============================================================
CREATE TABLE comentario_clase (
    id_comentario INT AUTO_INCREMENT PRIMARY KEY,
    id_clase INT NOT NULL,
    id_usuario INT NOT NULL,
    contenido TEXT NOT NULL,
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_clase) REFERENCES clase(id_clase) ON DELETE CASCADE,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ============================================================
--                   TABLA: Apunte_clase
-- ============================================================
CREATE TABLE apunte_clase (
    id_apunte INT AUTO_INCREMENT PRIMARY KEY,
    id_clase INT NOT NULL,
    id_usuario INT NOT NULL,
    contenido TEXT,
    archivo VARCHAR(255),
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_clase) REFERENCES clase(id_clase) ON DELETE CASCADE,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ============================================================
--                     TABLA: Anuncio
-- ============================================================
CREATE TABLE anuncio (
    id_anuncio INT AUTO_INCREMENT PRIMARY KEY,
    id_tema INT NOT NULL,
    titulo VARCHAR(255) NOT NULL,
    descripcion TEXT,
    fecha_inicio DATETIME,
    fecha_fin DATETIME,
    visible TINYINT(1) DEFAULT 1, -- Control de visibilidad para estudiantes
    activo TINYINT(1) DEFAULT 1, -- Control administrativo
    FOREIGN KEY (id_tema) REFERENCES tema(id_tema) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ============================================================
--                   TABLA: Evaluacion
-- ============================================================
CREATE TABLE evaluacion (
    id_evaluacion INT AUTO_INCREMENT PRIMARY KEY,
    id_tema INT NOT NULL,
    titulo VARCHAR(255) NOT NULL,
    descripcion TEXT,
    activo TINYINT(1) DEFAULT 1,
    visible TINYINT(1) DEFAULT 1, -- Control de visibilidad para estudiantes
    fecha_publicacion DATETIME, -- Fecha desde la cual es visible
    FOREIGN KEY (id_tema) REFERENCES tema(id_tema) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ============================================================
--               TABLA: Evaluacion_usuario
-- ============================================================
CREATE TABLE evaluacion_usuario (
    id_eval_usuario INT AUTO_INCREMENT PRIMARY KEY,
    id_evaluacion INT NOT NULL,
    id_usuario INT NOT NULL,
    nota DECIMAL(5,2),
    intentos INT DEFAULT 1,
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_evaluacion) REFERENCES evaluacion(id_evaluacion) ON DELETE CASCADE,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ============================================================
--                      TABLA: Pregunta
-- ============================================================
CREATE TABLE pregunta (
    id_pregunta INT AUTO_INCREMENT PRIMARY KEY,
    id_evaluacion INT NOT NULL,
    contenido TEXT NOT NULL,
    tipo ENUM('alternativa','vf','desarrollo') DEFAULT 'alternativa',
    puntaje INT DEFAULT 1,
    FOREIGN KEY (id_evaluacion) REFERENCES evaluacion(id_evaluacion) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ============================================================
--                    TABLA: Alternativa
-- ============================================================
CREATE TABLE alternativa (
    id_alternativa INT AUTO_INCREMENT PRIMARY KEY,
    id_pregunta INT NOT NULL,
    contenido TEXT NOT NULL,
    es_respuesta TINYINT(1) DEFAULT 0,
    retroalimentacion TEXT,
    FOREIGN KEY (id_pregunta) REFERENCES pregunta(id_pregunta) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ============================================================
--      TABLA: Asistencia (para cursos presenciales/virtuales)
-- ============================================================
CREATE TABLE asistencia (
    id_asistencia INT AUTO_INCREMENT PRIMARY KEY,
    id_tema INT NOT NULL,
    titulo VARCHAR(255) NOT NULL,
    descripcion TEXT,
    fecha_asistencia DATETIME, -- Fecha de la sesión presencial
    link_reunion VARCHAR(255), -- Link de Zoom u otra plataforma
    clave_asistencia VARCHAR(50), -- Código secreto que da el instructor
    requiere_clave TINYINT(1) DEFAULT 0, -- Si requiere clave para marcar asistencia
    activo TINYINT(1) DEFAULT 1,
    visible TINYINT(1) DEFAULT 1, -- Control de visibilidad
    FOREIGN KEY (id_tema) REFERENCES tema(id_tema) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ============================================================
--      TABLA: Asistencia_usuario (registro de asistencia)
-- ============================================================
CREATE TABLE asistencia_usuario (
    id_asistencia_usuario INT AUTO_INCREMENT PRIMARY KEY,
    id_asistencia INT NOT NULL,
    id_usuario INT NOT NULL,
    asistio TINYINT(1) DEFAULT 0, -- 0: no asistió, 1: asistió
    clave_ingresada VARCHAR(50), -- La clave que ingresó el usuario
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    observaciones TEXT,
    FOREIGN KEY (id_asistencia) REFERENCES asistencia(id_asistencia) ON DELETE CASCADE,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE,
    UNIQUE KEY unico_asistencia_usuario (id_asistencia, id_usuario)
) ENGINE=InnoDB;

-- ============================================================
--      TABLA: Tema_item (ESTILO UDEMY)
--  Mezcla: clases, anuncios, evaluaciones, asistencias dentro de un tema
-- ============================================================
CREATE TABLE tema_item (
    id_item INT AUTO_INCREMENT PRIMARY KEY,
    id_tema INT NOT NULL,
    tipo ENUM('clase','evaluacion','anuncio','asistencia') NOT NULL,
    id_referencia INT NOT NULL,
    orden INT DEFAULT 0,

    FOREIGN KEY (id_tema) REFERENCES tema(id_tema) ON DELETE CASCADE,
    INDEX idx_tema_orden (id_tema, orden)
) ENGINE=InnoDB;

-- ============================================================
--      TABLA: Curso_usuario (inscripciones y progreso)
-- ============================================================
CREATE TABLE curso_usuario (
    id_curso_usuario INT AUTO_INCREMENT PRIMARY KEY,
    id_curso INT NOT NULL,
    id_usuario INT NOT NULL,
    fecha_inicio DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_fin DATETIME,
    progreso INT DEFAULT 0, -- Porcentaje 0-100
    nota_final DECIMAL(5,2),
    certificado_emitido TINYINT(1) DEFAULT 0,
    estado ENUM('en_progreso','completado','abandonado') DEFAULT 'en_progreso',

    FOREIGN KEY (id_curso) REFERENCES curso(id_curso) ON DELETE CASCADE,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE,
    UNIQUE KEY unico_curso_usuario (id_curso, id_usuario), -- Solo 1 inscripción por edición
    INDEX idx_usuario_curso (id_usuario, id_curso)
) ENGINE=InnoDB;

-- ============================================================
--      TABLA: Progreso_item (seguimiento de clases/evaluaciones)
-- ============================================================
CREATE TABLE progreso_item (
    id_progreso INT AUTO_INCREMENT PRIMARY KEY,
    id_curso_usuario INT NOT NULL,
    id_item INT NOT NULL, -- Referencia a tema_item
    completado TINYINT(1) DEFAULT 0,
    fecha_completado DATETIME,
    tiempo_visto INT DEFAULT 0, -- Segundos (para clases)
    
    FOREIGN KEY (id_curso_usuario) REFERENCES curso_usuario(id_curso_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_item) REFERENCES tema_item(id_item) ON DELETE CASCADE,
    UNIQUE KEY unico_progreso (id_curso_usuario, id_item)
) ENGINE=InnoDB;

SET FOREIGN_KEY_CHECKS = 1;
