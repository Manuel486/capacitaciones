<?php

class ConexionDocumentos
{
    private static $instancia;
    private $conexion;

    public function __construct()
    {
        try {
            $pdo = new PDO(DATABASE_DOCUMENTOS_URL, DATABASE_DOCUMENTOS_USER, DATABASE_DOCUMENTOS_PASSWORD);
            $pdo->exec("SET CHARACTER SET utf8");
            $this->conexion = $pdo;
        } catch (PDOException $e) {
            throw new Exception("Error al conectarse a la base de datos de documentos.");
        }
    }

    public static function getInstancia()
    {
        if (self::$instancia == null) {
            self::$instancia = new ConexionDocumentos();
        }

        return self::$instancia;
    }

    public function getConexion()
    {
        return $this->conexion;
    }
}
