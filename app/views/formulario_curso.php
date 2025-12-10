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
        <div class="flex justify-between mb-4">
            <ul class="flex gap-4">
                <li @click="activarVista('descripcionGeneral')">Descripción General</li>
                <li @click="activarVista('estructuraCurso')">Estructura del curso</li>
                <li @click="curso.acceso_libre == 0 ? activarVista('personasInscritas') : null"
                    :class="{'opacity-50 pointer-events-none': curso.acceso_libre == 1}">
                    Inscritos
                </li>
            </ul>
            <button type="button" @click="guardarCurso()" class="border">Guardar Curso</button>
        </div>
        <div x-show="vistaActiva === 'descripcionGeneral'" x-cloak class="bg-white rounded-lg shadow p-6">
            <form action="">
                <label for="">Nombre del curso</label>
                <input type="text" x-model="curso.nombre" class="border" placeholder="Nombre del curso">

                <label for="">Descripcion del curso</label>
                <textarea x-model="curso.descripcion" class="border"></textarea>

                <label for="">Imagen referencial del curso</label>
                <input type="file" accept="image/*" @change="curso.imagen = $event.target.files[0]" class="border">

                <template x-cloak x-if="curso.imagen && typeof curso.imagen === 'string'">
                    <img :src="'public/assets/portadas/' + curso.imagen" alt="Imagen del curso"
                        class="h-24 object-cover mt-2">
                </template>

                <template x-cloak x-if="curso.imagen && typeof curso.imagen === 'object'">
                    <img :src="URL.createObjectURL(curso.imagen)" alt="Preview imagen" class="h-24 object-cover mt-2">
                </template>

                <template x-cloak x-if="!curso.imagen">
                    <img src="public/assets/portadas/plantilla.jpg" alt="Imagen del curso"
                        class="h-24 object-cover mt-2">
                </template>

                <label for="">Dificultad</label>
                <select x-model="curso.dificultad" class="border">
                    <option value="principiante">Principiante</option>
                    <option value="intermedio">Intermedio</option>
                    <option value="avanzado">Avanzado</option>
                </select>

                <label for="">Duración (horas)</label>
                <input type="number" x-model="curso.duracion" class="border" placeholder="Duración en horas">

                <label for="">Tipo de Acceso</label>
                <select x-model="curso.acceso_libre" class="border">
                    <option value="1">Acceso Libre</option>
                    <option value="0">Acceso Cerrado</option>
                </select>
                <p class="text-xs text-gray-500 mt-1" x-show="curso.acceso_libre == 1">
                    Nota: Acceso libre permite que cualquier persona pueda realizar el curso.
                </p>

            </form>
        </div>
        <div class="bg-white rounded-lg shadow p-6" x-show="vistaActiva === 'estructuraCurso'" x-cloak>
            <p>Estructura del curso</p>
        </div>
        <div x-show="vistaActiva === 'personasInscritas'" x-cloak>
            <div class="grid grid-cols-1 gap-5 md:grid-cols-2">
                <div class="">
                    <div class="bg-white rounded-lg shadow p-6 mb-4">
                        <h2>Buscar personas</h2>
                        <input x-model="inputDisponibles" @input.debounce.500ms="buscarDisponibles()" type="text"
                            class="border w-full" placeholder="Buscar por nombre, dni o cargo">

                        <div class="flex gap-4 mb-4">
                            <span>Filtrado por:</span>
                            <div class="flex gap-2">
                                <button @click="seleccionarVistaParticipantes('todos')" class="border">Todos</button>
                                <button @click="seleccionarVistaParticipantes('proyecto')" class="border">Por
                                    Proyecto</button>
                                <button @click="seleccionarVistaParticipantes('cargo')" class="border">Por
                                    Cargo</button>
                            </div>
                        </div>

                        <div x-show="vistaParticipantes === 'proyecto'">
                            <div class="flex gap-4 mb-4">
                                <span class="block">Proyecto:</span>
                                <select x-model="sltProyecto" @change="filtrarPorProyecto()">
                                    <option value="todos">Seleccionar Proyecto</option>
                                    <template x-for="proyecto in proyectos" :key="proyecto">
                                        <option :value="proyecto" x-text="proyecto"></option>
                                    </template>
                                </select>
                            </div>
                        </div>

                        <div x-show="vistaParticipantes === 'cargo'">
                            <div class="flex gap-4 mb-4">
                                <span>Cargo:</span>
                                <select x-model="sltCargo" @change="filtrarPorCargo()">
                                    <option value="todos">Seleccionar Cargo</option>
                                    <template x-for="cargo in cargos" :key="cargo">
                                        <option :value="cargo" x-text="cargo"></option>
                                    </template>
                                </select>
                            </div>
                        </div>

                        <p><span x-text="personasEncontradas"></span> personas encontradas</p>
                    </div>
                    <div class="bg-white rounded-lg shadow p-6">
                        <div class="flex justify-between">
                            <h2>Personas disponibles</h2>
                            <button @click="seleccionarTodosDisponibles()">Seleccionar todos</button>
                        </div>

                        <div class="max-h-96 overflow-y-auto">
                            <template x-for="usuario in usuariosDisponibles" :key="usuario.internal">
                                <div class="border p-4 mb-2">
                                    <div class="flex gap-2 items-center">
                                        <input @change="seleccionarUsuario(usuario)" type="checkbox" class="mr-2"
                                            :checked="usuario.seleccionado">
                                        <div class="flex-1">
                                            <h3 x-text="usuario.apellidos + ' ' + usuario.nombres"></h3>
                                            <p x-text="'DNI: ' + usuario.dni + ' - Cargo: ' + usuario.dcargo"></p>
                                        </div>
                                        <div class="">
                                            <button @click="inscribirUsuario(usuario)" class="border">Inscribir</button>
                                        </div>
                                    </div>
                                </div>
                            </template>
                        </div>

                        <div x-show="seleccionados.size > 0" class="mt-4 w-full border p-3 text-center">
                            <button @click="inscribirSeleccionados()">Inscribir Seleccionados</button>
                        </div>
                    </div>
                </div>
                <div class="">
                    <div class="mb-4">
                        <div class="grid grid-cols-3 gap-4 items-center text-center">
                            <div class="bg-white rounded-lg shadow p-6 ">
                                <span x-text="totalInscritos"></span>
                                <p>Total inscritos</p>
                            </div>
                            <div class="bg-white rounded-lg shadow p-6 ">
                                <span>0</span>
                                <p>Total terminados</p>
                            </div>
                            <div class="bg-white rounded-lg shadow p-6 ">
                                <span>0</span>
                                <p>Total en proceso</p>
                            </div>
                        </div>
                    </div>
                    <div class="bg-white rounded-lg shadow p-6">
                        <div class="flex justify-between">
                            <h3>Personas inscritas</h3>
                        </div>
                        <div>
                            <input x-model="inputInscritos" @input.debounce.500ms="buscarInscritos()" type="text"
                                class="border w-full mb-4" placeholder="Buscar inscrito">
                        </div>
                        <div>
                            <div class="max-h-96 overflow-y-auto">
                                <div x-show="usuariosInscritos.length === 0" class="p-4 text-center">
                                    No hay personas inscritas.
                                </div>
                                <div x-show="usuariosInscritos.length > 0">
                                    <template x-for="usuario in usuariosInscritos"
                                        :key="'INSCRITO-' + usuario.internal">
                                        <div class="border p-4 mb-2">
                                            <div class="flex gap-2 items-center">
                                                <div class="flex-1">
                                                    <div class="flex items-center gap-2">
                                                        <div class="flex-1">
                                                            <h3 x-text="usuario.apellidos + ' ' + usuario.nombres"></h3>
                                                            <p
                                                                x-text="'DNI: ' + usuario.dni + ' - Cargo: ' + usuario.dcargo">
                                                            </p>
                                                        </div>
                                                        <div>
                                                            <button
                                                                @click="quitarUsuarioInscrito(usuario)">Eliminar</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
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