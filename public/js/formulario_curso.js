function nuevoCursoComponente() {
  return {
    cargando: true,
    curso: {
      nombre: "",
      descripcion: "",
      imagen: "",
      dificultad: "principiante",
      duracion: 0,
      acceso_libre: 1,
    },
    modoEdicion: false,
    usuariosOriginalesDisponibles: [],
    usuariosDisponibles: [],
    usuariosInscritosOriginal: [],
    usuariosInscritos: [],
    totalInscritos: 0,
    personasEncontradas: 0,
    sltProyecto: "todos",
    sltCargo: "todos",
    seleccionados: new Set(),
    proyectos: [],
    inputDisponibles: "",
    inputInscritos: "",
    cargos: [],
    vistaActiva: "descripcionGeneral",
    vistaParticipantes: "todos",

    async obtenerTodosLosUsuarios() {
      try {
        const respuesta = await fetch("api/obtener_todos_usuarios", {
          method: "GET",
        });
        const data = await respuesta.json();
        if (data.exitoso) {
          const usuariosConSeleccion = data.respuesta.map((usuario) => ({
            ...usuario,
            seleccionado: false,
          }));

          this.usuariosOriginalesDisponibles = usuariosConSeleccion;
          this.usuariosDisponibles = usuariosConSeleccion;
          this.personasEncontradas = this.usuariosDisponibles.length;

          const proyectos = [
            ...new Set(
              data.respuesta.map((usuario) => usuario.dcostos).filter((p) => p)
            ),
          ];
          const cargos = [
            ...new Set(
              data.respuesta.map((usuario) => usuario.dcargo).filter((c) => c)
            ),
          ];
          this.proyectos = proyectos;
          this.cargos = cargos;
        }
      } catch (error) {
        console.error("Error en la petición:", error);
      }
    },

    activarVista(vista) {
      this.vistaActiva = vista;
    },

    reiniciarSelectores() {
      this.sltProyecto = "todos";
      this.sltCargo = "todos";
      this.inputDisponibles = "";
      this.usuariosDisponibles = [...this.usuariosOriginalesDisponibles];
      this.personasEncontradas = this.usuariosDisponibles.length;
    },

    seleccionarVistaParticipantes(vista) {
      this.vistaParticipantes = vista;
      this.reiniciarSelectores();
    },
    inscribirUsuario(usuario) {
      const yaInscrito = this.usuariosInscritos.some(
        (u) => u.internal === usuario.internal
      );
      if (yaInscrito) return;

      this.usuariosInscritos.push({ ...usuario, seleccionado: false });

      this.usuariosDisponibles = this.usuariosDisponibles.filter(
        (u) => u.internal !== usuario.internal
      );
      this.usuariosOriginalesDisponibles =
        this.usuariosOriginalesDisponibles.filter(
          (u) => u.internal !== usuario.internal
        );

      this.usuariosInscritosOriginal = [...this.usuariosInscritos];
      this.totalInscritos = this.usuariosInscritos.length;
      this.personasEncontradas = this.usuariosDisponibles.length;

      this.seleccionados.delete(usuario.internal);
    },

    quitarUsuarioInscrito(usuario) {
      this.usuariosInscritos = this.usuariosInscritos.filter(
        (u) => u.internal !== usuario.internal
      );

      const existeEnDisponibles = this.usuariosDisponibles.some(
        (u) => u.internal === usuario.internal
      );
      const existeEnOriginales = this.usuariosOriginalesDisponibles.some(
        (u) => u.internal === usuario.internal
      );

      const usuarioLimpio = { ...usuario, seleccionado: false };
      if (!existeEnDisponibles) {
        this.usuariosDisponibles.push(usuarioLimpio);
      }
      if (!existeEnOriginales) {
        this.usuariosOriginalesDisponibles.push(usuarioLimpio);
      }

      this.usuariosInscritosOriginal = [...this.usuariosInscritos];
      this.totalInscritos = this.usuariosInscritos.length;
      this.personasEncontradas = this.usuariosDisponibles.length;
    },

    buscarDisponibles() {
      const termino = this.inputDisponibles.toLowerCase().trim();

      if (termino === "") {
        this.usuariosDisponibles = [...this.usuariosOriginalesDisponibles];
        this.personasEncontradas = this.usuariosDisponibles.length;
        return;
      }

      this.usuariosDisponibles = this.usuariosOriginalesDisponibles.filter(
        (usuario) =>
          (usuario.nombres &&
            usuario.nombres.toLowerCase().includes(termino)) ||
          (usuario.apellidos &&
            usuario.apellidos.toLowerCase().includes(termino)) ||
          (usuario.dni && usuario.dni.toLowerCase().includes(termino)) ||
          (usuario.dcargo && usuario.dcargo.toLowerCase().includes(termino))
      );
      this.personasEncontradas = this.usuariosDisponibles.length;
    },

    buscarInscritos() {
      const termino = this.inputInscritos.toLowerCase().trim();

      if (termino === "") {
        this.usuariosInscritos = [...this.usuariosInscritosOriginal];
        return;
      }

      this.usuariosInscritos = this.usuariosInscritosOriginal.filter(
        (usuario) =>
          (usuario.nombres &&
            usuario.nombres.toLowerCase().includes(termino)) ||
          (usuario.apellidos &&
            usuario.apellidos.toLowerCase().includes(termino)) ||
          (usuario.dni && usuario.dni.toLowerCase().includes(termino)) ||
          (usuario.dcargo && usuario.dcargo.toLowerCase().includes(termino))
      );
    },

    async guardarCurso() {
      if (!this.curso.nombre || !this.curso.descripcion) {
        alert("Por favor, completa todos los campos obligatorios.");
        return;
      }

      try {
        const formData = new FormData();
        formData.append("curso", JSON.stringify(this.curso));

        if (this.curso.imagen) {
          formData.append("imagen", this.curso.imagen);
        }

        if (this.usuariosInscritos.length > 0) {
          const idsUsuarios = this.usuariosInscritos.map((u) => u.internal);
          formData.append("ids_usuarios", JSON.stringify(idsUsuarios));
        }

        if (this.modoEdicion) {
          formData.append("editar", true);
        } else {
          formData.append("editar", false);
        }

        const respuesta = await fetch("api/formulario_curso", {
          method: "POST",
          body: formData,
        });
        const data = await respuesta.json();

        if (data.exitoso) {
          window.location.href = "formulario_curso?id_curso=" + data.respuesta;
        } else {
          console.error("Error al guardar el curso:", data.mensaje);
        }
      } catch (error) {
        console.error("Error en la petición:", error);
      }
    },

    seleccionarTodosDisponibles() {
      const todosSeleccionados = this.usuariosDisponibles.every(
        (u) => u.seleccionado
      );
      const nuevoEstado = !todosSeleccionados;

      this.usuariosDisponibles.forEach((usuario) => {
        usuario.seleccionado = nuevoEstado;
      });

      if (nuevoEstado) {
        this.seleccionados = new Set(
          this.usuariosDisponibles.map((u) => u.internal)
        );
      } else {
        this.seleccionados.clear();
      }
    },

    seleccionarUsuario(usuario) {
      usuario.seleccionado = !usuario.seleccionado;

      if (usuario.seleccionado) {
        this.seleccionados.add(usuario.internal);
      } else {
        this.seleccionados.delete(usuario.internal);
      }
    },

    inscribirSeleccionados() {
      if (this.seleccionados.size === 0) return;

      const usuariosAInscribir = this.usuariosDisponibles.filter((usuario) =>
        this.seleccionados.has(usuario.internal)
      );

      const idsInscritos = new Set(
        this.usuariosInscritos.map((u) => u.internal)
      );

      const usuariosNuevos = usuariosAInscribir.filter(
        (u) => !idsInscritos.has(u.internal)
      );

      this.usuariosInscritos.push(
        ...usuariosNuevos.map((u) => ({ ...u, seleccionado: false }))
      );

      const idsARemover = new Set(usuariosNuevos.map((u) => u.internal));

      this.usuariosDisponibles = this.usuariosDisponibles.filter(
        (u) => !idsARemover.has(u.internal)
      );
      this.usuariosOriginalesDisponibles =
        this.usuariosOriginalesDisponibles.filter(
          (u) => !idsARemover.has(u.internal)
        );

      this.usuariosInscritosOriginal = [...this.usuariosInscritos];
      this.totalInscritos = this.usuariosInscritos.length;
      this.personasEncontradas = this.usuariosDisponibles.length;

      this.seleccionados.clear();
    },

    filtrarPorProyecto() {
      const proyecto = this.sltProyecto;
      this.inputDisponibles = "";

      if (proyecto === "todos") {
        this.usuariosDisponibles = [...this.usuariosOriginalesDisponibles];
      } else {
        this.usuariosDisponibles = this.usuariosOriginalesDisponibles.filter(
          (usuario) => usuario.dcostos === proyecto
        );
      }

      this.personasEncontradas = this.usuariosDisponibles.length;
      this.seleccionados.clear();
    },

    filtrarPorCargo() {
      const cargo = this.sltCargo;
      this.inputDisponibles = "";

      if (cargo === "todos") {
        this.usuariosDisponibles = [...this.usuariosOriginalesDisponibles];
      } else {
        this.usuariosDisponibles = this.usuariosOriginalesDisponibles.filter(
          (usuario) => usuario.dcargo === cargo
        );
      }

      this.personasEncontradas = this.usuariosDisponibles.length;
      this.seleccionados.clear();
    },
    async obtenerCursoParaEdicion() {
      const params = new URLSearchParams(window.location.search);
      const id_curso = params.get("id_curso");
      if (!id_curso) {
        // await this.obtenerTodosLosUsuarios();
        this.cargando = false;
        return;
      }

      this.cargando = true;
      // await this.obtenerTodosLosUsuarios();

      try {
        const respuesta = await fetch(`api/curso?id_curso=${id_curso}`);
        const data = await respuesta.json();
        if (data.exitoso && data.respuesta) {
          this.modoEdicion = true;
          this.curso = {
            id_curso: data.respuesta.id_curso || null,
            nombre: data.respuesta.nombre || "",
            descripcion: data.respuesta.descripcion || "",
            imagen: data.respuesta.imagen || "",
            dificultad: data.respuesta.dificultad || "principiante",
            duracion: data.respuesta.duracion || 0,
            acceso_libre: data.respuesta.acceso_libre,
          };

          if (Array.isArray(data.respuesta.usuariosInscritos)) {
            const inscritosSet = new Set(data.respuesta.usuariosInscritos);

            this.usuariosInscritos = this.usuariosOriginalesDisponibles
              .filter((usuario) => inscritosSet.has(usuario.internal))
              .map((usuario) => ({ ...usuario, seleccionado: false }));

            this.usuariosInscritosOriginal = [...this.usuariosInscritos];
            this.totalInscritos = this.usuariosInscritos.length;

            this.usuariosOriginalesDisponibles =
              this.usuariosOriginalesDisponibles.filter(
                (usuario) => !inscritosSet.has(usuario.internal)
              );
            this.usuariosDisponibles = [...this.usuariosOriginalesDisponibles];
            this.personasEncontradas = this.usuariosDisponibles.length;
          }
        }
      } catch (error) {
        console.error("Error al obtener el curso para edición:", error);
      } finally {
        this.cargando = false;
      }
    },
    init() {
      this.obtenerCursoParaEdicion();
    },
  };
}

