<div x-data="gestionarCursosComponente()">
    <div class="container mx-auto px-4 py-8">
        <div class="grid grid-cols-1 lg:grid-cols-12 gap-6">
            <div class="lg:col-span-3">
                <div class="bg-white rounded-lg shadow p-6 sticky top-4">
                    <div class="flex justify-center mb-4">
                        <div
                            class="w-32 h-32 rounded-full overflow-hidden border-2 border-blue-900 bg-blue-100 flex items-center justify-center">
                            <i class="fas fa-chalkboard-teacher text-5xl text-blue-900"></i>
                        </div>
                    </div>

                    <div class="text-center mb-6">
                        <template x-if="usuarioLogueado">
                            <div>
                                <h2 class="text-md font-bold text-gray-900 mb-1" x-text="usuarioLogueado.nombres"></h2>
                                <p class="text-sm text-gray-600" x-text="usuarioLogueado.dni"></p>
                            </div>
                        </template>
                    </div>

                    <div class="space-y-4">
                        <div class="border-l-4 border-blue-900 pl-3">
                            <p class="text-xs text-gray-600 uppercase">Cursos Creados</p>
                            <p class="text-2xl font-bold text-gray-900" x-text="totalCursos"></p>
                        </div>

                        <div class="border-l-4 border-green-600 pl-3">
                            <p class="text-xs text-gray-600 uppercase">Cursos Activos</p>
                            <p class="text-2xl font-bold text-gray-900" x-text="cursosActivos"></p>
                        </div>

                        <div class="border-l-4 border-yellow-500 pl-3">
                            <p class="text-xs text-gray-600 uppercase">Total Estudiantes</p>
                            <p class="text-2xl font-bold text-gray-900" x-text="totalEstudiantes"></p>
                        </div>

                        <!-- <div class="border-l-4 border-purple-600 pl-3">
                            <p class="text-xs text-gray-600 uppercase">Valoración Promedio</p>
                            <p class="text-2xl font-bold text-gray-900" x-text="valoracionPromedio"></p>
                        </div> -->
                    </div>

                    <div class="mt-6 pt-6 border-t">
                        <a href="formulario_curso"
                            class="w-full block text-center bg-blue-900 text-white px-4 py-3 rounded-lg font-semibold hover:bg-blue-800 transition">
                            <i class="fas fa-plus mr-2"></i>Crear Nuevo Curso
                        </a>
                    </div>
                </div>
            </div>

            <div class="lg:col-span-9">
                <div class="bg-white rounded-lg shadow p-6">
                    <div class="flex flex-col md:flex-row gap-4 justify-between items-center mb-6">
                        <h2 class="text-2xl font-bold text-gray-900">Mis Cursos Creados</h2>
                        <div class="flex gap-2 items-center">
                            <input x-model="inputCurso" @input.debounce.500ms="buscarCurso()" type="text"
                                placeholder="Buscar curso..."
                                class="border rounded-lg px-4 py-2 text-sm outline-none focus:ring-2 focus:ring-blue-900 focus:border-transparent transition">
                        </div>
                    </div>

                    <div class="grid grid-cols-1 sm:grid-cols-1 gap-4">
                        <template x-if="cargando">
                            <template x-for="n in 3" :key="n">
                                <div class="bg-white rounded-lg h-full shadow-md flex flex-col overflow-hidden">
                                    <div class="flex justify-center items-center h-32 w-full bg-gray-200">
                                        <div
                                            class="animate-spin rounded-full h-8 w-8 border-t-2 border-b-2 border-blue-900">
                                        </div>
                                    </div>
                                    <div class="p-4 flex-1 flex flex-col">
                                        <div class="h-4 bg-gray-300 rounded animate-pulse mb-3"></div>
                                        <div class="h-3 bg-gray-300 rounded animate-pulse mb-2"></div>
                                        <div class="h-3 bg-gray-300 rounded animate-pulse mb-4"></div>
                                    </div>
                                </div>
                            </template>
                        </template>

                        <template x-if="!cargando">
                            <template x-for="(curso, index) in cursos" :key="curso.id_curso">
                                <div
                                    class="flex flex-col sm:flex-row items-stretch bg-white rounded-lg shadow-md hover:shadow-lg transition-all duration-300 px-4 py-3 mb-2 border border-gray-100">
                                    <div
                                        class="flex-shrink-0 w-full sm:w-40 h-32 sm:h-20 rounded overflow-hidden mb-3 sm:mb-0 sm:mr-4">
                                        <img :src="curso.imagen ? 'public/assets/portadas/' + curso.imagen : 'public/assets/portadas/plantilla.jpg'"
                                            alt="Imagen del curso" class="w-full h-full object-cover">
                                    </div>
                                    <div class="flex-1 min-w-0">
                                        <div class="flex items-center gap-2 mb-1">
                                            <h3 class="text-base font-semibold text-gray-900 truncate"
                                                x-text="curso.nombre"></h3>
                                        </div>
                                        <p class="text-gray-600 text-xs truncate mb-4"
                                            x-text="curso.descripcion && curso.descripcion.length > 80 ? curso.descripcion.substring(0, 80) + '...' : curso.descripcion">
                                        </p>
                                        <div class="flex flex-wrap items-center gap-4 text-md text-gray-500">
                                            <div class="flex items-center gap-1">
                                                <i class="fas fa-users"></i>
                                                <span x-text="curso.inscritos || 0"></span>
                                            </div>
                                            <div class="flex items-center gap-1">
                                                <template x-for="star in 5" :key="star">
                                                    <i class="fas fa-star text-lg"
                                                        :class="star <= curso.valoracion_promedio ? 'text-yellow-400' : 'text-gray-300'"></i>
                                                </template>
                                                <span class="ml-2 text-sm font-medium text-gray-600"
                                                    x-text="curso.valoracion_promedio + '/5'"></span>
                                            </div>
                                            <div class="flex items-center gap-1">
                                                <i class="fas fa-clock"></i>
                                                <span x-text="curso.duracion ? curso.duracion + 'h' : 'N/A'"></span>
                                            </div>
                                        </div>
                                        <div class="flex flex-wrap items-center gap-4 text-md text-gray-500 mt-4">
                                            <div class="flex items-center gap-1">
                                                <i class="fas fa-calendar-alt"></i>
                                                <span class="text-sm text-gray-600"
                                                    x-text="curso.fecha_publicacion ? 'Publicado: ' + new Date(curso.fecha_publicacion).toLocaleString() : 'No publicado'"></span>
                                            </div>
                                            <div class="flex items-center gap-1">
                                                <i class="fas fa-calendar-times"></i>
                                                <span class="text-sm text-gray-600"
                                                    x-text="curso.fecha_cierre ? 'Cierra: ' + new Date(curso.fecha_cierre).toLocaleString() : 'Sin cierre'"></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div
                                        class="flex flex-row sm:flex-col gap-2 mt-3 sm:mt-0 sm:ml-4 items-end sm:items-end">
                                        <span :class="{
                                                'px-2 py-0.5 rounded-full text-xs font-semibold': true,
                                                'bg-green-500 text-white': curso.activo == 1,
                                                'bg-gray-500 text-white': curso.activo != 1
                                            }" x-text="curso.activo == 1 ? 'Activo' : 'Inactivo'">
                                        </span>
                                        <a :href="'formulario_curso?id_curso=' + curso.id_curso"
                                            class="cursor-pointer text-center bg-blue-900 text-white px-3 py-1 rounded-lg w-full sm:w-25 text-xs font-semibold hover:bg-blue-800 transition">
                                            <i class="fas fa-edit mr-1"></i>Editar
                                        </a>
                                        <a :href="'curso?id_curso=' + curso.id_curso"
                                            class="cursor-pointer text-center border border-blue-900 text-blue-900 px-3 py-1 w-full sm:w-25 rounded-lg text-xs font-semibold hover:bg-blue-900 hover:text-white transition">
                                            <i class="fas fa-eye mr-1"></i>Ver
                                        </a>
                                    </div>
                                </div>
                            </template>
                        </template>
                    </div>

                    <div x-show="!cargando && cursos.length === 0" class="text-center py-12" x-cloak>
                        <i class="fas fa-book-open text-6xl text-gray-300 mb-4"></i>
                        <p class="text-gray-500 text-lg mb-4">Aún no has creado ningún curso</p>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

<script src="public/js/gestionar_cursos.js?v=<?= APP_VERSION ?>"></script>