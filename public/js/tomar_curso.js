function tomarCurso() {
  const urlParams = new URLSearchParams(window.location.search);
  const id_curso = urlParams.get("id_curso");
  return {
    curso: {},
    cargando: true,
    comentarios_cargando: false,
    item_actual: {},
    mostrarConfeti: false,
    modo_evaluacion: false,
    procesandoCompletado: false,
    detalleItemVista: "descripcion",
    comentarios: [],
    modalComentario: false,
    comentario: "",
    pregunta_actual: 0,
    respuestas_evaluacion: {},
    tiempo_restante: 0,
    temporizador_activo: false,
    temporizador_interval: null,
    async obtenerEstructuraCurso() {
      try {
        const respuesta = await fetch(
          `api/curso_estructura?id_curso=${id_curso}`
        );
        const data = await respuesta.json();
        if (data.exitoso) {
          this.curso = data.respuesta;
          if (this.curso.temas && this.curso.temas.length > 0) {
            const primerTema = this.curso.temas[0];
            if (primerTema.items && primerTema.items.length > 0) {
              this.item_actual = primerTema.items[0];

              if (this.item_actual.tipo === "clase") {
                this.inicializarVideo();
              }
            }
          }
          this.cargando = false;
        } else {
          window.location.href = "inicio";
        }
      } catch (error) {
        console.error("Error al obtener la estructura del curso:", error);
      }
    },
    activarModoEvaluacion() {
      this.modo_evaluacion = true;
      this.pregunta_actual = 0;
      this.respuestas_evaluacion = {};
      
      if (this.item_actual.detalle.tiempo_duracion && this.item_actual.detalle.tiempo_duracion > 0) {
        // Viene como texto en minutos
        this.tiempo_restante = parseInt(this.item_actual.detalle.tiempo_duracion) * 60;
        // this.tiempo_restante = this.item_actual.detalle.tiempo_duracion * 60;
        this.temporizador_activo = true;
        this.iniciarTemporizador();
      } else {
        this.temporizador_activo = false;
      }
    },
    iniciarTemporizador() {
      if (this.temporizador_interval) {
        clearInterval(this.temporizador_interval);
      }
      this.temporizador_interval = setInterval(() => {
        if (this.tiempo_restante > 0) {
          this.tiempo_restante--;
        } else {
          this.detenerTemporizador();
          // this.$dispatch("abrir-modal", {
          //   titulo: "Tiempo agotado",
          //   mensaje: "El tiempo para completar la evaluación ha terminado. Se enviarán tus respuestas actuales.",
          //   tipo: "advertencia",
          // });
          this.enviarEvaluacionActual(true);
        }
      }, 1000);
    },
    detenerTemporizador() {
      if (this.temporizador_interval) {
        clearInterval(this.temporizador_interval);
        this.temporizador_interval = null;
      }
      this.temporizador_activo = false;
    },
    formatearTiempo(segundos) {
      const mins = Math.floor(segundos / 60);
      const secs = segundos % 60;
      return `${mins.toString().padStart(2, '0')}:${secs.toString().padStart(2, '0')}`;
    },
    irAPregunta(index) {
      this.pregunta_actual = index;
    },
    siguientePregunta() {
      if (this.pregunta_actual < this.item_actual.detalle.preguntas.length - 1) {
        this.pregunta_actual++;
      }
    },
    anteriorPregunta() {
      if (this.pregunta_actual > 0) {
        this.pregunta_actual--;
      }
    },
    guardarRespuesta(idPregunta, idAlternativa) {
      this.respuestas_evaluacion[idPregunta] = idAlternativa;
    },
    obtenerRespuesta(idPregunta) {
      return this.respuestas_evaluacion[idPregunta] || null;
    },
    enviarEvaluacionActual(porTiempoAgotado = false) {
      this.detenerTemporizador();

      let correctas = 0;
      let totalPreguntas = this.item_actual.detalle.preguntas.length;
      let preguntasRespondidas = Object.keys(this.respuestas_evaluacion).length;

      this.item_actual.detalle.preguntas.forEach((pregunta) => {
        const respuestaSeleccionada = this.respuestas_evaluacion[pregunta.id_pregunta];

        if (respuestaSeleccionada) {
          const alternativaCorrecta = pregunta.alternativas.find(
            (alt) => alt.es_respuesta == 1
          );

          if (respuestaSeleccionada == alternativaCorrecta.id_alternativa) {
            correctas++;
          }
        }
      });
      
      if ((preguntasRespondidas < totalPreguntas) && !porTiempoAgotado) {
        this.$dispatch("abrir-modal", {
          titulo: "Evaluación incompleta",
          mensaje: `Debes responder todas las preguntas. Has respondido ${preguntasRespondidas} de ${totalPreguntas}.`,
          tipo: "advertencia",
        });
        return;
      }

      // const porcentaje = (correctas / totalPreguntas) * 100;
      // const aprobo = porcentaje >= 70;

      // La maxima nota es 20
      let nota = (correctas / totalPreguntas) * 20;
      nota = Math.round(nota);
      let aprobo = nota >= this.item_actual.detalle.nota_minima_aprobatoria;
      
      // const porcentaje = (nota / 20) * 100;

      if (aprobo) {
        this.$dispatch("abrir-modal", {
          titulo: "¡Felicidades!",
          mensaje: `Has aprobado la evaluación con ${correctas} de ${totalPreguntas} respuestas correctas.`,
          tipo: "exito",
        });
        // this.marcarCompletado(this.item_actual.id_item,);
        // this.modo_evaluacion = false;
        // this.respuestas_evaluacion = {};
      } else {
        this.$dispatch("abrir-modal", {
          titulo: "Evaluación no aprobada",
          mensaje: `Obtuviste (${correctas}/${totalPreguntas} correctas). Necesitas una nota mínima de ${this.item_actual.detalle.nota_minima_aprobatoria} para aprobar.`,
          tipo: "advertencia",
        });
        // this.modo_evaluacion = false;
        // this.respuestas_evaluacion = {};
      }
      this.marcarCompletado(this.item_actual.id_item, nota);
      this.modo_evaluacion = false;
      this.respuestas_evaluacion = {};
      
    },
    enviarEvaluacion(event) {
      event.preventDefault();
      this.enviarEvaluacionActual();
    },
    seleccionarItem(temaIndex, itemIndex) {
      if (this.modo_evaluacion) {
        this.$dispatch("abrir-modal", {
          titulo: "Evaluación en curso",
          mensaje: `Debes completar la evaluación actual antes de cambiar de tema o ítem.`,
          tipo: "info",
        });
        return;
      }

      this.detalleItemVista = "descripcion";
      this.comentarios = [];
      const itemSeleccionado = this.curso.temas[temaIndex].items[itemIndex];

      if (
        itemSeleccionado.completado == 1 &&
        itemSeleccionado.tipo === "anuncio"
      ) {
        this.item_actual = itemSeleccionado;
        return;
      }

      if (itemSeleccionado.tipo === "evaluacion") {
        this.modo_evaluacion = false;
        this.$nextTick(() => {
          this.item_actual = itemSeleccionado;
        });
      } else {
        this.item_actual = itemSeleccionado;
      }

      if (
        this.item_actual.tipo === "anuncio" &&
        this.item_actual.completado != 1
      ) {
        this.marcarCompletado(this.item_actual.id_item);
      } else if (this.item_actual.tipo === "clase") {
        // Determinar si item_actuale.detalle.video es diferente de mp4
        if(this.item_actual.detalle.video && !this.item_actual.detalle.video.endsWith('.mp4')) {
          this.marcarCompletado(this.item_actual.id_item);
        }
        this.inicializarVideo();
      }
    },
    inicializarVideo() {
      if (this.item_actual.completado == 1) {
        return;
      }

      this.$nextTick(() => {
        const video = document.querySelector("video");
        if (!video) return;

        video.addEventListener("timeupdate", () => {
          const porcentaje = (video.currentTime / video.duration) * 100;

          if (this.item_actual && this.item_actual.tipo === "clase") {
            this.item_actual.progreso = Math.round(porcentaje);

            if (
              porcentaje >= 80 &&
              this.item_actual.completado != 1 &&
              !this.procesandoCompletado
            ) {
              this.marcarCompletado(this.item_actual.id_item);
            }
          }
        });
      });
    },
    async marcarCompletado(id_item, nota = null) {
      if (this.procesandoCompletado) {
        return;
      }

      let yaCompletado = false;
      for (const tema of this.curso.temas) {
        for (const item of tema.items) {
          if (item.id_item === id_item && item.completado == 1) {
            yaCompletado = true;
            break;
          }
        }
        if (yaCompletado) break;
      }

      if (yaCompletado) {
        return;
      }

      this.procesandoCompletado = true;

      try {
        let formData = new FormData();
        formData.append("curso_usuario_id", this.curso.curso_usuario_id);
        formData.append("item_id", id_item);
        if (nota !== null) {
          formData.append("nota", nota);
          formData.append("nota_minima_aprobatoria", this.item_actual.detalle.nota_minima_aprobatoria);
        }
        const response = await fetch("api/marcar_completado", {
          method: "POST",
          body: formData,
        });
        const data = await response.json();
        if (data.exitoso) {
          for (const tema of this.curso.temas) {
            for (const item of tema.items) {
              if (item.id_item === id_item) {
                if(this.item_actual.tipo === "evaluacion" && nota !== null) {
                  if(nota >= this.item_actual.detalle.nota_minima_aprobatoria) {
                    item.completado = 1;
                  } else {
                    item.completado = 0;
                  }
                  item.nota = nota;
                } else {
                  item.completado = 1;
                }
                break;
              }
            }
          }

          const totalItems = this.curso.temas.reduce(
            (acc, tema) => acc + tema.items.length,
            0
          );
          const completados = this.curso.temas.reduce(
            (acc, tema) =>
              acc + tema.items.filter((item) => item.completado == 1).length,
            0
          );

          const nuevoProgreso =
            totalItems > 0 ? Math.round((completados / totalItems) * 100) : 0;

          this.curso.progreso = nuevoProgreso;

          if (this.curso.progreso === 100) {
            this.$dispatch("abrir-modal", {
              titulo: "¡Curso Completado!",
              mensaje: `¡Felicidades por completar el curso!`,
              tipo: "exito",
            });

            const jsConfetti = new JSConfetti();
            jsConfetti.addConfetti();

            this.mostrarConfeti = true;
          }
        } else {
          console.error("Error al marcar como completado:", data.mensaje);
        }
      } catch (error) {
        console.error("Error en la solicitud:", error);
      } finally {
        this.procesandoCompletado = false;
      }
    },
    async obtenerComentarios() {
      if (!this.item_actual || this.item_actual.tipo !== "clase") {
        return;
      }
      this.comentarios_cargando = true;
      try {
        const respuesta = await fetch(
          `api/obtener_comentarios?id_item=${this.item_actual.id_item}`
        );
        const data = await respuesta.json();
        if (data.exitoso) {
          this.comentarios = data.respuesta;
        }
      } catch (error) {
        console.error("Error al obtener los comentarios:", error);
      } finally {
        this.comentarios_cargando = false;
      }
    },
    activarModalComentario() {
      this.modalComentario = true;
      this.comentario = "";
    },
    cerrarModalComentario() {
      this.modalComentario = false;
    },
    obtenerDuracionEvaluacion(tiempoDuracion) {
      if(parseInt(tiempoDuracion) === 1) {
        return `${tiempoDuracion} minuto`;
      } else {
        return `${tiempoDuracion} minutos`;
      }
    },
    async guardarComentario() {
      if (!this.comentario.trim()) {
        this.$dispatch("abrir-modal", {
          titulo: "Campos incompletos",
          mensaje: "El comentario no puede estar vacío.",
          tipo: "advertencia",
        });
        return;
      }

      this.$dispatch("abrir-modal", {
        titulo: "Guardando comentario",
        mensaje: "Por favor, espera mientras guardamos tu comentario.",
        tipo: "cargando",
      });

      try {
        let formData = new FormData();
        formData.append("id_item", this.item_actual.id_item);
        formData.append("comentario", this.comentario.trim());
        const respuesta = await fetch("api/guardar_comentario", {
          method: "POST",
          body: formData,
        });
        const data = await respuesta.json();
        if (data.exitoso) {
          this.$dispatch("abrir-modal", {
            titulo: "Éxito",
            mensaje: "Comentario guardado correctamente.",
            tipo: "exito",
          });
          this.cerrarModalComentario();
          this.obtenerComentarios();
        } else {
          this.$dispatch("abrir-modal", {
            titulo: "Error",
            mensaje: data.mensaje || "Error al guardar el comentario.",
            tipo: "error",
          });
        }
      } catch (error) {
        console.error("Error al guardar el comentario:", error);
      } finally {
        this.$dispatch("cerrar-modal");
      }
    },
    obtenerId() {
      const urlParams = new URLSearchParams(window.location.search);
      const id_curso = urlParams.get("id_curso");

      return id_curso;
    },
    cerrarConfeti() {
      this.mostrarConfeti = false;
    },
    init() {
      this.obtenerEstructuraCurso();
    },
  };
}