new Sortable(document.getElementById("main-list"), {
  animation: 150,
  group: "temas",
  handle: ".fa-grip-vertical",
  fallbackOnBody: true,
  swapThreshold: 0.65,
});

document.querySelectorAll("#main-list > li > ul").forEach(function (sublist) {
  new Sortable(sublist, {
    animation: 150,
    group: "clases",
    handle: ".fa-grip-vertical",
    fallbackOnBody: true,
    swapThreshold: 0.65,
    emptyInsertThreshold: 50,
    filter: function (evt, item) {
      // No permitir arrastrar el placeholder
      return (
        item.classList.contains("text-gray-400") &&
        item.querySelector(".border-dashed")
      );
    },
    onMove: function (evt) {
      const target = evt.to;
      const placeholder = target.querySelector(".text-gray-400");
      if (placeholder && placeholder.querySelector(".border-dashed")) {
        placeholder.style.display = "none";
      }
    },
    onEnd: function (evt) {
      // Mostrar/ocultar placeholders según contenido
      [evt.from, evt.to].forEach((list) => {
        const placeholder = list.querySelector(".text-gray-400");
        const realItems = Array.from(list.children).filter(
          (item) =>
            !item.classList.contains("text-gray-400") ||
            !item.querySelector(".border-dashed")
        );
        if (placeholder) {
          placeholder.style.display = realItems.length > 0 ? "none" : "";
        }
      });
    },
  });

  const placeholder = sublist.querySelector(".text-gray-400");
  const realItems = Array.from(sublist.children).filter(
    (item) =>
      !item.classList.contains("text-gray-400") ||
      !item.querySelector(".border-dashed")
  );
  if (placeholder && realItems.length > 0) {
    placeholder.style.display = "none";
  }
});
