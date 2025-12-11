<div x-data="nuevoCursoComponente()" class="container mx-auto px-4 py-8">
    <div x-show="cargando" x-cloak>
        <!-- Tabs skeleton -->
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
                class="bg-white text-green-700 border-2 border-green-700 px-6 py-2 rounded-lg shadow hover:bg-green-700 hover:text-white transition font-semibold flex items-center gap-2"
                :disabled="guardando">
                <span x-text="'Guardar Cambios'"></span>
            </button>
        </div>
        <div x-show="vistaActiva === 'descripcionGeneral'" x-cloak class="bg-white rounded-lg shadow p-6">
            <form class="grid grid-cols-1 md:grid-cols-3 gap-8 items-start">
                <div class="md:col-span-2 space-y-6">
                    <div>
                        <label class="block font-semibold mb-1" for="nombreCurso">Nombre del curso</label>
                        <input id="nombreCurso" type="text" x-model="curso.nombre"
                            class="border rounded-md w-full p-2 focus:ring-2 focus:ring-blue-900 focus:border-none outline-none"
                            placeholder="Nombre del curso">
                    </div>

                    <div>
                        <label class="block font-semibold mb-1" for="descripcionCurso">Descripción del curso</label>
                        <textarea id="descripcionCurso" x-model="curso.descripcion"
                            class="border rounded-md w-full p-2 min-h-[80px] focus:ring-2 focus:ring-blue-900 focus:border-none outline-none"
                            placeholder="Descripción del curso"></textarea>
                    </div>

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div>
                            <label class="block font-semibold mb-1" for="dificultadCurso">Dificultad</label>
                            <select id="dificultadCurso" x-model="curso.dificultad"
                                class="border rounded-md w-full p-2 focus:ring-2 focus:ring-blue-900 focus:border-none outline-none">
                                <option value="principiante">Principiante</option>
                                <option value="intermedio">Intermedio</option>
                                <option value="avanzado">Avanzado</option>
                            </select>
                        </div>
                        <div>
                            <label class="block font-semibold mb-1" for="duracionCurso">Duración (horas)</label>
                            <input id="duracionCurso" type="number" x-model="curso.duracion"
                                class="border rounded-md w-full p-2 focus:ring-2 focus:ring-blue-900 focus:border-none outline-none"
                                placeholder="Duración en horas" min="1">
                        </div>
                    </div>

                    <div>
                        <label class="block font-semibold mb-1" for="accesoCurso">Tipo de Acceso</label>
                        <select id="accesoCurso" x-model="curso.acceso_libre"
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
                    <input id="imagenCurso" type="file" accept="image/*" @change="curso.imagen = $event.target.files[0]"
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
        <div class="bg-white rounded-lg shadow p-6" x-show="vistaActiva === 'estructuraCurso'" x-cloak>
            <p>Estructura del curso</p>
            <ul id="main-list" class="space-y-3">
                <li class="bg-white border border-gray-200 rounded-lg overflow-hidden">
                    <div class="flex justify-between items-center p-4 bg-gray-50 border-b border-gray-200">
                        <div class="flex items-center space-x-3">
                            <i class="fas fa-grip-vertical text-gray-400 cursor-pointer"></i>
                            <span class="font-semibold text-gray-800">Tema: Introducción</span>
                        </div>
                        <div class="flex items-center space-x-2">
                            <button
                                class="w-8 h-8 flex items-center justify-center text-gray-600 hover:bg-gray-200 rounded transition"
                                title="Editar">
                                <i class="fas fa-edit"></i>
                            </button>
                            <button
                                class="w-8 h-8 flex items-center justify-center text-blue-600 hover:bg-blue-50 rounded transition"
                                title="Agregar Clase">
                                <i class="fas fa-plus"></i>
                            </button>
                            <button
                                class="w-8 h-8 flex items-center justify-center text-red-600 hover:bg-red-50 rounded transition"
                                title="Eliminar">
                                <i class="fas fa-trash"></i>
                            </button>
                        </div>
                    </div>
                    <ul class="p-2">
                        <li
                            class="text-gray-400 text-center py-6 text-sm border-2 border-dashed border-gray-200 rounded">
                            Arrastra clases aquí
                        </li>
                    </ul>
                </li>

                <li class="bg-white border border-gray-200 rounded-lg overflow-hidden">
                    <div class="flex justify-between items-center p-4 bg-gray-50 border-b border-gray-200">
                        <div class="flex items-center space-x-3">
                            <i class="fas fa-grip-vertical text-gray-400 cursor-pointer"></i>
                            <span class="font-semibold text-gray-800">Tema: Desarrollo</span>
                        </div>
                        <div class="flex items-center space-x-2">
                            <button
                                class="w-8 h-8 flex items-center justify-center text-gray-600 hover:bg-gray-200 rounded transition"
                                title="Editar">
                                <i class="fas fa-edit"></i>
                            </button>
                            <div class="relative">
                                <button id="btnOpcionesClase"
                                    class="w-8 h-8 flex items-center justify-center text-blue-600 hover:bg-blue-50 rounded transition"
                                    title="Agregar Clase" type="button">
                                    <i class="fas fa-plus"></i>
                                </button>
                                <div id="opcionesClaseDropdown"
                                    class="absolute right-0 mt-2 w-40 bg-white border border-gray-200 rounded shadow-lg z-10 hidden">
                                    <button id="btnAgregarClase"
                                        class="block w-full text-left px-4 py-2 hover:bg-gray-100 text-gray-700"
                                        type="button">
                                        Clase
                                    </button>
                                    <button id="btnAgregarAnuncio"
                                        class="block w-full text-left px-4 py-2 hover:bg-gray-100 text-gray-700"
                                        type="button">
                                        Anuncio
                                    </button>
                                    <button id="btnAgregarEvaluacion"
                                        class="block w-full text-left px-4 py-2 hover:bg-gray-100 text-gray-700"
                                        type="button">
                                        Evaluación
                                    </button>
                                </div>
                            </div>
                            <button
                                class="w-8 h-8 flex items-center justify-center text-red-600 hover:bg-red-50 rounded transition"
                                title="Eliminar">
                                <i class="fas fa-trash"></i>
                            </button>
                        </div>
                    </div>
                    <ul class="p-2">
                        <li class="flex justify-between items-center p-3 hover:bg-gray-50 rounded transition group">
                            <div class="flex items-center space-x-3">
                                <i class="fas fa-grip-vertical text-gray-300 group-hover:text-gray-400"></i>
                                <i class="fas fa-play-circle text-gray-400"></i>
                                <span class="text-gray-700">Fundamentos del Sistema</span>
                            </div>
                            <div class="flex items-center space-x-2 opacity-0 group-hover:opacity-100 transition">
                                <button
                                    class="w-7 h-7 flex items-center justify-center text-gray-600 hover:bg-gray-200 rounded transition"
                                    title="Editar">
                                    <i class="fas fa-edit text-sm"></i>
                                </button>
                                <button
                                    class="w-7 h-7 flex items-center justify-center text-red-600 hover:bg-red-50 rounded transition"
                                    title="Eliminar">
                                    <i class="fas fa-trash text-sm"></i>
                                </button>
                            </div>
                        </li>
                        <li class="flex justify-between items-center p-3 hover:bg-gray-50 rounded transition group">
                            <div class="flex items-center space-x-3">
                                <i class="fas fa-grip-vertical text-gray-300 group-hover:text-gray-400"></i>
                                <i class="fas fa-play-circle text-gray-400"></i>
                                <span class="text-gray-700">Práctica de los fundamentos</span>
                            </div>
                            <div class="flex items-center space-x-2 opacity-0 group-hover:opacity-100 transition">
                                <button id="btnEditarClase"
                                    class="w-7 h-7 flex items-center justify-center text-gray-600 hover:bg-gray-200 rounded transition"
                                    title="Editar">
                                    <i class="fas fa-edit text-sm"></i>
                                </button>
                                <button
                                    class="w-7 h-7 flex items-center justify-center text-red-600 hover:bg-red-50 rounded transition"
                                    title="Eliminar">
                                    <i class="fas fa-trash text-sm"></i>
                                </button>
                            </div>
                        </li>
                    </ul>
                </li>
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
                            <template x-for="usuario in usuariosDisponibles" :key="usuario.db">
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
                                class="border w-full rounded-md p-2 outline-none my-2" placeholder="Buscar inscrito">
                        </div>
                        <div>
                            <div class="max-h-96 overflow-y-auto">
                                <div x-show="usuariosInscritos.length === 0" class="p-4 text-center">
                                    No hay personas inscritas.
                                </div>
                                <div x-show="usuariosInscritos.length > 0">
                                    <template x-for="usuario in usuariosInscritos"
                                        :key="'INSCRITO-' + usuario.internal">
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

<script src="public/js/formulario_curso.js?v=<?= APP_VERSION ?>"></script>