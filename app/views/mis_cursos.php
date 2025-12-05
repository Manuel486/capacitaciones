<div x-data="misCursosComponente()">
    <div class="container mx-auto px-4 py-8">
        <div class="">
            <div>

                <div class="bg-white rounded-lg shadow p-6">
                    <div class="flex gap-8 mb-6 font-semibold">
                        <span 
                            @click="selectPestania('todos')" 
                            :class="[
                                'cursor-pointer transition-colors duration-500',
                                pestaniaSeleccionada == 'todos' ? 'border-b-4 border-blue-900 pb-1 text-blue-900' : ''
                            ]"
                        >
                            Todos los cursos
                        </span>
                        <span 
                            @click="selectPestania('obligatorios')"  
                            :class="[
                                'cursor-pointer transition-colors duration-500',
                                pestaniaSeleccionada == 'obligatorios' ? 'border-b-4 border-blue-900 pb-1 text-blue-900' : ''
                            ]"
                        >
                            Cursos obligatorios
                        </span>
                        <span 
                            @click="selectPestania('proceso')"
                            :class="[
                                'cursor-pointer transition-colors duration-500',
                                pestaniaSeleccionada == 'proceso' ? 'border-b-4 border-blue-900 pb-1 text-blue-900' : ''
                            ]"
                        >
                            Cursos en proceso
                        </span>
                        <span 
                            @click="selectPestania('completado')"
                            :class="[
                                'cursor-pointer transition-colors duration-500',
                                pestaniaSeleccionada == 'completado' ? 'border-b-4 border-blue-900 pb-1 text-blue-900' : ''
                            ]"
                        >
                            Cursos Completados
                        </span>
                    </div>
                    <div class="mb-4">
                        <input x-model="inputCurso" @input.debounce.500ms="buscarCurso()" type="text"
                            placeholder="Ingrese el nombre del curso"
                            class="hidden border rounded-md w-full py-1 px-2 text-sm outline-none focus:ring-2 focus:ring-blue-900 focus:border-transparent transition">
                    </div>
                    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8">
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
                                        <img :src="curso.imagen || 'public/img/curso.jpg'" alt="Imagen del curso"
                                            class="h-24 w-full object-cover">
                                        <div class="p-2 flex-1 flex flex-col">
                                            <h3 class="text-xs font-bold text-gray-900 mb-1" x-text="curso.nombre"></h3>
                                            <p class="text-gray-600 text-xs mb-1 h-10"
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
                                                    class="px-3 py-1 bg-blue-900 border hover:border-blue-900 hover:text-blue-900 hover:bg-white text-white rounded transition text-xs font-semibold shadow-sm">
                                                    Continuar
                                                </a>
                                                <a  x-show="curso.progreso == 100"
                                                    href="public/certificados/certificado.pdf" target="_blank"
                                                    class="flex items-center gap-1 text-gray-600 hover:text-blue-700 text-xs font-medium cursor-pointer">
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
                </div>
            </div>


        </div>
    </div>
</div>

<script src="public/js/mis_cursos.js"></script>