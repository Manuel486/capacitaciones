<div x-data="cursoDetalleComponente()">
    <div x-show="modalDialogo.activo" x-cloak class="fixed inset-0 flex items-center justify-center z-50">
        <div class="fixed inset-0 bg-black/75"></div>
        <div class="relative bg-white rounded-lg shadow-xl w-full max-w-sm mx-auto z-10">
            <div class="px-4 pt-5 pb-4 sm:p-6 sm:pb-4">
                <div class="flex flex-col gap-2 items-center">
                    <div class="mx-auto flex items-center justify-center w-12 h-12 rounded-full" :class="{
                               'bg-red-100': modalDialogo.tipo === 'error',
                               'bg-yellow-100': modalDialogo.tipo === 'advertencia',
                               'bg-blue-100': modalDialogo.tipo === 'info',
                               'bg-green-100': modalDialogo.tipo === 'exito'
                            }">
                        <template x-if="modalDialogo.tipo === 'error'">
                            <i class="fas fa-times-circle text-red-600 text-2xl"></i>
                        </template>
                        <template x-if="modalDialogo.tipo === 'advertencia'">
                            <i class="fas fa-exclamation-triangle text-yellow-600 text-2xl"></i>
                        </template>
                        <template x-if="modalDialogo.tipo === 'info'">
                            <i class="fas fa-info-circle text-blue-600 text-2xl"></i>
                        </template>
                        <template x-if="modalDialogo.tipo === 'exito'">
                            <i class="fas fa-check-circle text-green-600 text-2xl"></i>
                        </template>
                    </div>
                    <div class="mt-3 text-center sm:mt-0 sm:ml-4 sm:text-left">
                        <h3 class="text-center font-semibold text-gray-900" x-text="modalDialogo.titulo"></h3>
                        <div class="mt-2">
                            <p class="text-sm text-gray-700 text-center" x-text="modalDialogo.mensaje"></p>
                        </div>
                    </div>
                    <div class="w-full mt-4 items-center justify-center flex">
                        <button type="button"
                            class=" cursor-pointer rounded-md hover:bg-blue-900 px-3 py-2 text-sm font-semibold hover:text-white shadow-xs border bg-white border-blue-900 text-blue-900"
                            @click="cerrarModalDialogo()">Cerrar</button>
                    </div>
                </div>

            </div>

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
                                    <div class="flex items-center gap-2">
                                        <span class="text-yellow-400">★</span>
                                        <span class="text-yellow-400">★</span>
                                        <span class="text-yellow-400">★</span>
                                        <span class="text-yellow-400">★</span>
                                        <span x-text="curso.rating"></span>
                                        <span class="text-gray-400"
                                            x-text="'(' + curso.totalEstudiantes + ' estudiantes)'"></span>
                                    </div>
                                    <div>
                                        <span class="text-gray-400">Creado por</span>
                                        <span x-text="curso.instructor"></span>
                                    </div>
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
                        <template x-for="publicacion in (curso?.publicaciones || []).filter(p => p.autor === curso?.instructor)"
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
                    <h2 class="text-2xl font-bold mb-4">Comentarios</h2>
                    <div class="space-y-4">
                        <template x-for="comentario in (curso?.comentarios || [])" :key="comentario.id">
                            <div class="border-b pb-4">
                                <div class="flex items-center mb-2">
                                    <span class="font-semibold text-gray-900" x-text="comentario.autor"></span>
                                    <span class="ml-2 text-xs text-gray-500" x-text="comentario.fecha"></span>
                                </div>
                                <p class="text-gray-800" x-text="comentario.texto"></p>
                            </div>
                        </template>
                    </div>
                </div>
            </div>

            <div class="lg:col-span-1">
                <div class="sticky top-4">
                    <div class="bg-white rounded-lg shadow p-6">
                        <template x-if="!cargando && curso">
                            <div>
                                <img src="public/img/curso.jpg" :alt="curso.nombre" class="w-full h-50 rounded mb-4">
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

<script src="public/js/curso.js"></script>