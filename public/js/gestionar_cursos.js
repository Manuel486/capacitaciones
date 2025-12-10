function gestionarCursosComponente() {
  return {
    cursos: [],
    cargandoCursos: false,
    async obtenerCursosCreados() {
      try {
        const respuesta = await fetch("api/obtener_cursos_creados", { method: "GET" });
        const data = await respuesta.json();
        if (data.exitoso) {
            this.cursos = data.respuesta;

        } else {
          this.cursos = [];
        }
      } catch (error) {
        console.error("Error al obtener los cursos creados:", error);
        this.cursos = [];
      }
    },
    init() {
      this.obtenerCursosCreados();
    },
  };
}
