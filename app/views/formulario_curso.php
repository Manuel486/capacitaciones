<div x-data="nuevoCursoComponente()">
    <div x-show="modalTema" x-cloak class="fixed inset-0 flex items-center justify-center z-100 p-4"
        style="background: rgba(0,0,0,0.5);">
        <div class="bg-white rounded-lg shadow-lg max-w-lg w-full p-4 sm:p-6 relative max-h-[90vh] overflow-y-auto">
            <button @click="cerrarModalTema()" class="absolute top-3 right-3 text-gray-400 hover:text-gray-600">
                <i class="fas fa-times text-xl"></i>
            </button>
            <h2 class="text-xl font-bold mb-4 text-gray-800">Tema</h2>
            <form class="space-y-4">
                <div>
                    <label class="block text-gray-700 font-medium mb-1">Nombre <span
                            class="text-red-600 font-bold">*</span></label>
                    <input type="text" x-model="temaSeleccionado.nombre"
                        class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring focus:border-blue-400"
                        placeholder="Nombre del tema" />
                </div>
                <div class="flex justify-end space-x-2 pt-2">
                    <button @click="cerrarModalTema()" type="button"
                        class="px-4 py-2 bg-gray-200 text-gray-700 rounded hover:bg-gray-300 transition">
                        Cancelar
                    </button>
                    <button type="button" @click="guardarTema()"
                        class="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700 transition">
                        Guardar
                    </button>
                </div>
            </form>
        </div>
    </div>

    <div x-show="modalEvaluacion" x-cloak class="fixed inset-0 flex items-center justify-center z-100 p-4"
        style="background: rgba(0,0,0,0.5);">
        <div class="bg-white rounded-lg shadow-lg max-w-2xl w-full p-4 sm:p-6 relative max-h-[90vh] overflow-y-auto">
            <button @click="cerrarEvaluacionModal()" class="absolute top-3 right-3 text-gray-400 hover:text-gray-600">
                <i class="fas fa-times text-xl"></i>
            </button>
            <h2 class="text-xl font-bold mb-4 text-gray-800">Evaluación</h2>
            <form class="space-y-4">
                <div>
                    <label class="block text-gray-700 font-medium mb-1">Título <span
                            class="text-red-600 font-bold">*</span></label>
                    <input type="text" x-model="evaluacionSeleccionada.titulo"
                        class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring focus:border-blue-400"
                        placeholder="Título de la evaluación" />
                </div>
                <div>
                    <label class="block text-gray-700 font-medium mb-1">Descripción <span
                            class="text-red-600 font-bold">*</span></label>
                    <textarea x-model="evaluacionSeleccionada.descripcion"
                        class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring focus:border-blue-400"
                        rows="3" placeholder="Descripción de la evaluación"></textarea>
                </div>
                <button type="button" @click="agregarPregunta()"
                    class="px-3 py-2 bg-blue-100 text-blue-700 rounded hover:bg-blue-200 transition mb-4">
                    Agregar Pregunta
                </button>
                <div>
                    <template x-for="(pregunta, index) in evaluacionSeleccionada.preguntas" :key="index">
                        <div class="border border-gray-300 rounded-lg p-4 mb-4">
                            <div class="flex justify-between items-center mb-2">
                                <h3 class="font-semibold text-gray-800" x-text="'Pregunta ' + (index + 1)"></h3>
                                <button type="button" @click="eliminarPregunta(index)"
                                    class="text-red-600 hover:text-red-800">
                                    <i class="fas fa-trash-alt"></i>
                                </button>
                            </div>
                            <input type="text" x-model="pregunta.contenido"
                                class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring focus:border-blue-400 mb-2"
                                placeholder="Texto de la pregunta" />
                            <div class="space-y-2">
                                <template x-for="(alternativa, alternativaIndex) in pregunta.alternativas"
                                    :key="alternativaIndex">
                                    <div class="flex items-center space-x-2">
                                        <input type="text" x-model="alternativa.contenido"
                                            class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring focus:border-blue-400"
                                            placeholder="Opción de respuesta" />
                                        <input type="radio" :name="'correcta_' + index"
                                            :checked="alternativa.es_respuesta == 1"
                                            @change="marcarAlternativaCorrecta(index, alternativaIndex)" />
                                        <button type="button" @click="eliminarAlternativa(index, alternativaIndex)"
                                            class="text-red-600 hover:text-red-800">
                                            <i class="fas fa-trash-alt"></i>
                                        </button>
                                    </div>
                                </template>
                                <button type="button" @click="agregarAlternativa(index)"
                                    class="px-2 py-1 bg-green-100 text-green-700 rounded hover:bg-green-200 transition mt-2">
                                    Agregar alternativa
                                </button>
                            </div>
                        </div>
                    </template>
                </div>
                <div class="flex justify-end space-x-2 pt-2">
                    <button type="button" @click="cerrarEvaluacionModal()"
                        class="px-4 py-2 bg-gray-200 text-gray-700 rounded hover:bg-gray-300 transition">
                        Cancelar
                    </button>
                    <button @click="guardarEvaluacion()" type="button"
                        class="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700 transition">
                        Guardar
                    </button>
                </div>
            </form>
        </div>
    </div>

    <div x-show="modalClase" x-cloak class="fixed inset-0 flex items-center justify-center z-100 p-4"
        style="background: rgba(0,0,0,0.5);">
        <div class="bg-white rounded-lg shadow-lg max-w-lg w-full p-4 sm:p-6 relative max-h-[90vh] overflow-y-auto">
            <button @click="cerrarModalClase()" class="absolute top-3 right-3 text-gray-400 hover:text-gray-600">
                <i class="fas fa-times text-xl"></i>
            </button>
            <h2 class="text-xl font-bold mb-4 text-gray-800">Clase</h2>
            <form class="space-y-4">
                <div>
                    <label class="block text-gray-700 font-medium mb-1">Título <span
                            class="text-red-600 font-bold">*</span></label>
                    <input type="text" x-model="claseSeleccionada.titulo"
                        class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring focus:border-blue-400"
                        placeholder="Título de la clase" />
                </div>
                <div>
                    <label class="block text-gray-700 font-medium mb-1">Descripción <span
                            class="text-red-600 font-bold">*</span></label>
                    <textarea x-model="claseSeleccionada.descripcion"
                        class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring focus:border-blue-400"
                        rows="3" placeholder="Descripción de la clase"></textarea>
                </div>
                <div>
                    <label for="videoClase"
                        class="block w-full cursor-pointer border-2 border-dashed border-blue-400 rounded-lg p-6 text-center text-blue-600 font-semibold text-lg hover:bg-blue-50 transition">
                        <i class="fas fa-cloud-upload-alt text-3xl mb-2"></i><br />
                        Arrastra o suelta el video aquí o haz clic para seleccionar
                    </label>
                    <input type="file" id="videoClase" class="hidden" accept="video/*" @change="
                        const file = $event.target.files[0];
                        if (file && file.size > 40 * 1024 * 1024) {
                                $dispatch('abrir-modal', {
                                    titulo: 'Archivo demasiado grande',
                                    mensaje: 'El tamaño máximo permitido para el video es de 40MB.',
                                    tipo: 'info',
                                    });
                            $event.target.value = null;
                            return;
                        }
                        claseSeleccionada.video = file;
                        $nextTick(() => document.getElementById('previewVideoClase')?.load());
                        $event.target.value = null;
                    " />
                    <div class="mt-4" x-show="claseSeleccionada.video" x-cloak>
                        <video id="previewVideoClase" class="w-full rounded-lg shadow" controls :src="typeof claseSeleccionada.video === 'string'
                                ? 'api/obtener_video?nombre=' + claseSeleccionada.video
                                : (claseSeleccionada.video ? URL.createObjectURL(claseSeleccionada.video) : '')">
                            Tu navegador no soporta la reproducción de video.
                        </video>
                    </div>
                </div>
                <div class="flex justify-end space-x-2 pt-2">
                    <button @click="cerrarModalClase()" type="button"
                        class="px-4 py-2 bg-gray-200 text-gray-700 rounded hover:bg-gray-300 transition">
                        Cancelar
                    </button>
                    <button type="button" @click="guardarClase()"
                        class="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700 transition">
                        Guardar
                    </button>
                </div>
            </form>
        </div>
    </div>

    <div x-show="modalAnuncio" x-cloak class="fixed inset-0 flex items-center justify-center z-100 p-4"
        style="background: rgba(0,0,0,0.5);">
        <div class="bg-white rounded-lg shadow-lg max-w-lg w-full p-4 sm:p-6 relative max-h-[90vh] overflow-y-auto">
            <button @click="cerrarModalAnuncio()" class="absolute top-3 right-3 text-gray-400 hover:text-gray-600">
                <i class="fas fa-times text-xl"></i>
            </button>
            <h2 class="text-xl font-bold mb-4 text-gray-800">Anuncio</h2>
            <form class="space-y-4">
                <div>
                    <label class="block text-gray-700 font-medium mb-1">Titulo <span
                            class="text-red-600 font-bold">*</span></label>
                    <input type="text" x-model="anuncioSeleccionado.titulo"
                        class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring focus:border-blue-400"
                        placeholder="Titulo del anuncio" />
                </div>
                <div>
                    <label class="block text-gray-700 font-medium mb-1">Descripción <span
                            class="text-red-600 font-bold">*</span></label>
                    <textarea x-model="anuncioSeleccionado.descripcion"
                        class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring focus:border-blue-400"
                        rows="3" placeholder="Descripción del anuncio"></textarea>
                </div>
                <div>
                    <label class="block text-gray-700 font-medium mb-1">Contenido del anuncio <span
                            class="text-red-600 font-bold">*</span></label>
                    <textarea x-model="anuncioSeleccionado.anuncio"
                        class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring focus:border-blue-400"
                        rows="3" placeholder="Contenido del anuncio"></textarea>
                </div>
                <div class="flex justify-end space-x-2 pt-2">
                    <button @click="cerrarModalAnuncio()" type="button"
                        class="px-4 py-2 bg-gray-200 text-gray-700 rounded hover:bg-gray-300 transition">
                        Cancelar
                    </button>
                    <button type="button" @click="guardarAnuncio()"
                        class="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700 transition">
                        Guardar
                    </button>
                </div>
            </form>
        </div>
    </div>


    <div class="container mx-auto px-4 py-8">
        <div x-show="cargando" x-cloak>
            <div class="flex justify-between mb-4 animate-pulse">
                <ul class="flex gap-4">
                    <li class="h-6 w-32 bg-gray-300 rounded"></li>
                    <li class="h-6 w-32 bg-gray-300 rounded"></li>
                    <li class="h-6 w-24 bg-gray-300 rounded"></li>
                </ul>
                <div class="h-10 w-32 bg-gray-300 rounded"></div>
            </div>

            <div class="bg-white rounded-lg shadow p-6 animate-pulse">
                <div class="space-y-4">
                    <div>
                        <div class="h-4 w-32 bg-gray-300 rounded mb-2"></div>
                        <div class="h-10 w-full bg-gray-200 rounded"></div>
                    </div>

                    <div>
                        <div class="h-4 w-40 bg-gray-300 rounded mb-2"></div>
                        <div class="h-24 w-full bg-gray-200 rounded"></div>
                    </div>

                    <div>
                        <div class="h-4 w-48 bg-gray-300 rounded mb-2"></div>
                        <div class="h-10 w-full bg-gray-200 rounded"></div>
                        <div class="h-24 w-48 bg-gray-200 rounded mt-2"></div>
                    </div>
                </div>
            </div>
        </div>
        <div x-show="!cargando" x-cloak>
            <div class="flex justify-between mb-2">
                <ul class="flex gap-2">
                    <li @click="activarVista('descripcionGeneral')" :class="{
                        'cursor-pointer px-4 py-2 rounded-t-lg font-semibold transition': true,
                        'bg-blue-900 text-white shadow': vistaActiva === 'descripcionGeneral',
                        'bg-white text-gray-700 hover:bg-blue-100': vistaActiva !== 'descripcionGeneral'
                    }">
                        Descripción General
                    </li>
                    <li x-show="modoEdicion" @click="activarVista('estructuraCurso')" :class="{
                        'cursor-pointer px-4 py-2 rounded-t-lg font-semibold transition': true,
                        'bg-blue-900 text-white shadow': vistaActiva === 'estructuraCurso',
                        'bg-white text-gray-700 hover:bg-blue-100': vistaActiva !== 'estructuraCurso'
                    }">
                        Estructura del curso
                    </li>
                    <li x-show="modoEdicion" @click="activarVista('personasInscritas')" :class="{
                        'cursor-pointer px-4 py-2 rounded-t-lg font-semibold transition': true,
                        'bg-blue-900 text-white shadow': vistaActiva === 'personasInscritas',
                        'bg-white text-gray-700 hover:bg-blue-100': vistaActiva !== 'personasInscritas'
                    }">
                        Inscritos
                    </li>
                </ul>
                <button type="button" @click="guardarCurso()"
                    class="bg-white text-green-700 border-2 border-green-700 px-6 py-2 rounded-lg shadow hover:bg-green-700 hover:text-white transition font-semibold flex items-center gap-2">
                    <span x-text="'Guardar Cambios'"></span>
                </button>
            </div>
            <div x-show="vistaActiva === 'descripcionGeneral'" x-cloak class="bg-white rounded-lg shadow p-6">
                <form class="grid grid-cols-1 md:grid-cols-3 gap-8 items-start">
                    <div class="md:col-span-2 space-y-6">
                        <div class="flex justify-end">
                            <button @click="cambiarEstadoCurso()" :class="[
                                'flex items-center gap-2 rounded transition px-3 py-1',
                                curso.activo == 1 ? 'text-green-600' : 'text-gray-400'
                                ]" :title="curso.activo == 1 ? 'Desactivar' : 'Activar'" type="button">
                                <i
                                    :class="curso.activo == 1 ? 'fas fa-toggle-on text-3xl' : 'fas fa-toggle-off text-3xl'"></i>
                                <span x-text="curso.activo == 1 ? 'Curso activo' : 'Curso inactivo'"></span>
                            </button>
                        </div>
                        <div>
                            <label class="block font-semibold mb-1" for="nombreCurso">Nombre del curso <span
                                    class="text-red-600 font-bold">*</span></label>
                            <input type="text" x-model="curso.nombre"
                                class="border rounded-md w-full p-2 focus:ring-2 focus:ring-blue-900 focus:border-none outline-none"
                                placeholder="Nombre del curso">
                        </div>

                        <div>
                            <label class="block font-semibold mb-1" for="descripcionCurso">Descripción del curso <span
                                    class="text-red-600 font-bold">*</span></label>
                            <textarea x-model="curso.descripcion"
                                class="border rounded-md w-full p-2 min-h-[80px] focus:ring-2 focus:ring-blue-900 focus:border-none outline-none"
                                placeholder="Descripción del curso"></textarea>
                        </div>

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div>
                                <label class="block font-semibold mb-1" for="dificultadCurso">Dificultad</label>
                                <select x-model="curso.dificultad"
                                    class="border rounded-md w-full p-2 focus:ring-2 focus:ring-blue-900 focus:border-none outline-none">
                                    <option value="principiante">Principiante</option>
                                    <option value="intermedio">Intermedio</option>
                                    <option value="avanzado">Avanzado</option>
                                </select>
                            </div>
                            <div>
                                <label class="block font-semibold mb-1" for="duracionCurso">Duración (horas)</label>
                                <input type="number" x-model="curso.duracion"
                                    class="border rounded-md w-full p-2 focus:ring-2 focus:ring-blue-900 focus:border-none outline-none"
                                    placeholder="Duración en horas" min="1">
                            </div>
                        </div>

                        <div>
                            <label class="block font-semibold mb-1" for="accesoCurso">Tipo de Acceso</label>
                            <select x-model="curso.acceso_libre"
                                class="border rounded-md w-full p-2 focus:ring-2 focus:ring-blue-900 focus:border-none outline-none">
                                <option value="1">Acceso Libre</option>
                                <option value="0">Acceso Cerrado</option>
                            </select>
                            <p class="text-xs text-gray-500 mt-1" x-show="curso.acceso_libre == 1">
                                Nota: Acceso libre permite que cualquier persona pueda realizar el curso.
                            </p>
                        </div>
                    </div>
                    <div class="flex flex-col items-center justify-start gap-4">
                        <label class="block font-semibold mb-1" for="imagenCurso">Imagen referencial del curso</label>
                        <input type="file" accept="image/*" @change="curso.imagen = $event.target.files[0]"
                            class="border rounded-md w-full p-2 bg-white file:mr-4 file:py-2 file:px-4 file:rounded-md file:border-0 file:text-sm file:bg-blue-50 file:text-blue-900">
                        <div class="mt-2 flex items-center justify-center">
                            <template x-cloak x-if="curso.imagen && typeof curso.imagen === 'string'">
                                <img :src="'public/assets/portadas/' + curso.imagen" alt="Imagen del curso"
                                    class=" object-cover rounded shadow">
                            </template>
                            <template x-cloak x-if="curso.imagen && typeof curso.imagen === 'object'">
                                <img :src="URL.createObjectURL(curso.imagen)" alt="Preview imagen"
                                    class=" object-cover rounded shadow">
                            </template>
                            <template x-cloak x-if="!curso.imagen">
                                <img src="public/assets/portadas/plantilla.jpg" alt="Imagen del curso"
                                    class="h-64 w-64 object-cover rounded shadow">
                            </template>
                        </div>
                    </div>
                </form>
            </div>
            <div class="bg-white rounded-lg shadow p-6 mb-20" x-show="vistaActiva === 'estructuraCurso'" x-cloak>
                <ul id="main-list" class="space-y-3">
                    <button type="button"
                        class="flex items-center gap-2 px-4 py-2 mb-2 border border-blue-900 text-blue-900 rounded-lg shadow hover:bg-blue-900 hover:text-white transition font-semibold"
                        @click="agregarTema()">
                        <i class="fas fa-plus"></i>
                        Agregar Tema
                    </button>
                    <template x-for="(tema, indexTema) in curso.temas" :key="tema.id_tema">
                        <li class="bg-white border border-gray-200 rounded-lg relative">
                            <div class="flex justify-between items-center p-4 bg-gray-50 border-b border-gray-200">
                                <div class="flex items-center space-x-3">
                                    <i class="fas fa-grip-vertical text-gray-400 cursor-pointer"></i>
                                    <span class="font-semibold text-gray-800" x-text="'Tema : ' + tema.nombre"></span>
                                </div>
                                <div class="flex items-center space-x-2">
                                    <button @click="editarTema(tema)"
                                        class="w-8 h-8 flex items-center justify-center text-gray-600 hover:bg-gray-200 rounded transition"
                                        title="Editar">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <div class="relative">
                                        <button @click="tema.dropDownActivo = !tema.dropDownActivo"
                                            class="w-8 h-8 flex items-center justify-center text-blue-600 hover:bg-blue-50 rounded transition"
                                            title="Agregar Clase" type="button">
                                            <i class="fas fa-plus"></i>
                                        </button>
                                        <div x-show="tema.dropDownActivo" @click.away="tema.dropDownActivo = false"
                                            class="absolute right-0 mt-2 w-40 bg-white border border-gray-200 rounded shadow-lg z-50">
                                            <button @click="agregarClaseATema(tema)"
                                                class="block w-full text-left px-4 py-2 hover:bg-gray-100 text-gray-700"
                                                type="button">
                                                Clase
                                            </button>
                                            <button @click="agregarAnuncioATema(tema)"
                                                class="block w-full text-left px-4 py-2 hover:bg-gray-100 text-gray-700"
                                                type="button">
                                                Anuncio
                                            </button>
                                            <button @click="agregarEvaluacionATema(tema)"
                                                class="block w-full text-left px-4 py-2 hover:bg-gray-100 text-gray-700"
                                                type="button">
                                                Evaluación
                                            </button>
                                        </div>
                                    </div>
                                    <!-- <button
                                        class="w-8 h-8 flex items-center justify-center text-red-600 hover:bg-red-50 rounded transition"
                                        title="Eliminar">
                                        <i class="fas fa-trash"></i>
                                    </button> -->
                                </div>
                            </div>
                            <ul class="p-2">
                                <template x-for="(item, indexItem) in tema.items" :key="item.id_item">
                                    <li
                                        class="flex justify-between items-center p-3 hover:bg-gray-50 rounded transition">
                                        <div class="flex items-center space-x-3">
                                            <i class="fas fa-grip-vertical text-gray-400 cursor-pointer"></i>
                                            <div class="flex-shrink-0 mt-0.5 ">
                                                <template x-if="item.tipo === 'clase'">
                                                    <i class="fas fa-play-circle text-gray-400 text-sm"></i>
                                                </template>
                                                <template x-if="item.tipo === 'evaluacion'">
                                                    <i class="fas fa-file-alt text-gray-400 text-sm"></i>
                                                </template>
                                                <template x-if="item.tipo === 'anuncio'">
                                                    <i class="fas fa-bullhorn text-gray-400 text-sm"></i>
                                                </template>
                                                <template x-if="item.tipo === 'asistencia'">
                                                    <i class="fas fa-user-check text-gray-400 text-sm"></i>
                                                </template>
                                            </div>
                                            <span class="text-gray-700" x-text="item.detalle.titulo"></span>
                                        </div>
                                        <div class="flex items-center space-x-2 transition">
                                            <button @click="editarItem(tema, item)"
                                                class="w-7 h-7 flex items-center justify-center text-gray-600 hover:bg-gray-200 rounded transition"
                                                title="Editar">
                                                <i class="fas fa-edit text-sm"></i>
                                            </button>
                                            <!-- <button
                                                class="w-7 h-7 flex items-center justify-center text-red-600 hover:bg-red-50 rounded transition"
                                                title="Eliminar">
                                                <i class="fas fa-trash text-sm"></i>
                                            </button> -->
                                            <button @click="cambiarEstadoItem(item)" :class="[
                                                    'w-7 h-7 flex items-center justify-center rounded transition',
                                                    item.detalle.activo == '1' ? 'text-green-600 hover:bg-green-50' : 'text-gray-400 hover:bg-gray-100'
                                                ]" :title="item.detalle.activo == '1' ? 'Desactivar' : 'Activar'"
                                                type="button">
                                                <i
                                                    :class="item.detalle.activo == '1' ? 'fas fa-toggle-on text-lg' : 'fas fa-toggle-off text-lg'"></i>
                                            </button>
                                        </div>
                                    </li>
                                </template>
                            </ul>
                        </li>
                    </template>

                </ul>
            </div>
            <div x-show="vistaActiva === 'personasInscritas'" x-cloak>
                <div class="grid grid-cols-1 gap-5 md:grid-cols-2">
                    <div class="">
                        <div class="bg-white rounded-lg shadow p-6 mb-4">
                            <h3 class="font-bold text-xl">Buscar personas</h3>
                            <input x-model="inputDisponibles" @input.debounce.500ms="buscarDisponibles()" type="text"
                                class="border w-full rounded-md p-2 outline-none my-2"
                                placeholder="Buscar por nombre, dni o cargo">

                            <div class="flex gap-4 mb-4">
                                <span>Filtrado por:</span>
                                <div class="flex gap-2">
                                    <button @click="seleccionarVistaParticipantes('todos')" :class="{
                                    'rounded-lg px-4 py-2 cursor-pointer': true,
                                    'bg-blue-900 text-white': vistaParticipantes === 'todos',
                                    'bg-gray-100': vistaParticipantes !== 'todos'
                                }">Todos</button>
                                    <button @click="seleccionarVistaParticipantes('proyecto')" :class="{
                                    'rounded-lg px-4 py-2 cursor-pointer': true,
                                    'bg-blue-900 text-white': vistaParticipantes === 'proyecto',
                                    'bg-gray-100': vistaParticipantes !== 'proyecto'
                                }">Por Proyecto</button>
                                    <button @click="seleccionarVistaParticipantes('cargo')" :class="{
                                    'rounded-lg px-4 py-2 cursor-pointer': true,
                                    'bg-blue-900 text-white': vistaParticipantes === 'cargo',
                                    'bg-gray-100': vistaParticipantes !== 'cargo'
                                }">Por Cargo</button>
                                </div>
                            </div>
                            <div x-show="vistaParticipantes === 'proyecto'">
                                <div class="flex items-center gap-4 mb-4">
                                    <span class="block font-semibold text-gray-700">Proyecto:</span>
                                    <div class="relative w-full">
                                        <select x-model="sltProyecto" @change="filtrarPorProyecto()"
                                            class="border rounded-lg w-full p-2 bg-white focus:ring-2 focus:ring-blue-900 focus:border-none outline-none shadow-sm transition">
                                            <option value="todos" class="text-gray-500">Seleccionar Proyecto</option>
                                            <template x-for="proyecto in proyectos" :key="proyecto">
                                                <option :value="proyecto" x-text="proyecto"></option>
                                            </template>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div x-show="vistaParticipantes === 'cargo'">
                                <div class="flex items-center gap-4 mb-4">
                                    <span class="font-semibold text-gray-700">Cargo:</span>
                                    <div class="relative w-full">
                                        <select x-model="sltCargo" @change="filtrarPorCargo()"
                                            class="border rounded-lg w-full p-2 bg-white focus:ring-2 focus:ring-blue-900 focus:border-none outline-none shadow-sm transition">
                                            <option value="todos" class="text-gray-500">Seleccionar Cargo</option>
                                            <template x-for="cargo in cargos" :key="cargo">
                                                <option :value="cargo" x-text="cargo"></option>
                                            </template>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <p><span x-text="personasEncontradas"></span> personas encontradas</p>
                        </div>
                        <div class="bg-white rounded-lg shadow p-6">
                            <div class="flex justify-between mb-4">
                                <h3 class="font-bold text-xl">Personas disponibles</h3>
                                <button type="button" @click="seleccionarTodosDisponibles()"
                                    class="text-blue-900 border-none hover:underline focus:outline-none">
                                    Seleccionar todos
                                </button>
                            </div>

                            <div class="max-h-96 overflow-y-auto space-y-3">
                                <template x-for="usuario in usuariosDisponibles" :key="usuario.dni">
                                    <div
                                        class="border border-1 border-gray-200 rounded-lg p-4 flex items-center gap-4 hover:bg-gray-50 hover:cursor-pointer transition">
                                        <input @change="seleccionarUsuario(usuario)" type="checkbox"
                                            class="accent-blue-600 h-5 w-5" :checked="usuario.seleccionado">
                                        <div class="flex-1">
                                            <h3 class="font-semibold text-sm text-gray-800"
                                                x-text="usuario.apellidos + ' ' + usuario.nombres"></h3>
                                            <p class="text-sm text-gray-500"
                                                x-text="'DNI: ' + usuario.dni + ' • Cargo: ' + usuario.dcargo"></p>
                                        </div>
                                        <button @click="inscribirUsuario(usuario)"
                                            class="bg-blue-900 text-white px-4 py-2 rounded hover:bg-blue-700 transition">
                                            Inscribir
                                        </button>
                                    </div>
                                </template>
                                <div x-show="usuariosDisponibles.length === 0" class="p-4 text-center text-gray-500">
                                    No se encontraron personas disponibles.
                                </div>
                            </div>
                            <hr class="my-3 border-gray-200">
                            <div x-show="seleccionados.size > 0" class="mt-4 w-full flex flex-col items-center">
                                <button @click="inscribirSeleccionados()"
                                    class="w-full bg-blue-900 hover:bg-blue-800 text-white font-semibold px-6 py-2 rounded-lg shadow transition">
                                    Inscribir Seleccionados
                                </button>
                            </div>
                        </div>
                    </div>
                    <div class="">
                        <div class="mb-4">
                            <div class="grid grid-cols-3 gap-4 items-center text-center">
                                <div class="bg-white rounded-lg shadow p-6 ">
                                    <span class="font-bold text-green-900 text-lg" x-text="totalInscritos"></span>
                                    <p class="text-md">Total inscritos</p>
                                </div>
                                <div class="bg-white rounded-lg shadow p-6 ">
                                    <span class="font-bold text-red-900 text-lg">0</span>
                                    <p class="text-md">Total terminados</p>
                                </div>
                                <div class="bg-white rounded-lg shadow p-6 ">
                                    <span class="font-bold text-yellow-900 text-lg">0</span>
                                    <p class="text-md">Total en proceso</p>
                                </div>
                            </div>
                        </div>
                        <div class="bg-white rounded-lg shadow p-6">
                            <div class="flex justify-between">
                                <h3 class="font-bold text-xl">Personas inscritas</h3>
                            </div>
                            <div>
                                <input x-model="inputInscritos" @input.debounce.500ms="buscarInscritos()" type="text"
                                    class="border w-full rounded-md p-2 outline-none my-2"
                                    placeholder="Buscar inscrito">
                            </div>
                            <div>
                                <div class="max-h-96 overflow-y-auto">
                                    <div x-show="usuariosInscritos.length === 0" class="p-4 text-center">
                                        No hay personas inscritas.
                                    </div>
                                    <div x-show="usuariosInscritos.length > 0">
                                        <template x-for="usuario in usuariosInscritos" :key="'INSCRITO-' + usuario.dni">
                                            <div
                                                class="border border-1 border-gray-200 rounded-lg p-4 mb-3 bg-gray-50 flex items-center justify-between hover:bg-blue-50 transition">
                                                <div class="flex items-center gap-4 flex-1">
                                                    <div
                                                        class="bg-blue-100 rounded-full h-12 w-12 flex items-center justify-center text-blue-700 font-bold text-lg">
                                                        <span
                                                            x-text="usuario.nombres.charAt(0) + usuario.apellidos.charAt(0)"></span>
                                                    </div>
                                                    <div>
                                                        <h3 class="font-semibold text-sm text-gray-800"
                                                            x-text="usuario.apellidos + ' ' + usuario.nombres"></h3>
                                                        <p class="text-sm text-gray-500"
                                                            x-text="'DNI: ' + usuario.dni + ' • Cargo: ' + usuario.dcargo">
                                                        </p>
                                                    </div>
                                                </div>
                                                <button @click="quitarUsuarioInscrito(usuario)"
                                                    class="bg-red-500 hover:bg-white hover:text-red-500 hover:border-red-400 border border-red-500 text-sm text-white px-4 py-2 rounded shadow transition">
                                                    Quitar
                                                </button>
                                            </div>
                                        </template>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="public/js/formulario_curso.js?v=<?= APP_VERSION ?>"></script>