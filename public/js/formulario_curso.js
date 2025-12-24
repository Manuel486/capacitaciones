function nuevoCursoComponente() {
  return {
    inputDefinitivo: "sss",
    cargando: true,
    curso: {
      nombre: "",
      descripcion: "",
      imagen: "",
      dificultad: "principiante",
      duracion: 0,
      acceso_libre: 1,
      tiene_certificacion: 1,
      temas: [],
      activo: 1,
    },
    temaSeleccionado: {
      id_tema: null,
      id_curso: null,
      nombre: "",
      orden: 0,
      activo: 1,
    },
    progresoUsuarios: [],
    claseSeleccionada: {
      id_clase: null,
      id_tema: null,
      id_item: null,
      titulo: "",
      descripcion: "",
      video: null,
      activo: 1,
      orden: 0,
    },
    anuncioSeleccionado: {
      id_anuncio: null,
      id_tema: null,
      id_item: null,
      titulo: "",
      descripcion: "",
      anuncio: "",
      activo: 1,
    },
    evaluacionSeleccionada: {
      id_evaluacion: null,
      id_tema: null,
      id_item: null,
      titulo: "",
      descripcion: "",
      preguntas: [],
      activo: 1,
      orden: 0,
    },
    modoEdicion: false,
    usuariosOriginalesDisponibles: [],
    usuariosDisponibles: [],
    usuariosInscritosOriginal: [],
    usuariosInscritos: [],
    totalInscritos: 0,
    totalTerminados: 0,
    totalEnProceso: 0,
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
    modalTema: false,
    modalClase: false,
    modalAnuncio: false,
    modalEvaluacion: false,
    guardandoTema: false,
    guardandoClase: false,
    guardandoAnuncio: false,
    guardandoEvaluacion: false,
    guardandoCursoGeneral: false,
    buscadorDePersonasOculto: true,
    ocultarMostrarBuscadorDePersonas() {
      this.buscadorDePersonasOculto = !this.buscadorDePersonasOculto;
    },
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
              data.respuesta
                .map((usuario) => usuario.ccostos + " " + usuario.dcostos)
                .filter((p) => p)
            ),
          ].sort();
          const cargos = [
            ...new Set(
              data.respuesta.map((usuario) => usuario.dcargo).filter((c) => c)
            ),
          ].sort();
          this.proyectos = proyectos;
          this.cargos = cargos;
        }
      } catch (error) {
        console.error("Error en la petición:", error);
      }
    },
    activarVista(vista) {
      this.vistaActiva = vista;

      if (vista === "estructuraCurso") {
        this.$nextTick(() => {
          this.inicializarSortable();
        });
      }
    },
    inicializarSortable() {
      const mainList = document.getElementById("main-list");
      if (!mainList || this.curso.temas.length === 0) return;

      new Sortable(mainList, {
        animation: 150,
        handle: ".fa-grip-vertical",
        swapThreshold: 0.65,
      });

      this.$nextTick(() => {
        const temaElements = mainList.querySelectorAll(":scope > li");

        temaElements.forEach((temaElement) => {
          const sublist = temaElement.querySelector("ul");
          if (sublist) {
            new Sortable(sublist, {
              animation: 150,
              handle: ".fa-grip-vertical",
              group: "items",
              swapThreshold: 0.65,
            });
          }
        });
      });
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
        (u) => u.dni === usuario.dni
      );
      if (yaInscrito) return;

      this.usuariosInscritos.push({ ...usuario, seleccionado: false });

      this.usuariosDisponibles = this.usuariosDisponibles.filter(
        (u) => u.dni !== usuario.dni
      );
      this.usuariosOriginalesDisponibles =
        this.usuariosOriginalesDisponibles.filter((u) => u.dni !== usuario.dni);

      this.usuariosInscritosOriginal = [...this.usuariosInscritos];
      this.totalInscritos = this.usuariosInscritos.length;
      this.personasEncontradas = this.usuariosDisponibles.length;

      this.seleccionados.delete(usuario.dni);
    },

    quitarUsuarioInscrito(usuario) {
      this.usuariosInscritos = this.usuariosInscritos.filter(
        (u) => u.dni !== usuario.dni
      );

      const existeEnDisponibles = this.usuariosDisponibles.some(
        (u) => u.dni === usuario.dni
      );
      const existeEnOriginales = this.usuariosOriginalesDisponibles.some(
        (u) => u.dni === usuario.dni
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
      if (this.guardandoCursoGeneral) return;

      if (!this.curso.nombre || !this.curso.descripcion) {
        this.$dispatch("abrir-modal", {
          titulo: "Advertencia",
          mensaje:
            "Por favor, complete los campos de nombre y descripción del curso.",
          tipo: "advertencia",
        });
        return;
      }

      this.guardandoCursoGeneral = true;
      this.$dispatch("abrir-modal", {
        titulo: "Guardando curso",
        mensaje: "Por favor, espera mientras guardamos el curso.",
        tipo: "cargando",
      });

      try {
        const formData = new FormData();
        formData.append("curso", JSON.stringify(this.curso));

        if (this.curso.imagen && typeof this.curso.imagen === "object") {
          formData.append("imagen", this.curso.imagen);
        }

        if (this.usuariosInscritos.length > 0) {
          const idsUsuarios = this.usuariosInscritos.map((u) => u.dni);
          formData.append("ids_usuarios", JSON.stringify(idsUsuarios));
        }

        formData.append("editar", this.modoEdicion);

        const respuesta = await fetch("api/formulario_curso", {
          method: "POST",
          body: formData,
        });
        const data = await respuesta.json();

        if (data.exitoso) {
          if (!this.modoEdicion)
            window.location.href =
              "formulario_curso?id_curso=" + data.respuesta;
        } else {
          console.error("Error al guardar el curso:", data.mensaje);
        }
      } catch (error) {
        console.error("Error en la petición:", error);
      } finally {
        this.guardandoCursoGeneral = false;
        this.$dispatch("cerrar-modal");
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
          this.usuariosDisponibles.map((u) => u.dni)
        );
      } else {
        this.seleccionados.clear();
      }
    },

    seleccionarUsuario(usuario) {
      usuario.seleccionado = !usuario.seleccionado;

      if (usuario.seleccionado) {
        this.seleccionados.add(usuario.dni);
      } else {
        this.seleccionados.delete(usuario.dni);
      }
    },

    inscribirSeleccionados() {
      if (this.seleccionados.size === 0) return;

      const usuariosAInscribir = this.usuariosDisponibles.filter((usuario) =>
        this.seleccionados.has(usuario.dni)
      );

      const idsInscritos = new Set(this.usuariosInscritos.map((u) => u.dni));

      const usuariosNuevos = usuariosAInscribir.filter(
        (u) => !idsInscritos.has(u.dni)
      );

      this.usuariosInscritos.push(
        ...usuariosNuevos.map((u) => ({ ...u, seleccionado: false }))
      );

      const idsARemover = new Set(usuariosNuevos.map((u) => u.dni));

      this.usuariosDisponibles = this.usuariosDisponibles.filter(
        (u) => !idsARemover.has(u.dni)
      );
      this.usuariosOriginalesDisponibles =
        this.usuariosOriginalesDisponibles.filter(
          (u) => !idsARemover.has(u.dni)
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
          (usuario) => usuario.ccostos + " " + usuario.dcostos === proyecto
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
        this.cargando = false;
        return;
      }

      this.cargando = true;
      await this.obtenerTodosLosUsuarios();

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
            tiene_certificacion: data.respuesta.tiene_certificacion,
            temas: data.respuesta.temas || [],
            activo: data.respuesta.activo || 1,
          };

          this.progresoUsuarios = data.respuesta.progresosUsuarios || [];

          if (Array.isArray(this.curso.temas) && this.curso.temas.length > 0) {
            this.curso.temas.forEach((tema) => {
              tema.dropDownActivo = false;
            });
          }

          if (Array.isArray(data.respuesta.usuariosInscritos)) {
            const inscritosSet = new Set(data.respuesta.usuariosInscritos);

            this.usuariosInscritos = this.usuariosOriginalesDisponibles
              .filter((usuario) => inscritosSet.has(usuario.dni))
              .map((usuario) => ({ ...usuario, seleccionado: false }));

            this.usuariosInscritosOriginal = [...this.usuariosInscritos];
            this.totalInscritos = this.usuariosInscritos.length;
            this.totalTerminados = this.usuariosInscritos.filter((u) => {
              const progreso = this.obtenerProgresodelUsuario(u.dni);
              return progreso == 100;
            }).length;
            this.totalEnProceso = this.totalInscritos - this.totalTerminados;

            this.usuariosOriginalesDisponibles =
              this.usuariosOriginalesDisponibles.filter(
                (usuario) => !inscritosSet.has(usuario.dni)
              );
            this.usuariosDisponibles = [...this.usuariosOriginalesDisponibles];
            this.personasEncontradas = this.usuariosDisponibles.length;
          }
          this.cargando = false;
        } else {
          window.location.href = "inicio";
        }
      } catch (error) {
        console.error("Error al obtener el curso para edición:", error);
      }
    },
    obtenerProgresodelUsuario(dni) {
      const progresoObj = this.progresoUsuarios.find(
        (p) => p.id_usuario === dni
      );
      return progresoObj ? progresoObj.progreso : 0;
    },
    async cambiarEstadoCurso() {
      this.curso.activo = this.curso.activo == 1 ? 0 : 1;

      try {
        const formData = new FormData();
        formData.append("id_curso", this.curso.id_curso);
        formData.append("activo", this.curso.activo);
        const respuesta = await fetch("api/cambiar_estado_curso", {
          method: "POST",
          body: formData,
        });
        const data = await respuesta.json();
        if (!data.exitoso) {
          console.error("Error al cambiar el estado del curso:", data.mensaje);
        }
      } catch (error) {
        console.error("Error en la petición:", error);
      }
    },
    async cambiarEstadoItem(item) {
      item.detalle.activo = item.detalle.activo == 1 ? 0 : 1;
      try {
        const formData = new FormData();
        formData.append("id_item", item.id_item);
        formData.append("activo", item.detalle.activo);
        const respuesta = await fetch("api/cambiar_estado_item", {
          method: "POST",
          body: formData,
        });
        const data = await respuesta.json();
        if (!data.exitoso) {
          console.error("Error al cambiar el estado del ítem:", data.mensaje);
        }
      } catch (error) {
        console.error("Error en la petición:", error);
      }
    },
    agregarTema() {
      const nuevoOrden = this.curso.temas.length + 1;
      this.temaSeleccionado = {
        id_tema: null,
        id_curso: this.curso.id_curso,
        nombre: "",
        orden: nuevoOrden,
        activo: 1,
      };
      this.modalTema = true;
    },
    editarTema(tema) {
      this.temaSeleccionado = {
        id_tema: tema.id_tema,
        id_curso: this.curso.id_curso,
        nombre: tema.nombre,
        orden: tema.orden,
        activo: tema.activo || 1,
        items: tema.items || [],
        dropDownActivo: false,
      };
      this.modalTema = true;
    },
    async guardarTema() {
      if (this.guardandoTema) return;

      if (!this.temaSeleccionado.nombre) {
        this.$dispatch("abrir-modal", {
          titulo: "Campos obligatorios",
          mensaje: "Por favor, complete el nombre del tema.",
          tipo: "info",
        });
        return;
      }

      this.guardandoTema = true;
      this.$dispatch("abrir-modal", {
        titulo: "Guardando tema",
        mensaje: "Por favor, espera mientras guardamos el tema.",
        tipo: "cargando",
      });

      try {
        const formData = new FormData();
        formData.append("tema", JSON.stringify(this.temaSeleccionado));
        const respuesta = await fetch("api/guardar_tema", {
          method: "POST",
          body: formData,
        });
        const data = await respuesta.json();
        if (data.exitoso) {
          if (this.temaSeleccionado.id_tema) {
            const temaIndex = this.curso.temas.findIndex(
              (t) => t.id_tema === this.temaSeleccionado.id_tema
            );
            if (temaIndex !== -1) {
              const itemsActuales = this.curso.temas[temaIndex].items;
              this.curso.temas[temaIndex] = {
                ...data.respuesta,
                items: itemsActuales,
              };
            }
          } else {
            this.curso.temas.push({
              ...data.respuesta,
              items: [],
            });
          }
          this.cerrarModalTema();
        }
      } catch (error) {
        console.error("Error al guardar el tema:", error);
      } finally {
        this.guardandoTema = false;
        this.$dispatch("cerrar-modal");
      }
    },
    cerrarModalTema() {
      this.modalTema = false;
      this.temaSeleccionado = {
        id_tema: null,
        id_curso: null,
        nombre: "",
        orden: 0,
        activo: 1,
      };
    },
    agregarClaseATema(tema) {
      this.claseSeleccionada.id_tema = tema.id_tema;
      this.modalClase = true;
      tema.dropDownActivo = false;
      const nuevoOrden = tema.items.length + 1;
      this.claseSeleccionada.orden = nuevoOrden;
    },
    inicializarEditoresQuill() {
      this.$nextTick(() => {
        this.evaluacionSeleccionada.preguntas.forEach((pregunta, index) => {
          const editorId = `editor-pregunta-${index}`;
          const editorElement = document.getElementById(editorId);

          if (
            editorElement &&
            !editorElement.classList.contains("ql-container")
          ) {
            const quill = new Quill(editorElement, {
              theme: "snow",
              placeholder: "Escribe el texto de la pregunta aquí...",
              modules: {
                toolbar: [
                  ["bold", "italic", "underline"],
                  ["image"],
                  [{ list: "ordered" }, { list: "bullet" }],
                  ["clean"],
                ],
              },
            });

            if (pregunta.contenido) {
              quill.root.innerHTML = pregunta.contenido;
            }

            quill.on("text-change", () => {
              this.evaluacionSeleccionada.preguntas[index].contenido =
                quill.root.innerHTML;
            });
          }
        });
      });
    },
    editarItem(tema, item) {
      if (item.tipo === "clase") {
        this.claseSeleccionada = {
          id_clase: item.id_referencia,
          id_tema: tema.id_tema,
          id_item: item.id_item,
          titulo: item.detalle.titulo,
          descripcion: item.detalle.descripcion,
          video: item.detalle.video,
          activo: item.detalle.activo,
          orden: item.orden,
        };
        this.modalClase = true;
        tema.dropDownActivo = false;
      } else if (item.tipo === "anuncio") {
        this.anuncioSeleccionado = {
          id_anuncio: item.id_referencia,
          id_tema: tema.id_tema,
          id_item: item.id_item,
          titulo: item.detalle.titulo,
          descripcion: item.detalle.descripcion,
          anuncio: item.detalle.anuncio,
          activo: item.detalle.activo,
          orden: item.orden,
        };
        this.modalAnuncio = true;
        tema.dropDownActivo = false;
      } else if (item.tipo === "evaluacion") {
        this.evaluacionSeleccionada = {
          id_evaluacion: item.id_referencia,
          id_tema: tema.id_tema,
          id_item: item.id_item,
          titulo: item.detalle.titulo,
          descripcion: item.detalle.descripcion,
          preguntas: item.detalle.preguntas || [],
          activo: item.detalle.activo,
          orden: item.orden,
        };
        this.modalEvaluacion = true;
        tema.dropDownActivo = false;

        this.inicializarEditoresQuill();
      }
    },
    agregarAnuncioATema(tema) {
      this.anuncioSeleccionado.id_tema = tema.id_tema;
      this.modalAnuncio = true;
      tema.dropDownActivo = false;
      const nuevoOrden = tema.items.length + 1;
      this.anuncioSeleccionado.orden = nuevoOrden;
    },
    cerrarModalAnuncio() {
      this.modalAnuncio = false;
      this.anuncioSeleccionado = {
        id_anuncio: null,
        id_tema: null,
        id_item: null,
        titulo: "",
        descripcion: "",
        anuncio: "",
        activo: 1,
      };
    },
    async guardarAnuncio() {
      if (this.guardandoAnuncio) return;

      if (
        !this.anuncioSeleccionado.titulo ||
        !this.anuncioSeleccionado.descripcion ||
        !this.anuncioSeleccionado.anuncio
      ) {
        this.$dispatch("abrir-modal", {
          titulo: "Campos obligatorios",
          mensaje:
            "Por favor, complete los campos de título, descripción y contenido del anuncio.",
          tipo: "info",
        });
        return;
      }

      this.guardandoAnuncio = true;
      this.$dispatch("abrir-modal", {
        titulo: "Guardando anuncio",
        mensaje: "Por favor, espera mientras guardamos el anuncio.",
        tipo: "cargando",
      });

      try {
        const formData = new FormData();
        formData.append("anuncio", JSON.stringify(this.anuncioSeleccionado));
        const respuesta = await fetch("api/guardar_anuncio", {
          method: "POST",
          body: formData,
        });
        const data = await respuesta.json();
        if (data.exitoso) {
          const tema = this.curso.temas.find(
            (t) => t.id_tema === this.anuncioSeleccionado.id_tema
          );
          if (!tema) return;

          if (this.anuncioSeleccionado.id_item) {
            const itemIndex = tema.items.findIndex(
              (i) => i.id_item === this.anuncioSeleccionado.id_item
            );
            if (itemIndex !== -1) {
              tema.items[itemIndex] = data.respuesta;
            }
          } else {
            tema.items.push(data.respuesta);
          }
          this.cerrarModalAnuncio();
        }
      } catch (error) {
        console.error("Error al guardar el anuncio:", error);
      } finally {
        this.guardandoAnuncio = false;
        this.$dispatch("cerrar-modal");
      }
    },
    agregarEvaluacionATema(tema) {
      this.evaluacionSeleccionada.id_tema = tema.id_tema;
      this.modalEvaluacion = true;
      tema.dropDownActivo = false;
      const nuevoOrden = tema.items.length + 1;
      this.evaluacionSeleccionada.orden = nuevoOrden;
    },
    cerrarEvaluacionModal() {
      this.modalEvaluacion = false;
      this.evaluacionSeleccionada = {
        id_evaluacion: null,
        id_tema: null,
        id_item: null,
        titulo: "",
        descripcion: "",
        preguntas: [],
        activo: 1,
        orden: 0,
      };
    },
    async guardarEvaluacion() {
      if (this.guardandoEvaluacion) return;

      if (
        !this.evaluacionSeleccionada.titulo ||
        !this.evaluacionSeleccionada.descripcion
      ) {
        this.$dispatch("abrir-modal", {
          titulo: "Campos obligatorios",
          mensaje:
            "Por favor, complete los campos de título y descripción de la evaluación, y como mínimo una pregunta.",
          tipo: "info",
        });
        return;
      }

      if (
        !Array.isArray(this.evaluacionSeleccionada.preguntas) ||
        this.evaluacionSeleccionada.preguntas.length === 0
      ) {
        this.$dispatch("abrir-modal", {
          titulo: "Campos obligatorios",
          mensaje: "La evaluación debe tener al menos una pregunta.",
          tipo: "info",
        });
        return;
      }

      for (const [
        i,
        pregunta,
      ] of this.evaluacionSeleccionada.preguntas.entries()) {
        if (
          !pregunta.contenido ||
          !Array.isArray(pregunta.alternativas) ||
          pregunta.alternativas.length === 0
        ) {
          this.$dispatch("abrir-modal", {
            titulo: "Campos obligatorios",
            mensaje: `La pregunta ${
              i + 1
            } no puede estar vacía y al menos debe tener una alternativa.`,
            tipo: "info",
          });
          return;
        }
        for (const [j, alternativa] of pregunta.alternativas.entries()) {
          if (!alternativa.contenido) {
            this.$dispatch("abrir-modal", {
              titulo: "Campos obligatorios",
              mensaje: `La alternativa ${j + 1} de la pregunta ${
                i + 1
              } no puede estar vacía.`,
              tipo: "info",
            });
            return;
          }
        }
        const tieneRespuesta = pregunta.alternativas.some(
          (a) => a.es_respuesta == 1
        );
        if (!tieneRespuesta) {
          this.$dispatch("abrir-modal", {
            titulo: "Campos obligatorios",
            mensaje: `La pregunta ${
              i + 1
            } debe tener una alternativa marcada como respuesta.`,
            tipo: "info",
          });
          return;
        }
      }

      this.guardandoEvaluacion = true;
      this.$dispatch("abrir-modal", {
        titulo: "Guardando evaluación",
        mensaje: "Por favor, espera mientras guardamos la evaluación.",
        tipo: "cargando",
      });

      try {
        const formData = new FormData();
        formData.append(
          "evaluacion",
          JSON.stringify(this.evaluacionSeleccionada)
        );
        const respuesta = await fetch("api/guardar_evaluacion", {
          method: "POST",
          body: formData,
        });
        const data = await respuesta.json();
        if (data.exitoso) {
          const tema = this.curso.temas.find(
            (t) => t.id_tema === this.evaluacionSeleccionada.id_tema
          );
          if (!tema) return;
          if (this.evaluacionSeleccionada.id_item) {
            const itemIndex = tema.items.findIndex(
              (i) => i.id_item === this.evaluacionSeleccionada.id_item
            );
            if (itemIndex !== -1) {
              tema.items[itemIndex] = data.respuesta;
            }
          } else {
            tema.items.push(data.respuesta);
          }
          this.cerrarEvaluacionModal();
        }
      } catch (error) {
        console.error("Error al guardar la evaluación:", error);
      } finally {
        this.guardandoEvaluacion = false;
        this.$dispatch("cerrar-modal");
      }
    },
    cambiarImagenCurso(event) {
      const file = event.target.files[0];
      if (file && file.size > 5 * 1024 * 1024) {
        this.$dispatch("abrir-modal", {
          titulo: "Archivo demasiado grande",
          mensaje: "El tamaño máximo permitido para el video es de 5MB.",
          tipo: "info",
        });
        event.target.value = null;
        return;
      }

      this.curso.imagen = file;
    },
    agregarPregunta() {
      this.evaluacionSeleccionada.preguntas.push({
        id_pregunta: null,
        id_evaluacion: null,
        contenido: "",
        alternativas: [],
      });

      // Agregar quill automáticamente a la nueva pregunta
      this.$nextTick(() => {
        const indexNuevaPregunta =
          this.evaluacionSeleccionada.preguntas.length - 1;
        const editorId = `editor-pregunta-${indexNuevaPregunta}`;
        const editorElement = document.getElementById(editorId);
        if (editorElement) {
          const quill = new Quill(editorElement, {
            theme: "snow",
            placeholder: "Escribe el texto de la pregunta aquí...",
            modules: {
              toolbar: [
                [{ header: [1, 2, false] }],
                ["bold", "italic", "underline"],
                ["image"],
                [{ list: "ordered" }, { list: "bullet" }],
                ["clean"],
              ],
            },
          });

          // Sincronizar contenido con el modelo cuando cambie
          quill.on("text-change", () => {
            this.evaluacionSeleccionada.preguntas[
              indexNuevaPregunta
            ].contenido = quill.root.innerHTML;
          });
        }
      });
    },
    eliminarPregunta(indexPregunta) {
      this.evaluacionSeleccionada.preguntas.splice(indexPregunta, 1);
    },
    agregarAlternativa(indexPregunta) {
      this.evaluacionSeleccionada.preguntas[indexPregunta].alternativas.push({
        id_alternativa: null,
        id_pregunta: null,
        contenido: "",
        es_respuesta: 0,
      });
    },
    marcarAlternativaCorrecta(indexPregunta, indexAlternativa) {
      this.evaluacionSeleccionada.preguntas[indexPregunta].alternativas.forEach(
        (alternativa, idx) => {
          alternativa.es_respuesta = idx === indexAlternativa ? 1 : 0;
        }
      );
    },
    eliminarAlternativa(indexPregunta, indexAlternativa) {
      this.evaluacionSeleccionada.preguntas[indexPregunta].alternativas.splice(
        indexAlternativa,
        1
      );
    },
    cerrarModalClase() {
      this.modalClase = false;
      this.claseSeleccionada = {
        id_clase: null,
        id_tema: null,
        id_item: null,
        titulo: "",
        descripcion: "",
        video: null,
        activo: 1,
        orden: 0,
      };
    },
    async guardarClase() {
      if (this.guardandoClase) return;
      if (
        !this.claseSeleccionada.titulo ||
        !this.claseSeleccionada.descripcion ||
        !this.claseSeleccionada.video
      ) {
        this.$dispatch("abrir-modal", {
          titulo: "Campos obligatorios",
          mensaje:
            "Por favor, complete los campos de título, descripción y video de la clase.",
          tipo: "info",
        });
        return;
      }

      this.guardandoClase = true;

      this.$dispatch("abrir-modal", {
        titulo: "Guardando clase",
        mensaje: "Por favor, espera mientras guardamos la clase.",
        tipo: "cargando",
      });

      try {
        const formData = new FormData();
        formData.append("clase", JSON.stringify(this.claseSeleccionada));
        if (
          this.claseSeleccionada.video &&
          typeof this.claseSeleccionada.video === "object"
        ) {
          formData.append("video", this.claseSeleccionada.video);
        }
        const respuesta = await fetch("api/guardar_clase", {
          method: "POST",
          body: formData,
        });
        const data = await respuesta.json();
        if (data.exitoso) {
          const tema = this.curso.temas.find(
            (t) => t.id_tema === this.claseSeleccionada.id_tema
          );

          if (!tema) return;

          if (this.claseSeleccionada.id_item) {
            const itemIndex = tema.items.findIndex(
              (i) => i.id_item === this.claseSeleccionada.id_item
            );

            if (itemIndex !== -1) {
              tema.items[itemIndex] = data.respuesta;
            }
          } else {
            tema.items.push(data.respuesta);
          }

          this.cerrarModalClase();
        }
      } catch (error) {
        console.error("Error al guardar la clase:", error);
      } finally {
        this.guardandoClase = false;
        this.$dispatch("cerrar-modal");
      }
    },
    init() {
      this.obtenerCursoParaEdicion();
    },
  };
}
