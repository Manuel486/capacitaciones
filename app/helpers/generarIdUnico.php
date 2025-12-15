<?php

use Ramsey\Uuid\Uuid;

function generarIdUnico(string $prefijo = '')
{
    $uuid4 = Uuid::uuid4();
    
    if($prefijo !== '') {
        return $prefijo . '_' . $uuid4->toString();
    }
    
    return $uuid4->toString();
}

