function misCursosComponente() {
    return {
        cursos: [],
        cargando: true,
        cursosOriginal: [],
        inputCurso: '',
        pestaniaSeleccionada: 'todos',
        cursosInscritos: 0,
        cursosCompletados: 0,
        cursosEnProceso: 0,
        totalCertificados: 0,
        progresoGeneral: 0,
        async obtenerCursos() {
            let formData = new FormData();
            formData.append('id_usuario', 'USR002');
            const respuesta = await fetch('api/mis_cursos',{
                method: 'POST',
                body: formData
            });
            const data = await respuesta.json();
            if (data.exitoso) {
                this.cursos = data.respuesta;
                this.cursosOriginal = data.respuesta;
                this.cargando = false;

                // Calcular estadísticas
                this.cursosInscritos = this.cursosOriginal.length;
                this.cursosCompletados = this.cursosOriginal.filter(curso => curso.progreso == 100).length;
                this.cursosEnProceso = this.cursosOriginal.filter(curso => curso.progreso > 0 && curso.progreso < 100).length;
                this.totalCertificados = this.cursosOriginal.filter(curso => curso.progreso == 100 && curso.certificado_obtenido).length;
                const totalProgreso = this.cursosOriginal.reduce((sum, curso) => sum + parseInt(curso.progreso), 0);
                this.progresoGeneral = this.cursosOriginal.length > 0 ? Math.round(totalProgreso / this.cursosOriginal.length) : 0;
            }
        },
        async buscarCurso() {
            this.cargando = true;
            if( this.inputCurso.trim() === '' ) {
                this.cursos = this.cursosOriginal;
                this.cargando = false;
                return;
            }

            const termino = this.inputCurso.toLowerCase();
            try {
                let formData = new FormData();
                formData.append('termino', termino);
                const respuesta = await fetch('api/mis_cursos', {
                    method: 'POST',
                    body: formData
                });
                const data = await respuesta.json();
                if (data.exitoso) {
                    this.cursos = data.respuesta;
                    this.cargando = false;
                    return;
                }

            } catch (error) {
                console.error('Error al buscar cursos:', error);
            }
        },
        selectPestania(pestania) {
            this.pestaniaSeleccionada = pestania;

            if( pestania === 'todos' ) {
                this.cursos = this.cursosOriginal;
            } else if( pestania === 'obligatorios' ) {
                this.cursos = this.cursosOriginal.filter( curso => curso.obligatorio == 1 );
            } else if( pestania === 'proceso' ) {
                this.cursos = this.cursosOriginal.filter( curso => curso.progreso >= 0 && curso.progreso < 100 );
            } else if( pestania === 'completado' ) {
                this.cursos = this.cursosOriginal.filter( curso => curso.progreso == 100 );
            }
        },
        init() {
            this.obtenerCursos();
            // Obtener usuario logueado desde el componente principal
            this.$dispatch('obtener-usuario-logueado', {
                callback: (usuario) => {
                    this.usuario = usuario;
                }
            });
        }
    };
}