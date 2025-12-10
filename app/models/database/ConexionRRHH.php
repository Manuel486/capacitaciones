<?php

class ConexionRRHH
{
    private static $instancia;
    private $conexion;

    public function __construct()
    {
        try {
            $pdo = new PDO(DATABASE_RRHH_URL, DATABASE_RRHH_USER, DATABASE_RRHH_PASSWORD);
            $pdo->exec("SET CHARACTER SET utf8");
            $this->conexion = $pdo;
        } catch (PDOException $e) {
            throw new Exception("Error al conectarse a la base de datos de rrhh.");
        }
    }

    public static function getInstancia()
    {
        if (self::$instancia == null) {
            self::$instancia = new ConexionRRHH();
        }

        return self::$instancia;
    }

    public function getConexion()
    {
        return $this->conexion;
    }
}
