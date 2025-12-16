function inicioComponente() {
  return {
    cursos: [],
    cargandoCursos: true,
    async obtenerCursos() {
      try {
        const respuesta = await fetch("api/cursos_top");
        const data = await respuesta.json();
        if (data.exitoso) {
          this.cursos = data.respuesta;
        }
      } catch (error) {
        console.error(error);
      } finally {
        this.cargandoCursos = false;
      }
    },
    init() {
      this.obtenerCursos();
    },
  };
}
