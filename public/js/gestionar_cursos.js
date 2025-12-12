function gestionarCursosComponente() {
  return {
    cursos: [],
    cargando: true,
    nombreInstructor: "Instructor",
    totalCursos: 0,
    cursosActivos: 0,
    totalEstudiantes: 0,
    valoracionPromedio: "N/A",
    inputCurso: "",
    cursosOriginal: [],
    async obtenerCursosCreados() {
      this.cargando = true;
      try {
        const respuesta = await fetch("api/obtener_cursos_creados", { method: "GET" });
        const data = await respuesta.json();
        if (data.exitoso) {
          this.cursos = data.respuesta;
          this.cursosOriginal = data.respuesta;
          this.calcularEstadisticas();
        } else {
          this.cursos = [];
          this.cursosOriginal = [];
        }
      } catch (error) {
        console.error("Error al obtener los cursos creados:", error);
        this.cursos = [];
        this.cursosOriginal = [];
      } finally {
        this.cargando = false;
      }
    },
    calcularEstadisticas() {
      this.totalCursos = this.cursos.length;
      this.cursosActivos = this.cursos.filter(c => c.activo == 1).length;
      this.totalEstudiantes = this.cursos.reduce((acc, curso) => acc + (parseInt(curso.inscritos) || 0), 0);
      
      const cursosConValoracion = this.cursos.filter(c => c.valoracion);
      if (cursosConValoracion.length > 0) {
        const sumaValoraciones = cursosConValoracion.reduce((acc, curso) => acc + parseFloat(curso.valoracion), 0);
        this.valoracionPromedio = (sumaValoraciones / cursosConValoracion.length).toFixed(1);
      } else {
        this.valoracionPromedio = "N/A";
      }
    },
    buscarCurso() {
      const termino = this.inputCurso.toLowerCase().trim();
      
      if (termino === "") {
        this.cursos = [...this.cursosOriginal];
      } else {
        this.cursos = this.cursosOriginal.filter(curso =>
          (curso.nombre && curso.nombre.toLowerCase().includes(termino)) ||
          (curso.descripcion && curso.descripcion.toLowerCase().includes(termino))
        );
      }
    },
    init() {
      this.obtenerCursosCreados();
    },
  };
}
