<div x-data="cursosComponente()">
    <div class="container mx-auto px-4 py-8">
        <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">

            <div class="lg:col-span-1">
                <div class="sticky top-4">
                    <div class="bg-white rounded-lg shadow p-6">
                        <h4 class="text-blue-900 mb-2 font-medium">Buscar curso</h4>
                        <input x-model="inputCurso" @input.debounce.500ms="buscarCurso()" type="text"
                            placeholder="Ingrese el nombre del curso"
                            class="border rounded-md w-full py-1 px-2 text-sm outline-none focus:ring-2 focus:ring-blue-900 focus:border-transparent transition">
                    </div>
                </div>
            </div>

            <div class="lg:col-span-2">
                <div class="bg-white rounded-lg shadow p-6">
                    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">
                        <template x-if="cargando">
                            <template x-for="n in 6" :key="n">
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
                                <a class="cursor-pointer h-60"
                                    :href="'/capacitaciones/curso?id_curso=' + curso.id_curso"
                                    x-transition:enter="transition ease-out duration-500"
                                    x-transition:enter-start="opacity-0 translate-y-4"
                                    x-transition:enter-end="opacity-100 translate-y-0"
                                    :style="'transition-delay: ' + (index * 100) + 'ms'">
                                    <div
                                        class="bg-white rounded-lg h-full shadow-md hover:shadow-lg transition-all duration-300 flex flex-col overflow-hidden transform hover:-translate-y-1">
                                        <img :src="curso.imagen ? 'public/assets/portadas/' + curso.imagen : 'public/assets/portadas/plantilla.jpg'"
                                            alt="Imagen del curso" class="h-24 object-cover">
                                        <div class="p-2 flex-1 flex flex-col">
                                            <h3 class="text-xs font-bold text-gray-900 mb-1" x-text="curso.nombre.length > 60 ? curso.nombre.substring(0, 60) + '...' : curso.nombre"></h3>
                                            <p class="text-gray-600 text-xs mb-1 max-h-50 flex-1 line-clamp-2"
                                                x-text="curso.descripcion.length > 80 ? curso.descripcion.substring(0, 80) + '...' : curso.descripcion">
                                            </p>
                                            <div class="flex justify-end items-center mt-2">
                                                <span x-show="curso.tiene_certificacion == 1"
                                                    class="flex items-center gap-1 text-gray-600 text-sm font-medium ">
                                                    <i class="fas fa-award text-yellow-400"></i>
                                                    Incluye certificado
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </template>
                        </template>
                    </div>
                </div>
            </div>


        </div>
    </div>
</div>

<script src="public/js/cursos.js?v=<?= APP_VERSION ?>"></script>