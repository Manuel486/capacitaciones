function misCursosComponente() {
    return {
        cursos: [],
        cargando: true,
        cursosOriginal: [],
        inputCurso: '',
        pestaniaSeleccionada: 'todos',
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
        }
    };
}