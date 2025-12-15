function cursoDetalleComponente() {
  return {
    curso: null,
    cargando: true,
    id_usuario: null,
    modalComentario: false,
    comentario: "",
    valoracion: 0,
    modalDialogo: {
      activo: false,
      titulo: "",
      mensaje: "",
      tipo: "",
    },
    hoverValoracion: 0,
    pestaniaActiva: "contenido",
    async obtenerCurso() {
      const respuesta = await fetch(
        "api/curso_detalle?id_curso=" + this.getCursoIdFromURL()
      );
      const data = await respuesta.json();
      if (data.exitoso) {
        this.curso = data.respuesta;
        this.cargando = false;
      } else {
        window.location.href = "inicio";
      }
    },
    seleccionarPestana(pestana) {
      this.pestaniaActiva = pestana;
    },
    async iniciarCurso() {
      if (!this.id_usuario) {
        this.$dispatch("abrir-modal", {
          titulo: "Sesión requerida",
          mensaje: "Por favor, inicia sesión para comenzar el curso.",
          tipo: "advertencia",
        });
        return;
      }

      window.location.href = "tomar_curso?id_curso=" + this.curso.id_curso;
    },
    getCursoIdFromURL() {
      const params = new URLSearchParams(window.location.search);
      return params.get("id_curso");
    },
    async agregarValoracion() {
      if (!this.id_usuario) {
        this.$dispatch("abrir-modal", {
          titulo: "Sesión requerida",
          mensaje: "Por favor, inicia sesión para agregar una valoración.",
          tipo: "advertencia",
        });
        return;
      }

      // Verificar si el usuario ya ha valorado el curso
      const yaValoro = this.curso.valoraciones.some(
        (val) => val.id_usuario === this.id_usuario
      );
      if (yaValoro) {
        this.$dispatch("abrir-modal", {
          titulo: "Valoración existente",
          mensaje: "Ya hizo una valoración para este curso.",
          tipo: "info",
        });
        return;
      }
      
      this.modalComentario = true;
    },
    cerrarModalValoracion() {
      this.modalComentario = false;
      this.valoracion = 0;
      this.comentario = "";
    },
    async guardarValoracion() {
      if (this.valoracion === 0 || this.comentario.trim() === "") {
        this.$dispatch("abrir-modal", {
          titulo: "Valoración y comentario requeridos",
          mensaje: "Por favor, proporciona una valoración y un comentario.",
          tipo: "info",
        });
        return;
      }

      this.$dispatch("abrir-modal", {
        titulo: "Guardando valoración",
        mensaje: "Por favor, espera mientras guardamos tu valoración.",
        tipo: "cargando",
      });

      try {
        let formData = new FormData();
        formData.append("id_curso", this.curso.id_curso);
        formData.append("valoracion", this.valoracion);
        formData.append("comentario", this.comentario);
        const respuesta = await fetch("api/guardar_valoracion_curso", {
          method: "POST",
          body: formData,
        });
        const data = await respuesta.json();
        if (data.exitoso) {
          this.cerrarModalValoracion();
          this.$dispatch("abrir-modal", {
            titulo: "Valoración guardada",
            mensaje: "Gracias por su valoración del curso.",
            tipo: "exito",
          });
          this.curso.valoraciones = data.respuesta;
        } else {
          this.modalDialogo.activo = true;
          this.$dispatch("abrir-modal", {
            titulo: "Error",
            mensaje: "No se pudo guardar la valoración.",
            tipo: "error",
          });
        }
      } catch (error) {
        console.error("Error al guardar la valoración:", error);
      } finally {
        this.$dispatch("cerrar-modal");
      }
    },
    async validarUsuarioInscrito() {
      try {
        const respuesta = await fetch("verificar_token", { method: "GET" });
        const data = await respuesta.json();
        if (data.exitoso) {
          this.id_usuario = data.respuesta.dni;
        }
      } catch (error) {
        console.error("Error al iniciar el curso:", error);
      }
    },
    init() {
      this.obtenerCurso();
      this.validarUsuarioInscrito();
    },
  };
}
