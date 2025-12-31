function cursosComponente() {
    return {
        cursos: [],
        cargando: true,
        cursosOriginal: [],
        inputCurso: '',
        filtroCertificacion: {
            con: false,
            sin: false
        },
        async obtenerCursos() {
            const respuesta = await fetch('api/cursos');
            const data = await respuesta.json();
            if (data.exitoso) {
                this.cursos = data.respuesta;
                this.cursosOriginal = data.respuesta;
                this.cargando = false;
            }
        },
        filtrarCursosCertificacion() {
            const { con, sin } = this.filtroCertificacion;
            if (con && sin) {
                this.cursos = this.cursosOriginal;
            } else if (con) {
                this.cursos = this.cursosOriginal.filter(curso => curso.tiene_certificacion == 1);
            } else if (sin) {
                this.cursos = this.cursosOriginal.filter(curso => curso.tiene_certificacion == 0);
            } else {
                this.cursos = this.cursosOriginal;
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
                const respuesta = await fetch('api/cursos/buscar', {
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
            } finally {
                this.cargando = false;
            }
        },
        init() {
            this.obtenerCursos();
        }
    };
}