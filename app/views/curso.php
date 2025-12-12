<div x-data="cursoDetalleComponente()">
    <div x-show="modalComentario" x-cloak class="fixed inset-0 flex items-center justify-center z-100 p-4"
        style="background: rgba(0,0,0,0.5);">
        <div class="bg-white rounded-lg shadow-lg max-w-lg w-full p-4 sm:p-6 relative max-h-[90vh] overflow-y-auto">
            <button @click="cerrarModalValoracion()" class="absolute top-3 right-3 text-gray-400 hover:text-gray-600">
                <i class="fas fa-times text-xl"></i>
            </button>
            <h2 class="text-xl font-bold mb-4 text-gray-800">Comentario</h2>
            <form class="space-y-4">
                <div class="flex gap-4">
                    <label class="block text-gray-700 mb-2 font-bold">Valoración</label>
                    <div class="flex items-center space-x-1">
                        <template x-for="star in 5" :key="star">
                            <button type="button" @click="valoracion = star" @mouseover="hoverValoracion = star"
                                @mouseleave="hoverValoracion = 0" class="focus:outline-none">
                                <i class="fas" :class="[
                                        (hoverValoracion || valoracion) >= star ? 'fa-star text-yellow-400' : 'fa-star text-gray-300',
                                        'text-2xl'
                                    ]"></i>
                            </button>
                        </template>
                        <span class="ml-2 text-gray-600" x-text="valoracion"></span>
                    </div>
                </div>
                <div>
                    <textarea x-model="comentario"
                        class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring focus:border-blue-400"
                        rows="3" placeholder="Comentario"></textarea>
                </div>

                <div class="flex justify-end space-x-2 pt-2">
                    <button @click="cerrarModalValoracion()" type="button"
                        class="px-4 py-2 bg-gray-200 text-gray-700 rounded hover:bg-gray-300 transition">
                        Cancelar
                    </button>
                    <button type="button" @click="guardarValoracion()"
                        class="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700 transition">
                        Guardar
                    </button>
                </div>
            </form>
        </div>
    </div>

    <div class="container mx-auto px-4 py-8">
        <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
            <div class="lg:col-span-2">
                <div class="bg-gray-900 text-white">
                    <div class="container mx-auto px-4 py-8">
                        <template x-if="cargando">
                            <div>
                                <h1 class="h-6 bg-gray-700 rounded w-64 animate-pulse mb-4"></h1>
                                <div class="h-6 w-100 bg-gray-700 rounded w-64 animate-pulse mb-4"></div>
                            </div>
                        </template>
                        <template x-if="!cargando && curso">
                            <div>
                                <h1 class="text-3xl font-bold mb-4" x-text="curso.nombre"></h1>
                                <div class="flex items-center gap-6 mb-4">
                                    <div class="flex items-center gap-1 mb-3">
                                        <template x-for="star in 5" :key="star">
                                            <i class="fas fa-star text-lg"
                                                :class="star <= Math.round(curso.valoracion_promedio) ? 'text-yellow-400' : 'text-gray-300'"></i>
                                        </template>
                                        <span class="ml-2 text-sm font-medium text-gray-600"
                                            x-text="(curso.valoracion_promedio ? curso.valoracion_promedio.toFixed(1) : '0') + '/5'"></span>
                                    </div>
                                </div>
                                <div>
                                    <span class="text-gray-400">Creado por</span>
                                    <span x-text="curso.instructor"></span>
                                </div>
                            </div>
                        </template>
                    </div>
                </div>
                <div>
                    <div class="border-b border-gray-200 mb-6">
                        <nav class="-mb-px flex space-x-8" aria-label="Tabs">
                            <button @click="seleccionarPestana('contenido')"
                                :class="pestaniaActiva === 'contenido' 
                                        ? 'whitespace-nowrap py-4 px-1 border-b-2 font-medium text-sm text-blue-600 border-blue-600' 
                                        : 'whitespace-nowrap py-4 px-1 border-b-2 font-medium text-sm text-gray-500 hover:text-gray-700 hover:border-gray-300 border-transparent'"
                                aria-current="page">
                                Contenido
                            </button>
                            <button @click="seleccionarPestana('publicaciones')"
                                :class="pestaniaActiva === 'publicaciones' 
                                        ? 'whitespace-nowrap py-4 px-1 border-b-2 font-medium text-sm text-blue-600 border-blue-600' 
                                        : 'whitespace-nowrap py-4 px-1 border-b-2 font-medium text-sm text-gray-500 hover:text-gray-700 hover:border-gray-300 border-transparent'">
                                Publicaciones
                            </button>
                            <button @click="seleccionarPestana('comentarios')"
                                :class="pestaniaActiva === 'comentarios' 
                                        ? 'whitespace-nowrap py-4 px-1 border-b-2 font-medium text-sm text-blue-600 border-blue-600' 
                                        : 'whitespace-nowrap py-4 px-1 border-b-2 font-medium text-sm text-gray-500 hover:text-gray-700 hover:border-gray-300 border-transparent'">
                                Comentarios
                            </button>
                        </nav>
                    </div>
                </div>

                <div x-show="pestaniaActiva === 'contenido'" class="bg-white rounded-lg shadow p-6 mb-6">
                    <p class="text-md mb-4" x-text="curso?.descripcion || ''"></p>
                    <h5 class="text-xl font-bold mb-4">Contenido del curso</h5>
                    <div class="space-y-2">
                        <div class="flex-1 overflow-y-auto">
                            <template x-for="(tema, temaIndex) in (curso?.temas || [])" :key="tema.id_tema">
                                <div class="border-b border-gray-200">
                                    <div class="p-3 md:p-4 bg-gray-100">
                                        <h4 class="font-semibold text-xs md:text-sm text-gray-900"
                                            x-text="(temaIndex + 1) + '. ' + tema.nombre"></h4>
                                    </div>

                                    <div>
                                        <template x-for="(item, itemIndex) in tema.items"
                                            :key="'item-' + tema.id_tema + '-' + itemIndex">
                                            <div
                                                class="p-3 md:p-4 border-b border-gray-100 flex items-center space-x-2 md:space-x-3">
                                                <div class="flex-shrink-0">
                                                    <template x-if="item.tipo === 'clase'">
                                                        <i class="fas fa-play-circle text-gray-600 text-sm"></i>
                                                    </template>
                                                    <template x-if="item.tipo === 'evaluacion'">
                                                        <i class="fas fa-file-alt text-gray-600 text-sm"></i>
                                                    </template>
                                                    <template x-if="item.tipo === 'anuncio'">
                                                        <i class="fas fa-bullhorn text-gray-600 text-sm"></i>
                                                    </template>
                                                    <template x-if="item.tipo === 'asistencia'">
                                                        <i class="fas fa-user-check text-gray-600 text-sm"></i>
                                                    </template>
                                                </div>

                                                <div class="flex-1 min-w-0">
                                                    <p class="text-xs md:text-sm text-gray-900 truncate"
                                                        x-text="(temaIndex + 1)+'.'+(itemIndex + 1) + '. ' + item.detalle.titulo">
                                                    </p>
                                                </div>
                                            </div>
                                        </template>
                                    </div>
                                </div>
                            </template>
                        </div>
                    </div>
                </div>

                <div x-show="pestaniaActiva === 'publicaciones'" class="bg-white rounded-lg shadow p-6 mb-6">
                    <h2 class="text-2xl font-bold mb-4">Publicaciones</h2>
                    <div class="space-y-4">
                        <template
                            x-for="publicacion in (curso?.publicaciones || []).filter(p => p.autor === curso?.instructor)"
                            :key="publicacion.id">
                            <div class="border-b pb-4">
                                <div class="flex items-center mb-2">
                                    <span class="font-semibold text-gray-900" x-text="publicacion.autor"></span>
                                    <span class="ml-2 text-xs text-gray-500" x-text="publicacion.fecha"></span>
                                </div>
                                <p class="text-gray-800" x-text="publicacion.contenido"></p>
                            </div>
                        </template>
                    </div>
                </div>

                <div x-show="pestaniaActiva === 'comentarios'" class="bg-white rounded-lg shadow p-6 mb-6">
                    <div class="flex justify-between items-center mb-6">
                        <h2 class="text-2xl font-bold text-gray-800">Comentarios</h2>
                        <button @click="agregarValoracion()"
                            class="px-4 py-2 bg-white text-blue-900 border border-blue-900 rounded-lg hover:bg-blue-900 hover:text-white transition flex items-center gap-2">
                            <i class="fas fa-plus"></i>
                            <span>Agregar comentario</span>
                        </button>
                    </div>

                    <div class="space-y-6">
                        <template x-for="valoracion in (curso?.valoraciones || [])" :key="valoracion.id_valoracion">
                            <div class="border border-gray-200 rounded-lg p-5 hover:shadow-md transition">
                                <div class="flex items-start gap-4">
                                    <div class="flex-shrink-0">
                                        <div
                                            class="w-12 h-12 bg-blue-600 rounded-full flex items-center justify-center text-white font-bold text-lg">
                                            <span x-text="valoracion.nombre_usuario.charAt(0).toUpperCase()"></span>
                                        </div>
                                    </div>

                                    <div class="flex-1">
                                        <div class="flex items-center justify-between mb-2">
                                            <div>
                                                <h3 class="font-semibold text-gray-900"
                                                    x-text="valoracion.nombre_usuario"></h3>
                                                <span class="text-xs text-gray-500"
                                                    x-text="valoracion.fecha_registro"></span>
                                            </div>
                                        </div>

                                        <div class="flex items-center gap-1 mb-3">
                                            <template x-for="star in 5" :key="star">
                                                <i class="fas fa-star text-lg"
                                                    :class="star <= valoracion.valoracion ? 'text-yellow-400' : 'text-gray-300'"></i>
                                            </template>
                                            <span class="ml-2 text-sm font-medium text-gray-600"
                                                x-text="valoracion.valoracion + '/5'"></span>
                                        </div>

                                        <p class="text-gray-700 leading-relaxed" x-text="valoracion.comentario"></p>
                                    </div>
                                </div>
                            </div>
                        </template>

                        <template x-if="!curso?.valoraciones || curso.valoraciones.length === 0">
                            <div class="text-center py-12">
                                <i class="fas fa-comments text-gray-300 text-5xl mb-4"></i>
                                <p class="text-gray-500 text-lg">No hay comentarios aún</p>
                                <p class="text-gray-400 text-sm mt-2">Sé el primero en dejar tu valoración</p>
                            </div>
                        </template>
                    </div>
                </div>
            </div>

            <div class="lg:col-span-1">
                <div class="sticky top-4">
                    <div class="bg-white rounded-lg shadow p-6">
                        <template x-if="!cargando && curso">
                            <div class="flex items-center justify-center mb-4">
                                <img :src="curso.imagen ? 'public/assets/portadas/' + curso.imagen : 'public/assets/portadas/plantilla.jpg'"
                                    :alt="curso.nombre" class="w-full h-50 rounded mb-4 object-cover">
                            </div>
                        </template>
                        <template x-if="cargando">
                            <div class="flex items-center justify-center h-50 bg-gray-100 rounded mb-4">
                                <div class="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-900"></div>
                            </div>
                        </template>
                        <button @click="iniciarCurso()" :disabled="!curso"
                            class="block cursor-pointer w-full bg-blue-900 hover:bg-white border hover:border-blue-900 hover:text-blue-900 text-white font-bold py-3 rounded mb-3 text-center disabled:opacity-50 disabled:cursor-not-allowed">
                            <i class="fas fa-play-circle mr-2"></i>Iniciar curso
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="public/js/curso.js?v=<?= APP_VERSION ?>"></script>