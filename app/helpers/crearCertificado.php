<?php

use Dompdf\Dompdf;
use Dompdf\Options;

function crearCertificado($nombreUsuario, $nombreCurso, $idCertificado)
{
    $options = new Options();
    $options->set('isRemoteEnabled', true);
    $dompdf = new Dompdf($options);

    $html = "
    <html>
    <head>
        <style>
            @page {
                margin: 0;
            }
            body {
                font-family: 'Georgia', serif;
                text-align: center;
                background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
                margin: 0;
                padding: 0;
                width: 100%;
                height: 100%;
            }
            .container {
                padding: 40px;
                position: relative;
                margin: 30px;
                background: white;
                border: 15px solid #1a3a6b;
                box-shadow: 0 0 0 5px #d4af37, 0 0 20px rgba(0,0,0,0.2);
                min-height: calc(100vh - 120px);
            }
            h1 {
                font-family: 'Georgia', serif;
                font-size: 68px;
                font-weight: bold;
                color: #1a3a6b;
                margin: 40px 0 5px 0;
                padding: 0;
                letter-spacing: 10px;
                text-shadow: 2px 2px 4px rgba(0,0,0,0.1);
            }
            .subtitulo {
                font-family: 'Georgia', serif;
                font-size: 24px;
                color: #5a7a9b;
                margin: 0 0 35px 0;
                letter-spacing: 8px;
                font-weight: normal;
                text-transform: uppercase;
            }
            .otorgado {
                font-family: 'Georgia', serif;
                font-size: 14px;
                color: #555;
                margin: 15px 0 8px 0;
                letter-spacing: 3px;
                text-transform: uppercase;
                font-weight: 600;
            }
            .nombre {
                font-family: 'Brush Script MT', 'Lucida Handwriting', cursive;
                font-size: 35px;
                font-weight: normal;
                color: #1a3a6b;
                margin: 15px 0;
                padding-bottom: 12px;
                border-bottom: 3px solid #d4af37;
                width: 650px;
                margin-left: auto;
                margin-right: auto;
            }
            .descripcion {
                font-family: 'Georgia', serif;
                font-size: 17px;
                color: #444;
                line-height: 1.9;
                margin: 35px auto;
                width: 750px;
            }
            .fecha {
                font-family: 'Georgia', serif;
                font-size: 13px;
                color: #666;
                margin: 20px 0;
                font-style: italic;
            }
            .firmas {
                display: table;
                width: 750px;
                margin: 60px auto 0 auto;
            }
            .firma {
                display: table-cell;
                width: 45%;
                text-align: center;
                vertical-align: top;
            }
            .firma-separador {
                display: table-cell;
                width: 10%;
            }
            .firma-linea {
                border-top: 2px solid #1a3a6b;
                width: 220px;
                margin: 0 auto 8px auto;
            }
            .firma-nombre {
                font-family: 'Georgia', serif;
                font-size: 15px;
                font-weight: bold;
                color: #1a3a6b;
                margin: 5px 0 3px 0;
                text-transform: uppercase;
                letter-spacing: 1px;
            }
            .firma-cargo {
                font-family: 'Georgia', serif;
                font-size: 12px;
                color: #666;
                margin: 2px 0 0 0;
            }
        </style>
    </head>
    <body>
        <div class='container'>
            <h1>CERTIFICADO</h1>
            <p class='subtitulo'>de Reconocimiento</p>
            <p class='otorgado'>Otorgado a:</p>
            <p class='nombre'>{$nombreUsuario}</p>
            <p class='descripcion'>Por haber completado satisfactoriamente el curso <b>\"{$nombreCurso}\"</b> demostrando compromiso, dedicación y excelencia en el aprendizaje.</p>
            <p class='fecha'>Fecha de emisión: " . date('d/m/Y') . "</p>
            <div class='firmas'>
                <div class='firma'>
                    <div class='firma-linea'></div>
                    <p class='firma-nombre'>Mateo López</p>
                    <p class='firma-cargo'>Director de Recursos Humanos</p>
                </div>
                <div class='firma-separador'></div>
                <div class='firma'>
                    <div class='firma-linea'></div>
                    <p class='firma-nombre'>Juliana Silva</p>
                    <p class='firma-cargo'>Coordinadora de Capacitación</p>
                </div>
            </div>
        </div>
    </body>
    </html>
    ";

    $dompdf->loadHtml($html);
    $dompdf->setPaper('A4', 'landscape');
    
    $dompdf->render();
    $output = $dompdf->output();
    $rutaCertificado = CERTIFICADOS  . $idCertificado . ".pdf";
    file_put_contents($rutaCertificado, $output);
}
