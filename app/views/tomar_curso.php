<div x-data="tomarCurso()">
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
                            class="cursor-pointer rounded-md hover:bg-blue-900 px-3 py-2 text-sm font-semibold hover:text-white shadow-xs border bg-white border-blue-900 text-blue-900"
                            @click="cerrarModalDialogo()">Cerrar</button>
                    </div>
                </div>

            </div>

        </div>
    </div>

    <header class="bg-gray-900 text-white shadow">
        <div class="max-w-screen-2xl mx-auto px-6 py-4 flex flex-col md:flex-row md:items-center md:justify-between">
            <div class="flex gap-4 items-center">
                <div>
                    <a :href="'mis_cursos'"
                        class="cursor-pointer hover:text-blue-400 hover:-translate-y-5 transition-transform duration-200">
                        <i class="fa-solid fa-arrow-left"></i>
                    </a>
                </div>
                <template x-if="!cargando && curso.nombre">
                    <h1 class="text-xl font-semibold" x-text="curso.nombre"></h1>
                </template>
                <template x-if="cargando">
                    <div class="h-6 bg-gray-700 rounded w-64 animate-pulse"></div>
                </template>
            </div>
            <div :class="curso.progreso == 100 ? 'visible' : 'invisible'">
                <a href="public/certificados/certificado.pdf" target="_blank"
                    class="flex items-center gap-2 p-1 border-2 border-blue-600 text-black font-medium px-4 rounded shadow-sm transition bg-white hover:border-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-400">
                    <i class="fas fa-award text-blue-500 text-lg"></i>
                    Obtener Certificado
                </a>
            </div>
            <!-- <div class="mt-3 md:mt-0 w-full md:w-72">
                    <template x-if="!cargando && curso.progreso !== undefined">
                        <div class="flex items-center space-x-3">
                            <span class="text-sm text-gray-200 font-medium">Progreso</span>
                            <div class="flex-1">
                                <div class="w-full bg-gray-700 rounded-full h-3">
                                    <div class="bg-blue-500 h-3 rounded-full transition-all duration-300"
                                        :style="'width: ' + curso.progreso + '%'"></div>
                                </div>
                            </div>
                            <span class="text-sm text-blue-200 font-semibold" x-text="curso.progreso + '%'"></span>
                        </div>
                    </template>
                </div> -->
        </div>
    </header>

    <main class="max-w-screen-2xl mx-auto">
        <div class="grid grid-cols-1 lg:grid-cols-7">

            <section class="order-1 col-span-5 lg:order-3">
                <template x-if="cargando">
                    <div class="flex items-center justify-center min-h-[400px] bg-gray-100">
                        <div class="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-900"></div>
                    </div>
                </template>
                <template x-if="!cargando">
                    <div>
                        <template x-if="item_actual.tipo === 'clase'">
                            <div class="bg-black">
                                <video class="w-full h-100" controls controlsList="nodownload"
                                    :src="'api/obtener_video?nombre=' + item_actual.detalle.video">
                                    Tu navegador no soporta el elemento de video.
                                </video>
                            </div>
                        </template>
                        <template x-if="item_actual.tipo === 'anuncio'">
                            <div class="bg-gray-100 h-100 flex items-center justify-center">
                                <div
                                    class="max-w-xl w-full text-center p-8 rounded-lg shadow-md bg-white border border-gray-200">
                                    <div class="flex justify-center mb-4">
                                        <i class="fas fa-bullhorn text-gray-700 text-3xl"></i>
                                    </div>
                                    <span class="block text-gray-700 text-lg font-semibold"
                                        x-text="item_actual.detalle.anuncio ?? 'Anuncio'"></span>
                                </div>
                            </div>
                        </template>
                        <template x-if="item_actual.tipo === 'evaluacion'">
                            <div>
                                <div x-show="!modo_evaluacion"
                                    class="bg-gray-100 h-100 flex items-center justify-center">
                                    <div
                                        class="max-w-xl w-full p-8 rounded-lg shadow-md bg-white border border-gray-200">
                                        <div class="flex gap-4 mb-4">
                                            <i class="fas fa-file-alt text-gray-700 text-3xl"></i>
                                            <span class="block text-gray-700 text-lg font-semibold"
                                                x-text="item_actual.detalle.titulo ?? 'Evaluación.'"></span>
                                        </div>
                                        <span class="block text-gray-700 text-md"
                                            x-text="item_actual.detalle.descripcion"></span>
                                        <span class="font-medium">Nota: Para aprobar necesita responder al menos el
                                            70% del examen</span>
                                        <button x-show="item_actual.completado == 0" @click="activarModoEvaluacion()"
                                            class="group mx-auto cursor-pointer mt-6 px-6 py-2 bg-blue-900 hover:bg-white hover:text-blue-900 border hover:boder-blue-900 text-white font-semibold rounded-lg shadow transition duration-200 flex items-center gap-2">
                                            <i
                                                class="fas fa-play-circle text-white text-lg group-hover:text-blue-900"></i>
                                            Iniciar Evaluación
                                        </button>
                                    </div>
                                </div>
                                <div x-show="modo_evaluacion"
                                    class="bg-gray-100 w-full h-full p-5 flex items-start justify-center min-h-[800px]">
                                    <form class="bg-white shadow-md rounded-lg p-6 w-full max-w-lg"
                                        @submit.prevent="enviarEvaluacion">
                                        <template x-for="(pregunta, index) in item_actual.detalle.preguntas">
                                            <div class="mb-6">
                                                <h6 class="text-gray-800 font-semibold mb-2">
                                                    <span class="font-bold"
                                                        x-text="'Pregunta ' + (index+1) + ': '"></span>
                                                    <span x-text="pregunta.contenido"></span>
                                                </h6>
                                                <template
                                                    x-for="(alternativa, alternativaIndex) in pregunta.alternativas"
                                                    :key="alternativaIndex">
                                                    <div class="flex items-center mb-2">
                                                        <input type="radio" :name="'pregunta_' + pregunta.id_pregunta"
                                                            :value="alternativa.id_alternativa"
                                                            class="mr-2 text-blue-600 focus:ring-blue-500"
                                                            :id="'id-' + alternativa.id_alternativa" required>
                                                        <label class="text-gray-700"
                                                            :for="'id-' + alternativa.id_alternativa"
                                                            x-text="alternativa.contenido"></label>
                                                    </div>
                                                </template>
                                            </div>
                                        </template>
                                        <div class="flex justify-end">
                                            <button type="submit"
                                                class="group px-5 py-2 bg-blue-900 text-white border hover:text-blue-900 hover:bg-white hover:border-blue-900 rounded-lg font-semibold transition flex items-center gap-2">
                                                <i
                                                    class="group-hover:text-blue-900 fas fa-paper-plane text-white text-lg"></i>
                                                Enviar Respuesta
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </template>

                        <div x-show="!modo_evaluacion" class="bg-white p-4 md:p-6">
                            <h2 class="text-xl md:text-2xl font-bold text-gray-900 mb-2"
                                x-text="item_actual.detalle.titulo">Título de la clase actual</h2>
                            <div class="border-t pt-4">
                                <div class="flex space-x-4 md:space-x-6 text-xs md:text-sm overflow-x-auto">
                                    <button
                                        class="text-gray-900 font-semibold border-b-2 border-gray-900 pb-2 whitespace-nowrap">Descripción</button>
                                    <button
                                        class="text-gray-600 hover:text-gray-900 pb-2 whitespace-nowrap">Recursos</button>
                                    <button
                                        class="text-gray-600 hover:text-gray-900 pb-2 whitespace-nowrap">Anuncios</button>
                                    <button
                                        class="text-gray-600 hover:text-gray-900 pb-2 whitespace-nowrap">Comentarios</button>
                                </div>
                                <div class="mt-4 text-gray-700 text-sm leading-relaxed"
                                    x-text="item_actual.detalle.descripcion">
                                    Contenido de la clase va aquí.

                                </div>
                            </div>
                        </div>
                    </div>
                </template>
            </section>

            <aside
                class="col-span-2 bg-white border-t lg:border-t-0 lg:border-l border-gray-200 overflow-hidden flex flex-col order-2 lg:order-2 max-h-[500px] lg:max-h-screen">
                <div class="p-4 border-b border-gray-200">
                    <h3 class="font-semibold text-gray-900 text-sm md:text-base">Contenido del curso</h3>
                </div>

                <template x-if="cargando">
                    <div class="p-4 space-y-3">
                        <div class="h-4 bg-gray-200 rounded animate-pulse"></div>
                        <div class="h-4 bg-gray-200 rounded animate-pulse"></div>
                        <div class="h-4 bg-gray-200 rounded animate-pulse"></div>
                    </div>
                </template>

                <template x-if="!cargando">
                    <div class="flex-1 overflow-y-auto">
                        <template x-for="(tema, temaIndex) in curso.temas" :key="tema.id_tema">
                            <div class="border-b border-gray-200">

                                <div class="p-3 md:p-4 bg-gray-100">
                                    <h4 class="font-semibold text-xs md:text-sm text-gray-900"
                                        x-text="(temaIndex + 1) + '. ' + tema.nombre"></h4>
                                </div>

                                <div>
                                    <template x-for="(item, itemIndex) in tema.items"
                                        :key="'item-' + tema.id_tema + '-' + itemIndex">
                                        <div @click="seleccionarItem(temaIndex, itemIndex)" :class="[
                                                    'p-3 md:p-4 cursor-pointer border-b border-gray-100 flex items-center space-x-2 md:space-x-3',
                                                    item_actual.id_item === item.id_item ? 'bg-blue-100 border-blue-500' : ''
                                                ]">
                                            <div class="flex-shrink-0 mt-1">
                                                <div
                                                    class="w-4 h-4 md:w-4 md:h-4 border-2 border-gray-400 rounded-sm flex items-center justify-center bg-white">
                                                    <template x-if="item.completado == 1">
                                                        <i class="fas fa-check text-green-500 text-xs md:text-sm"></i>
                                                    </template>
                                                </div>
                                            </div>

                                            <div class="flex-shrink-0 mt-0.5 ">
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
                                                <!-- <template x-if="item.tipo === 'clase'">
                                                        <p class="text-xs text-gray-500 mt-1">5:30 min</p>
                                                    </template> -->
                                            </div>
                                        </div>
                                    </template>
                                </div>
                            </div>
                        </template>
                    </div>
                </template>
            </aside>
        </div>
    </main>
</div>
<script src="https://cdn.jsdelivr.net/npm/js-confetti@latest/dist/js-confetti.browser.js"></script>
<script src="public/js/tomar_curso.js?v=<?= APP_VERSION ?>"></script>