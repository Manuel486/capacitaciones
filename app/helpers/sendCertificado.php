<?php

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;
use PHPMailer\PHPMailer\SMTP;
use GuzzleHttp\Client;

function sendCertificado($datosCorreo)
{
    try {
        $client = new Client([
            'base_uri' => RUTA_API_CORREO,
            'timeout' => 200.0,
            'verify' => false
        ]);

        $multipart = [
            ['name' => 'funcion', 'contents' => $datosCorreo['funcion']],
            ['name' => 'para', 'contents' => $datosCorreo['para']],
            ['name' => 'cc', 'contents' => $datosCorreo['cc']],
            ['name' => 'asunto', 'contents' => $datosCorreo['asunto'] ?: 'Certificado de Curso'],
            ['name' => 'mensaje', 'contents' => $datosCorreo['mensaje']],
            ['name' => 'remitenteNombre', 'contents' => $datosCorreo['remitenteNombre']],
            ['name' => 'correoRemitente', 'contents' => $datosCorreo['correoRemitente']],
            ['name' => 'generar_eml', 'contents' => "0"]
        ];

        if (!empty($datosCorreo['adjuntos'])) {
            foreach ($datosCorreo['adjuntos'] as $index => $adjunto) {
                if (isset($adjunto['path']) && file_exists($adjunto['path'])) {
                    $multipart[] = [
                        'name' => "adjuntos[]",
                        'contents' => fopen($adjunto['path'], 'r'),
                        'filename' => $adjunto['name'] ?? basename($adjunto['path']),
                        'headers' => [
                            'Content-Type' => $adjunto['mime'] ?? 'application/pdf'
                        ]
                    ];
                }
            }
        }

        $response = $client->request('POST', '', [
            'multipart' => $multipart,
        ]);
        $data = json_decode($response->getBody()->getContents(), true);

        if (isset($data['enviado']) && $data['enviado'] == true) {
            AuditoriaLogger::log(
                "Envio de certificados",
                "Enviar certificado",
                true,
                "Correo certificado enviado correctamente desde API"
            );
            return $data;
        } else {
            AuditoriaLogger::log(
                "Envio de certificados",
                "Enviar certificado",
                false,
                "Error no se pudo enviar desde la api: " . ($data['error']) . " - " . ($data['technical_details'])
            );
        }
    } catch (Exception $e) {
        AuditoriaLogger::log(
            "Envio de certificados",
            "Enviar certificado",
            false,
            "Error de conexión API: " . $e->getMessage()
        );
    }

    $destinatarios = $datosCorreo['para'];
    $cc = $datosCorreo['cc'];
    $asunto = $datosCorreo['asunto'];
    $mensaje = $datosCorreo['mensaje'];
    $remitenteNombre = $datosCorreo['remitenteNombre'];
    $correoRemitente = $datosCorreo['correoRemitente'];
    $adjuntos = isset($datosCorreo['adjuntos']) ? $datosCorreo['adjuntos'] : [];

    try {
        $enviado = false;

        $mail = new PHPMailer;
        $mail->CharSet = 'UTF-8';
        $mail->isSMTP();
        $mail->SMTPDebug = 0;
        $mail->Debugoutput = 'html';
        $mail->Host = 'mail.sepcon.net';
        $mail->SMTPAuth = true;
        $mail->Username = 'fichas@sepcon.net';
        $mail->Password = 'c9Hz8Nz4Zj5Or7Q';
        $mail->Port = 465;
        $mail->SMTPSecure = "ssl";
        $mail->SMTPOptions = array(
            'ssl' => array(
                'verify_peer' => false,
                'verify_peer_name' => false,
                'allow_self_signed' => true,
                'peer_name' => 'mail.sepcon.net',
            )
        );

        $mail->setFrom($correoRemitente, $remitenteNombre ?? "Responsable");

        foreach (explode(";", $destinatarios) as $dest) {
            $dest = trim($dest);
            if (filter_var($dest, FILTER_VALIDATE_EMAIL)) {
                $mail->addAddress($dest);
            }
        }

        $ccList = [];
        foreach (explode(";", $cc) as $copia) {
            $copia = trim($copia);
            if (filter_var($copia, FILTER_VALIDATE_EMAIL)) {
                $mail->addCC($copia);
                $ccList[] = $copia;
            }
        }

        if (!in_array($correoRemitente, $ccList) && filter_var($correoRemitente, FILTER_VALIDATE_EMAIL)) {
            $mail->addBCC($correoRemitente);
        }

        foreach ($adjuntos as $a) {
            if (isset($a['path']) && file_exists($a['path'])) {
                $mail->addAttachment($a['path'], $a['name'] ?? basename($a['path']));
            }
        }

        $mail->isHTML(true);
        $mail->Subject = $asunto;
        $mail->Body = $mensaje;

        $generarEml = isset($datosCorreo['generar_eml']) && $datosCorreo['generar_eml'] == "1";
        $mimeMessage = null;

        if ($generarEml) {
            $mail->preSend();
            $mimeMessage = $mail->getSentMIMEMessage();
        }

        if ($mail->send()) {
            $enviado = true;
        }

        $mail->ClearAddresses();
        $mail->ClearAttachments();

        if ($enviado == true) {
            AuditoriaLogger::log(
                "Registro",
                "Envio de certificados certificado",
                true,
                "Correo certificado enviado correctamente desde el Sistema de Capacitaciones."
            );
        } else {
            AuditoriaLogger::log(
                "Envio de certificados",
                "Enviar certificado",
                false,
                "Error no se pudo enviar desde el Sistema de Capacitaciones: " . $mail->ErrorInfo
            );
        }

        return [
            "enviado" => $enviado,
            "message" => $enviado ? "Correo enviado correctamente" : "No se pudo enviar el correo electrónico",
            "error" => $enviado ? null : $mail->ErrorInfo,
            "technical_details" => $enviado ? null : $mail->ErrorInfo,
            "temporal_eml" => ($enviado && $mimeMessage) ? base64_encode($mimeMessage) : null
        ];
    } catch (Exception $e) {
        return [
            "enviado" => false,
            "message" => "No se pudo enviar el correo electrónico",
            "error" => $e->getMessage(),
            "technical_details" => isset($mail) ? $mail->ErrorInfo : 'N/A',
            "temporal_eml" => null
        ];
    }

}
