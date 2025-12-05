<?php

function generarIdUnico(string $prefijo = '')
{
    $maxTotal = 28;

    $longId = $maxTotal - strlen($prefijo);

    $bytes = random_bytes(intval(ceil($longId / 2)));

    $idRandom = substr(bin2hex($bytes), 0, $longId);

    return $prefijo . $idRandom;
}

