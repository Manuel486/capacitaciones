<?php

class ConexionCapacitaciones
{
    private static $instancia;
    private $conexion;

    public function __construct()
    {
        try {
            $pdo = new PDO(DATABASE_CAPACITACIONES_URL, DATABASE_CAPACITACIONES_USER, DATABASE_CAPACITACIONES_PASSWORD);
            $pdo->exec("SET CHARACTER SET utf8");
            $this->conexion = $pdo;
        } catch (PDOException $e) {
            throw new Exception("Error al conectarse a la base de datos de capcitaciones.");
        }
    }

    public static function getInstancia()
    {
        if (self::$instancia == null) {
            self::$instancia = new ConexionCapacitaciones();
        }

        return self::$instancia;
    }

    public function getConexion()
    {
        return $this->conexion;
    }
}
