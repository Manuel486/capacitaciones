function appComponente() {
  return {
    vistaActual: "inicio",
    sesion: {
      usuario: "",
      password: "",
    },
    usuarioLogueado: null,
    cargandoSesion: true,
    credencialesInvalidas: {
      activo: false,
      mensaje: "",
    },
    modalIniciarSesion: {
      activo: false,
    },
    modalDialogo: {
      activo: false,
      titulo: "",
      mensaje: "",
      tipo: "",
    },
    menuAbierto: false,
    async iniciarSesion() {
      this.abrirModalConDatos({
        titulo: "Iniciando sesión",
        mensaje: "Por favor, espera mientras verificamos tus credenciales.",
        tipo: "cargando",
      });

      try {
        this.credencialesInvalidas.activo = false;
        this.credencialesInvalidas.mensaje = "";
        let formData = new FormData();
        formData.append("usuario", this.sesion.usuario);
        formData.append("password", this.sesion.password);
        const respuesta = await fetch("login", {
          method: "POST",
          body: formData,
        });
        const data = await respuesta.json();
        if (data.exitoso) {
          this.usuarioLogueado = data.respuesta;
          this.sesion.usuario = "";
          this.sesion.password = "";
          this.cerrarModalIniciarSesion();
          this.credencialesInvalidas.activo = false;
        } else {
          this.credencialesInvalidas.activo = true;
          this.credencialesInvalidas.mensaje =
            data.mensaje ||
            "Usuario o contraseña incorrectos. Por favor, inténtalo de nuevo.";
        }
      } catch (error) {
        console.error("Error al iniciar sesión:", error);
      } finally {
        this.cerrarModalDialogo();
      }
    },
    async cerrarSesion() {
      this.abrirModalConDatos({
        titulo: "Cerrando sesión",
        mensaje: "Por favor, espera mientras cerramos tu sesión.",
        tipo: "cargando",
      });

      try {
        const respuesta = await fetch("logout", { method: "GET" });
        const data = await respuesta.json();
        if (data.exitoso) {
          this.usuarioLogueado = null;
          window.location.href = "inicio";
        } else {
          console.error("Error al cerrar sesión. Inténtalo de nuevo.");
        }
      } catch (error) {
        console.error("Error al cerrar sesión:", error);
      } finally {
        this.cerrarModalDialogo();
      }
    },
    obtenerUsuarioLogueado(detail) {
      if (detail && detail.callback) {
        detail.callback(this.usuarioLogueado);
      }
    },
    cerrarModalIniciarSesion() {
      this.modalIniciarSesion.activo = false;
      this.sesion.usuario = "";
      this.sesion.password = "";
      this.credencialesInvalidas.activo = false;
    },
    activarModalIniciarSesion() {
      this.modalIniciarSesion.activo = true;
    },
    abrirModalConDatos(datos) {
      this.modalDialogo.activo = true;
      this.modalDialogo.titulo = datos.titulo || "";
      this.modalDialogo.mensaje = datos.mensaje || "";
      this.modalDialogo.tipo = datos.tipo || "";
    },
    cerrarModalDialogo() {
      this.modalDialogo.activo = false;
      this.modalDialogo.titulo = "";
      this.modalDialogo.mensaje = "";
      this.modalDialogo.tipo = "";
    },
    async verificarSesion() {
      try {
        const respuesta = await fetch("verificar_token", { method: "GET" });
        const data = await respuesta.json();
        if (data.exitoso && data.token_valido) {
          this.usuarioLogueado = data.respuesta;
        }
      } catch (error) {
        console.error("Error al verificar la sesión:", error);
      } finally {
        this.cargandoSesion = false;
      }
    },
    init() {
      this.verificarSesion();
    },
  };
}
