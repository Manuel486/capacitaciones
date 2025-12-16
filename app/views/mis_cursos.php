<div x-data="misCursosComponente()">
    <div class="container mx-auto px-4 py-8">
        <div class="grid grid-cols-1 lg:grid-cols-12 gap-6">

            <div class="lg:col-span-3">
                <div class="bg-white rounded-lg shadow p-6 sticky top-4">
                    <div class="flex justify-center mb-4">
                        <div class="w-32 h-32 rounded-full overflow-hidden border-2 border-blue-900">
                            <template x-if="usuarioLogueado">
                                <img :src="usuarioLogueado.foto ? 'https://rrhhperu.sepcon.net/postulanterrhh/documentos/jpg/' + usuarioLogueado.foto + '.jpg' : 'https://static.vecteezy.com/system/resources/previews/006/090/662/non_2x/user-icon-or-logo-isolated-sign-symbol-illustration-free-vector.jpg'"
                                    alt="" class="w-full h-full object-cover">
                            </template>
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
                            <p class="text-xs text-gray-600 uppercase">Cursos Inscritos</p>
                            <p class="text-2xl font-bold text-gray-900" x-text="cursosInscritos"></p>
                        </div>

                        <div class="border-l-4 border-green-600 pl-3">
                            <p class="text-xs text-gray-600 uppercase">Cursos Completados</p>
                            <p class="text-2xl font-bold text-gray-900" x-text="cursosCompletados"></p>
                        </div>

                        <div class="border-l-4 border-yellow-500 pl-3">
                            <p class="text-xs text-gray-600 uppercase">En Proceso</p>
                            <p class="text-2xl font-bold text-gray-900" x-text="cursosEnProceso"></p>
                        </div>

                        <div class="border-l-4 border-purple-600 pl-3">
                            <p class="text-xs text-gray-600 uppercase">Total Certificados</p>
                            <p class="text-2xl font-bold text-gray-900" x-text="totalCertificados"></p>
                        </div>
                    </div>

                    <div class="mt-6 pt-6 border-t">
                        <p class="text-sm font-semibold text-gray-700 mb-2">Progreso General</p>
                        <div class="w-full bg-gray-200 rounded-full h-3">
                            <div class="bg-blue-900 h-3 rounded-full" :style="'width:' + progresoGeneral + '%'"></div>
                        </div>
                        <p class="text-right text-sm font-bold text-gray-700 mt-1" x-text="progresoGeneral + '%'"></p>
                    </div>
                </div>
            </div>

            <div class="lg:col-span-9">
                <div class="bg-white rounded-lg shadow p-6" x-cloak>
                    <div class="flex flex-col md:flex-row gap-1 mb-6 font-semibold">
                        <span @click="selectPestania('todos')" :class="{
                                'cursor-pointer px-4 py-2 rounded-t-lg font-semibold transition': true,
                                'bg-blue-900 text-white shadow': pestaniaSeleccionada === 'todos',
                                'bg-gray-100 text-gray-700 hover:bg-blue-100': pestaniaSeleccionada !== 'todos'
                            }">
                            Todos los cursos
                        </span>
                        <span @click="selectPestania('obligatorios')" :class="{
                                'cursor-pointer px-4 py-2 rounded-t-lg font-semibold transition': true,
                                'bg-blue-900 text-white shadow': pestaniaSeleccionada === 'obligatorios',
                                'bg-gray-100 text-gray-700 hover:bg-blue-100': pestaniaSeleccionada !== 'obligatorios'
                            }">
                            Cursos obligatorios
                        </span>
                        <span @click="selectPestania('proceso')" :class="{
                                'cursor-pointer px-4 py-2 rounded-t-lg font-semibold transition': true,
                                'bg-blue-900 text-white shadow': pestaniaSeleccionada === 'proceso',
                                'bg-gray-100 text-gray-700 hover:bg-blue-100': pestaniaSeleccionada !== 'proceso'
                            }">
                            Cursos en proceso
                        </span>
                        <span @click="selectPestania('completado')" :class="{
                                'cursor-pointer px-4 py-2 rounded-t-lg font-semibold transition': true,
                                'bg-blue-900 text-white shadow': pestaniaSeleccionada === 'completado',
                                'bg-gray-100 text-gray-700 hover:bg-blue-100': pestaniaSeleccionada !== 'completado'
                            }">
                            Cursos Completados
                        </span>
                    </div>
                    <div class="mb-4">
                        <input x-model="inputCurso" @input.debounce.500ms="buscarCurso()" type="text"
                            placeholder="Ingrese el nombre del curso"
                            class="hidden border rounded-md w-full py-1 px-2 text-sm outline-none focus:ring-2 focus:ring-blue-900 focus:border-transparent transition">
                    </div>
                    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-x-2 gap-y-4">
                        <template x-if="cargando">
                            <template x-for="n in 4" :key="n">
                                <div
                                    class="bg-white rounded-lg h-full shadow-md hover:shadow-lg transition-all duration-300 flex flex-col overflow-hidden transform hover:-translate-y-1">
                                    <div class="flex justify-center items-center h-24 w-full">
                                        <div
                                            class="animate-spin rounded-full h-8 w-8 border-t-2 border-b-2 border-blue-900">
                                        </div>
                                    </div>
                                    <div class="p-2 flex-1 flex flex-col">
                                        <div class="h-2 bg-gray-400 rounded animate-pulse mb-4"></div>
                                        <div class="h-5 bg-gray-400 rounded animate-pulse mb-4"></div>
                                    </div>
                                </div>
                            </template>
                        </template>
                        <template x-if="!cargando">
                            <template x-for="(curso, index) in cursos" :key="curso.id_curso">
                                <div class="">
                                    <div
                                        class="bg-white rounded-lg h-full shadow-md hover:shadow-lg transition-all duration-300 flex flex-col overflow-hidden hover:shadow-4xl">
                                        <img :src="curso.imagen ? 'public/assets/portadas/' + curso.imagen : 'public/assets/portadas/plantilla.jpg'"
                                            alt="Imagen del curso" class="h-24 object-cover">
                                        <div class="p-2 flex-1 flex flex-col">
                                            <h3 class="text-xs font-bold text-gray-900 mb-1 h-8"
                                                x-text="curso.nombre.length > 50 ? curso.nombre.substring(0, 50) + '...' : curso.nombre">
                                            </h3>
                                            <p class="text-gray-600 text-xs mb-4 h-10"
                                                x-text="curso.descripcion.length > 80 ? curso.descripcion.substring(0, 80) + '...' : curso.descripcion">
                                            </p>
                                            <div class="flex gap-2 items-center">
                                                <div class="w-full bg-gray-200 rounded-full h-2">
                                                    <div class="bg-blue-600 h-2 rounded-full"
                                                        :style="'width:' + curso.progreso + '%'"></div>
                                                </div>
                                                <span class="font-bold text-gray-700 text-xs"
                                                    x-text="curso.progreso + '%'"></span>
                                            </div>
                                            <div class="flex justify-between items-center mt-3">
                                                <a :href="'tomar_curso?id_curso=' + curso.id_curso"
                                                    class="px-3 py-1 hover:bg-blue-900 border border-blue-900 bg-white hover:text-white rounded transition text-xs font-semibold shadow-sm">
                                                    Continuar
                                                </a>
                                                <a x-show="curso.progreso == 100"
                                                    :href="'api/obtener_certificado?id_curso=' + curso.id_curso"
                                                    target="_blank"
                                                    class="underline flex items-center gap-1 text-gray-600 hover:text-blue-700 text-xs font-medium cursor-pointer">
                                                    <i class="fas fa-award text-yellow-400"></i>
                                                    Certificado
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </template>
                        </template>


                    </div>
                    <div x-show="!cargando && cursos.length === 0" class="text-center py-12 w-full" x-cloak>
                        <i class="fas fa-book-open text-6xl text-gray-300 mb-4"></i>
                        <p class="text-gray-500 text-lg mb-4">No tienes nigún curso</p>
                    </div>
                </div>
            </div>


        </div>
    </div>
</div>

<script src="public/js/mis_cursos.js?v=<?= APP_VERSION ?>"></script>