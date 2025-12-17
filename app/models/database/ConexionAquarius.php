<?php

class ConexionAquarius
{
    private static $instancia;
    private $conexion;

    public function __construct()
    {
        try {
            $pdo = new PDO(DATABASE_AQUARIUS_URL, DATABASE_AQUARIUS_USER, DATABASE_AQUARIUS_PASSWORD);
            // $pdo->exec("SET CHARACTER SET utf8");
            $this->conexion = $pdo;
        } catch (PDOException $e) {
            throw new Exception("Error al conectarse a la base de datos de aquarius.");
        }
    }

    public static function getInstancia()
    {
        if (self::$instancia == null) {
            self::$instancia = new ConexionAquarius();
        }

        return self::$instancia;
    }

    public function getConexion()
    {
        return $this->conexion;
    }
}