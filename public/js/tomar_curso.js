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
    },
    enviarEvaluacion(event) {
      const formData = new FormData(event.target);
      let correctas = 0;
      let totalPreguntas = this.item_actual.detalle.preguntas.length;
      let preguntasRespondidas = 0;

      this.item_actual.detalle.preguntas.forEach((pregunta) => {
        const nameInput =
          "pregunta_" + this.item_actual.id_item + "_" + pregunta.id_pregunta;
        const respuestaSeleccionada = formData.get(nameInput);

        if (respuestaSeleccionada) {
          preguntasRespondidas++;

          const alternativaCorrecta = pregunta.alternativas.find(
            (alt) => alt.es_respuesta == 1
          );

          if (respuestaSeleccionada == alternativaCorrecta.id_alternativa) {
            correctas++;
          }
        }
      });
      
      if (preguntasRespondidas < totalPreguntas) {
        this.$dispatch("abrir-modal", {
          titulo: "Evaluación incompleta",
          mensaje: `Debes responder todas las preguntas. Has respondido ${preguntasRespondidas} de ${totalPreguntas}.`,
          tipo: "advertencia",
        });
        return;
      }

      const porcentaje = (correctas / totalPreguntas) * 100;
      const aprobo = porcentaje >= 70;

      if (aprobo) {
        this.$dispatch("abrir-modal", {
          titulo: "¡Felicidades!",
          mensaje: `Has aprobado la evaluación con ${correctas} de ${totalPreguntas} respuestas correctas (${Math.round(
            porcentaje
          )}%).`,
          tipo: "exito",
        });
        this.marcarCompletado(this.item_actual.id_item);
        this.modo_evaluacion = false;
      } else {
        this.$dispatch("abrir-modal", {
          titulo: "Evaluación no aprobada",
          mensaje: `Obtuviste ${Math.round(
            porcentaje
          )}% (${correctas}/${totalPreguntas} correctas). Necesitas al menos 70%. Inténtalo de nuevo.`,
          tipo: "advertencia",
        });
        this.modo_evaluacion = false;
      }

      // Limpiar el formulario
      event.target.reset();
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
    async marcarCompletado(id_item) {
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
        const response = await fetch("api/marcar_completado", {
          method: "POST",
          body: formData,
        });
        const data = await response.json();
        if (data.exitoso) {
          for (const tema of this.curso.temas) {
            for (const item of tema.items) {
              if (item.id_item === id_item) {
                item.completado = 1;
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
