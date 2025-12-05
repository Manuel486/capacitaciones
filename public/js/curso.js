function cursoDetalleComponente() {
  return {
    curso: null,
    cargando: true,
    modalDialogo: {
      activo: false,
      titulo: "",
      mensaje: "",
      tipo: "",
    },
    pestaniaActiva: "contenido",
    async obtenerCurso() {
      const respuesta = await fetch(
        "api/curso_detalle?id_curso=" + this.getCursoIdFromURL()
      );
      const data = await respuesta.json();
      if (data.exitoso) {
        this.curso = data.respuesta;
        this.cargando = false;
      }
    },
    seleccionarPestana(pestana) {
      this.pestaniaActiva = pestana;
    },
    async iniciarCurso() {
      try {
        const respuesta = await fetch("verificar_token", { method: "GET" });
        const data = await respuesta.json();
        if (!data.exitoso) {
          this.modalDialogo.titulo = "Sesión requerida";
          this.modalDialogo.mensaje =
            "Por favor, inicia sesión para comenzar el curso.";
          this.modalDialogo.tipo = "advertencia";
          this.modalDialogo.activo = true;
          return;
        }
      } catch (error) {
        console.error("Error al iniciar el curso:", error);
      }

      window.location.href = "tomar_curso?id_curso=" + this.curso.id_curso;
    },
    getCursoIdFromURL() {
      const params = new URLSearchParams(window.location.search);
      return params.get("id_curso");
    },
    init() {
      this.obtenerCurso();
    },
  };
}
