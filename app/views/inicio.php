<div x-data="inicioComponente()">
    <div class="relative bg-gradient-to-r from-blue-900 to-blue-800 text-white">
        <div class="max-w-7xl mx-auto px-4 lg:px-8 relative z-10 grid grid-cols-1 md:grid-cols-2 gap-8 items-center">
            <div>
                <h1 class="text-4xl md:text-4xl lg:text-4xl font-extrabold mb-6 leading-tight">
                    Capacítate con SEPCON
                </h1>
                <p class="text-xl md:text-xl mb-8 text-blue-100 max-w-3xl leading-relaxed">
                    Con nuestros cursos diseñados para el crecimiento profesional dentro de la
                    empresa.
                </p>
                <div class="flex flex-col sm:flex-row gap-4">
                    <a href="#cursos"
                        class="bg-white text-blue-900 px-8 py-3 rounded-lg font-semibold hover:bg-gray-100 transition">
                        Curso Introductorio
                    </a>
                </div>
            </div>
            <div class="flex justify-center">
                <img src="public/img/profesor.png" alt="Profesor" class="h-96 object-contain">
            </div>
        </div>
    </div>

    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-16">
        <div class="text-center mb-12">
            <h2 class="text-3xl md:text-4xl font-bold text-gray-900 mb-4">Cursos Destacados</h2>
            <p class="text-gray-600 text-lg">Descubre nuestra selección de cursos más populares</p>
        </div>
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">
            <template x-for="(curso, index) in cursos" :key="curso.id_curso">
                <div
                    x-transition:enter="transition ease-out duration-500"
                    x-transition:enter-start="opacity-0 translate-y-4"
                    x-transition:enter-end="opacity-100 translate-y-0"
                    :style="'transition-delay: ' + (index * 100) + 'ms'"
                    class="bg-white rounded-xl shadow-lg hover:shadow-2xl transition-all duration-300 flex flex-col overflow-hidden transform hover:-translate-y-1">
                    <img src="public/img/curso.jpg" alt="" class="h-48 w-full object-cover">
                    <div class="p-6 flex-1 flex flex-col">
                        <h3 class="text-xl font-bold text-gray-900 mb-3" x-text="curso.nombre"></h3>
                        <p class="text-gray-600 text-sm mb-4 flex-1 line-clamp-3" x-text="curso.descripcion">
                        </p>
                        <div class="mt-auto pt-4 border-t border-gray-100 flex items-center justify-end">
                            <a :href="'/capacitaciones/curso?id_curso=' + curso.id_curso"
                                class="bg-blue-900 text-white px-6 py-2.5 rounded-lg font-medium border hover:bg-white hover:border-blue-900 hover:text-blue-900 transition">
                                Ver Curso
                            </a>
                        </div>
                    </div>
                </div>
            </template>
        </div>
    </div>

</div>
<script src="public/js/inicio.js"></script>