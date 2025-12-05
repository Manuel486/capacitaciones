function inicioComponente() {
  return {
    cursos: [],
    async obtenerCursos() {
      const respuesta = await fetch("api/cursos");
      const data = await respuesta.json();
      if (data.exitoso) {
        this.cursos = data.respuesta;
      }
    },
    init() {
      this.obtenerCursos();
    },
  };
}