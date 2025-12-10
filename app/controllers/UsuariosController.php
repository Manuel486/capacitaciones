<?php

require_once __DIR__ . "/../models/UsuarioModel.php";
require_once __DIR__ . "/../helpers/ApiRespuesta.php";
require_once __DIR__ . "/../helpers/AuthHelper.php";
require_once __DIR__ . "/../helpers/generarIdUnico.php";

use \Firebase\JWT\JWT;
use \Firebase\JWT\Key;

class UsuariosController
{
    private $usuarioModel;

    public function __construct()
    {
        $this->usuarioModel = new UsuarioModel();
    }

    public function apiObtenerTodosLosUsuarios()
    {
        $usuarios = $this->usuarioModel->obtenerTodosLosUsuarios();

        echo ApiRespuesta::exitoso($usuarios, "Participantes obtenidos exitosamente");
    }

}