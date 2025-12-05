function tomarCurso() {
  const urlParams = new URLSearchParams(window.location.search);
  const id_curso = urlParams.get("id_curso");
  return {
    curso: {},
    cargando: true,
    item_actual: {},
    mostrarConfeti: false,
    modo_evaluacion: false,
    procesandoCompletado: false,
    modalDialogo: {
      activo: false,
      titulo: "",
      mensaje: "",
      tipo: "",
    },
    async obtenerEstructuraCurso() {
      try {
        const respuesta = await fetch(
          `api/curso_estructura?id_curso=${id_curso}`
        );
        const data = await respuesta.json();
        if (data.exitoso) {
          this.curso = data.respuesta;
          console.log(this.curso);
          // Cargar la primera clase automáticamente
          if (this.curso.temas && this.curso.temas.length > 0) {
            const primerTema = this.curso.temas[0];
            if (primerTema.items && primerTema.items.length > 0) {
              this.item_actual = primerTema.items[0];

              if (this.item_actual.tipo === "clase") {
                this.inicializarVideo();
              }
            }
          }
        }
      } catch (error) {
        console.error("Error al obtener la estructura del curso:", error);
      } finally {
        this.cargando = false;
      }
    },
    activarModoEvaluacion() {
      this.modo_evaluacion = true;
    },
    enviarEvaluacion(event) {
      const formData = new FormData(event.target);
      let correctas = 0;
      let totalPreguntas = this.item_actual.detalle.preguntas.length;

      // Validar respuestas
      this.item_actual.detalle.preguntas.forEach((pregunta) => {
        const respuestaSeleccionada = formData.get(
          "pregunta_" + pregunta.id_pregunta
        );

        const alternativaCorrecta = pregunta.alternativas.find(
          (alt) => alt.es_respuesta == 1
        );

        if (respuestaSeleccionada == alternativaCorrecta.id_alternativa) {
          correctas++;
        }
      });

      const porcentaje = (correctas / totalPreguntas) * 100;
      const aprobo = porcentaje >= 70;

      if (aprobo) {
        this.modalDialogo.activo = true;
        this.modalDialogo.titulo = "¡Felicidades!";
        this.modalDialogo.mensaje = `Has aprobado la evaluación con ${correctas} de ${totalPreguntas} respuestas correctas.`;
        this.modalDialogo.tipo = "exito";
        // Marcar como completado
        this.marcarCompletado(this.item_actual.id_item);
        this.modo_evaluacion = false;
      } else {
        this.modalDialogo.activo = true;
        this.modalDialogo.titulo = "Evaluación no aprobada";
        this.modalDialogo.mensaje = `No alcanzaste el puntaje mínimo. Respuestas correctas: ${correctas} de ${totalPreguntas}. Inténtalo de nuevo.`;
        this.modalDialogo.tipo = "advertencia";
        this.modo_evaluacion = false;
        event.target.reset();
      }
    },
    seleccionarItem(temaIndex, itemIndex) {
      if (this.modo_evaluacion) {
        this.modalDialogo.activo = true;
        this.modalDialogo.titulo = "Evaluación en curso";
        this.modalDialogo.mensaje =
          "Debes completar la evaluación actual antes de cambiar de tema o ítem.";
        this.modalDialogo.tipo = "info";
        return;
      }

      const itemSeleccionado = this.curso.temas[temaIndex].items[itemIndex];
      
      if (itemSeleccionado.completado == 1 && itemSeleccionado.tipo === 'anuncio') {
        this.item_actual = itemSeleccionado;
        return;
      }

      this.item_actual = itemSeleccionado;
      console.log(this.item_actual);

      if (this.item_actual.tipo === "anuncio" && this.item_actual.completado != 1) {
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

          // Actualizar progreso del item actual
          if (this.item_actual && this.item_actual.tipo === "clase") {
            this.item_actual.progreso = Math.round(porcentaje);

            if (porcentaje >= 80 && this.item_actual.completado != 1 && !this.procesandoCompletado) {
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
        console.log("Item ya completado");
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
          
          const nuevoProgreso = totalItems > 0 ? Math.round((completados / totalItems) * 100) : 0;
          
          this.curso.progreso = nuevoProgreso;

          if (this.curso.progreso === 100) {
            this.modalDialogo.activo = true;
            this.modalDialogo.titulo = "¡Curso Completado!";
            this.modalDialogo.mensaje = "¡Felicidades por completar el curso!";
            this.modalDialogo.tipo = "exito";

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
    cerrarModalDialogo() {
      this.modalDialogo.activo = false;
      this.modalDialogo.titulo = "";
      this.modalDialogo.mensaje = "";
      this.modalDialogo.tipo = "";
    },
    cerrarConfeti() {
      this.mostrarConfeti = false;
    },
    init() {
      this.obtenerEstructuraCurso();
    },
  };
}