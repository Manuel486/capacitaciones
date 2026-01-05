<div x-data="tomarCurso()">

    <div x-show="modalComentario" x-cloak class="fixed inset-0 flex items-center justify-center z-100 p-4"
        style="background: rgba(0,0,0,0.5);">
        <div class="bg-white rounded-lg shadow-lg max-w-lg w-full p-4 sm:p-6 relative max-h-[90vh] overflow-y-auto">
            <button @click="cerrarModalComentario()" class="absolute top-3 right-3 text-gray-400 hover:text-gray-600">
                <i class="fas fa-times text-xl"></i>
            </button>
            <h2 class="text-xl font-bold mb-4 text-gray-800">Comentario</h2>
            <form class="space-y-4" @submit.prevent>
                <div>
                    <textarea x-model="comentario"
                        class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring focus:border-blue-900"
                        rows="3" placeholder="Comentario"></textarea>
                </div>
                <div class="flex justify-end space-x-2 pt-2">
                    <button @click="cerrarModalComentario()" type="button"
                        class="px-4 py-2 bg-gray-200 text-gray-700 rounded hover:bg-gray-300 transition">
                        Cancelar
                    </button>
                    <button type="button" @click="guardarComentario()"
                        class="px-4 py-2 bg-blue-900 text-white rounded hover:bg-blue-700 transition">
                        Guardar
                    </button>
                </div>
            </form>
        </div>
    </div>

    <div class="bg-white border-b-2 border-gray-200 shadow-md">
        <div class="px-4 sm:px-6 lg:px-8 py-5 flex flex-col md:flex-row md:items-center md:justify-between gap-4">
            <div class="flex gap-4 items-center">
                <div>
                    <a :href="'mis_cursos'"
                        class="cursor-pointer hover:bg-gray-100 p-2 rounded-lg hover:scale-110 transition-all duration-200">
                        <i class="fa-solid fa-arrow-left text-lg text-blue-900"></i>
                    </a>
                </div>
                <template x-if="!cargando && curso.nombre">
                    <h1 class="text-lg md:text-xl font-bold text-gray-800" x-text="curso.nombre"></h1>
                </template>
                <template x-if="cargando">
                    <div class="h-6 bg-gray-200 rounded-lg w-64 animate-pulse"></div>
                </template>
            </div>
            <div x-show="curso.progreso == 100 && curso.tiene_certificacion == 1" x-cloak>
                <a :href="'api/obtener_certificado?id_curso=' + obtenerId()" target="_blank"
                    class="flex items-center gap-2 px-5 py-2.5 bg-blue-900 text-white font-semibold rounded-lg shadow-lg hover:shadow-xl hover:scale-105 transition-all duration-200 border-2 border-blue-700">
                    <i class="fas fa-award text-yellow-400 text-lg"></i>
                    Obtener Certificado
                </a>
            </div>
        </div>
    </div>

    <div class="bg-gray-50 min-h-screen">
        <div class="mx-auto px-4 sm:px-6 lg:px-50 py-6">
            <div class="grid grid-cols-1" :class="{'lg:grid-cols-12 gap-6': !modo_evaluacion, 'lg:grid-cols-1': modo_evaluacion}">

                <section class="order-2 lg:order-2" :class="{'lg:col-span-8': !modo_evaluacion, 'lg:col-span-1': modo_evaluacion}">

                <template x-if="cargando">
                    <div class="flex items-center justify-center min-h-[400px] bg-white rounded-2xl shadow-lg">
                        <div class="animate-spin rounded-full h-16 w-16 border-b-4 border-blue-600"></div>
                    </div>
                </template>
                <template x-if="!cargando">
                    <div class="bg-white rounded-2xl shadow-lg overflow-hidden">
                        <template x-if="item_actual.tipo === 'clase'">
                            <div class="bg-black rounded-t-2xl overflow-hidden">
                                <video class="w-full aspect-video" controls controlsList="nodownload"
                                    :src="'api/obtener_video?nombre=' + item_actual.detalle.video">
                                    Tu navegador no soporta el elemento de video.
                                </video>
                            </div>
                        </template>
                        <template x-if="item_actual.tipo === 'anuncio'">
                            <div class="bg-gradient-to-br from-blue-50 to-indigo-50 min-h-[400px] flex items-center justify-center p-8">
                                <div
                                    class="max-w-2xl w-full text-center p-10 rounded-2xl shadow-xl bg-white border-2 border-blue-100">
                                    <div class="flex justify-center mb-6">
                                        <div class="bg-blue-100 p-4 rounded-full">
                                            <i class="fas fa-bullhorn text-blue-900 text-4xl"></i>
                                        </div>
                                    </div>
                                    <span class="block text-gray-800 text-xl font-bold"
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
                                        <!-- <span class="block text-gray-700 text-md"
                                            x-text="item_actual.detalle.descripcion"></span> -->
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
                                <div x-show="modo_evaluacion" :key="'eval-' + item_actual.id_item"
                                    class="bg-gray-100 w-full h-full min-h-screen">
                                    <div class="max-w-7xl mx-auto px-4 py-8">
                                        <div class="grid grid-cols-1 lg:grid-cols-4 gap-6">
                                            <div class="lg:col-span-1">
                                                <div class="bg-white rounded-xl shadow-lg p-6 sticky top-4">
                                                    <div x-show="temporizador_activo" class="mb-6">
                                                        <div class="flex items-center justify-between mb-2">
                                                            <span class="text-sm font-medium text-gray-600">Tiempo restante</span>
                                                            <i class="fas fa-clock text-blue-900"></i>
                                                        </div>
                                                        <div class="bg-gradient-to-r from-blue-500 to-indigo-600 rounded-lg p-4 text-center">
                                                            <span class="text-3xl font-bold text-white"
                                                                x-text="formatearTiempo(tiempo_restante)"></span>
                                                        </div>
                                                    </div>

                                                    <div class="mb-6">
                                                        <div class="flex items-center justify-between mb-2">
                                                            <span class="text-sm font-medium text-gray-600">Progreso</span>
                                                            <span class="text-sm font-bold text-blue-900"
                                                                x-text="Object.keys(respuestas_evaluacion).length + '/' + item_actual.detalle.preguntas.length"></span>
                                                        </div>
                                                        <div class="w-full bg-gray-200 rounded-full h-2">
                                                            <div class="bg-gradient-to-r from-blue-500 to-indigo-600 h-2 rounded-full transition-all duration-300"
                                                                :style="'width: ' + ((Object.keys(respuestas_evaluacion).length / item_actual.detalle.preguntas.length) * 100) + '%'"></div>
                                                        </div>
                                                    </div>

                                                    <div>
                                                        <h3 class="text-sm font-semibold text-gray-700 mb-3 flex items-center gap-2">
                                                            <i class="fas fa-list-ol text-blue-900"></i>
                                                            Preguntas
                                                        </h3>
                                                        <div class="space-y-2 max-h-96 overflow-y-auto">
                                                            <template x-for="(pregunta, index) in item_actual.detalle.preguntas"
                                                                :key="pregunta.id_pregunta">
                                                                <button type="button"
                                                                    @click="irAPregunta(index)"
                                                                    :class="[
                                                                        'w-full p-3 rounded-lg text-left transition-all duration-200 flex items-center gap-3 group',
                                                                        pregunta_actual === index 
                                                                            ? 'bg-gradient-to-r bg-blue-900 text-white shadow-md' 
                                                                            : obtenerRespuesta(pregunta.id_pregunta) 
                                                                                ? 'bg-green-50 border-2 border-green-300 text-gray-800 hover:bg-green-100' 
                                                                                : 'bg-gray-50 border-2 border-gray-200 text-gray-600 hover:bg-gray-100'
                                                                    ]">
                                                                    <div :class="[
                                                                        'w-8 h-8 rounded-full flex items-center justify-center font-bold text-sm flex-shrink-0',
                                                                        pregunta_actual === index 
                                                                            ? 'bg-white text-blue-900' 
                                                                            : obtenerRespuesta(pregunta.id_pregunta)
                                                                                ? 'bg-green-500 text-white'
                                                                                : 'bg-gray-200 text-gray-600 group-hover:bg-gray-300'
                                                                    ]">
                                                                        <template x-if="obtenerRespuesta(pregunta.id_pregunta) && pregunta_actual !== index">
                                                                            <i class="fas fa-check text-xs"></i>
                                                                        </template>
                                                                        <template x-if="!obtenerRespuesta(pregunta.id_pregunta) || pregunta_actual === index">
                                                                            <span x-text="index + 1"></span>
                                                                        </template>
                                                                    </div>
                                                                    <span class="text-sm font-medium truncate flex-1">
                                                                        Pregunta <span x-text="index + 1"></span>
                                                                    </span>
                                                                </button>
                                                            </template>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="lg:col-span-3">
                                                <form @submit.prevent="enviarEvaluacion">
                                                    <template x-for="(pregunta, index) in item_actual.detalle.preguntas"
                                                        :key="pregunta.id_pregunta">
                                                        <div x-show="pregunta_actual === index"
                                                            class="bg-white rounded-xl shadow-lg p-8 mb-6">
                                                            <div class="mb-6">
                                                                <div class="flex items-center gap-3 mb-4">
                                                                    <div class="bg-gradient-to-r bg-blue-900 text-white rounded-full w-12 h-12 flex items-center justify-center font-bold text-lg shadow-md">
                                                                        <span x-text="index + 1"></span>
                                                                    </div>
                                                                    <div>
                                                                        <span class="text-sm text-gray-500 font-medium">Pregunta <span x-text="index + 1"></span> de <span x-text="item_actual.detalle.preguntas.length"></span></span>
                                                                    </div>
                                                                </div>
                                                                <h3 class="leading-relaxed"
                                                                    x-html="pregunta.contenido"></h3>
                                                            </div>

                                                            <div class="space-y-3">
                                                                <template x-for="(alternativa, altIndex) in pregunta.alternativas"
                                                                    :key="alternativa.id_alternativa">
                                                                    <div @click="guardarRespuesta(pregunta.id_pregunta, alternativa.id_alternativa)"
                                                                        :class="[
                                                                            'group cursor-pointer rounded-xl p-5 border-2 transition-all duration-200',
                                                                            obtenerRespuesta(pregunta.id_pregunta) == alternativa.id_alternativa
                                                                                ? 'border-blue-900 bg-blue-50 shadow-md'
                                                                                : 'border-gray-200 hover:border-blue-900 hover:bg-blue-50/30'
                                                                        ]">
                                                                        <label class="flex items-start gap-4 cursor-pointer">
                                                                            <div class="flex items-center justify-center w-6 h-6 flex-shrink-0 mt-1">
                                                                                <input type="radio"
                                                                                    :name="'pregunta_' + pregunta.id_pregunta"
                                                                                    :value="alternativa.id_alternativa"
                                                                                    :checked="obtenerRespuesta(pregunta.id_pregunta) == alternativa.id_alternativa"
                                                                                    @change="guardarRespuesta(pregunta.id_pregunta, alternativa.id_alternativa)"
                                                                                    class="w-5 h-5 text-blue-900 focus:ring-blue-900 cursor-pointer">
                                                                            </div>
                                                                            <div class="flex-1">
                                                                                <div class="flex items-center gap-3">
                                                                                    <span :class="[
                                                                                        'inline-flex items-center justify-center w-8 h-8 rounded-full text-sm font-bold',
                                                                                        obtenerRespuesta(pregunta.id_pregunta) == alternativa.id_alternativa
                                                                                            ? 'bg-blue-900 text-white'
                                                                                            : 'bg-gray-200 text-gray-600 group-hover:bg-blue-100'
                                                                                    ]" x-text="String.fromCharCode(65 + altIndex)"></span>
                                                                                    <p :class="[
                                                                                        'text-lg font-medium',
                                                                                        obtenerRespuesta(pregunta.id_pregunta) == alternativa.id_alternativa
                                                                                            ? 'text-blue-900'
                                                                                            : 'text-gray-700'
                                                                                    ]" x-text="alternativa.contenido"></p>
                                                                                </div>
                                                                            </div>
                                                                        </label>
                                                                    </div>
                                                                </template>
                                                            </div>

                                                            <div class="flex items-center justify-between mt-8 pt-6 border-t border-gray-200">
                                                                <button type="button"
                                                                    @click="anteriorPregunta()"
                                                                    x-show="pregunta_actual > 0"
                                                                    class="flex items-center gap-2 px-6 py-3 bg-gray-100 hover:bg-gray-200 text-gray-700 font-semibold rounded-lg transition-all duration-200">
                                                                    <i class="fas fa-arrow-left"></i>
                                                                    Anterior
                                                                </button>
                                                                <div x-show="pregunta_actual === 0"></div>
                                                                
                                                                <button type="button"
                                                                    @click="siguientePregunta()"
                                                                    x-show="pregunta_actual < item_actual.detalle.preguntas.length - 1"
                                                                    class="flex items-center gap-2 px-6 py-3 bg-blue-900 hover:to-indigo-700 text-white font-semibold rounded-lg shadow-md transition-all duration-200">
                                                                    Siguiente
                                                                    <i class="fas fa-arrow-right"></i>
                                                                </button>
                                                                
                                                                <button type="submit"
                                                                    x-show="pregunta_actual === item_actual.detalle.preguntas.length - 1"
                                                                    class="flex items-center gap-2 px-8 py-3 bg-green-700 hover:to-emerald-700 text-white font-bold rounded-lg shadow-md transition-all duration-200">
                                                                    <i class="fas fa-paper-plane"></i>
                                                                    Enviar Evaluación
                                                                </button>
                                                            </div>
                                                        </div>
                                                    </template>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </template>

                        <div x-show="!modo_evaluacion" class="p-6 md:p-8">
                            <h2 class="text-2xl md:text-3xl font-bold text-gray-900 mb-4"
                                x-text="item_actual.detalle.titulo">Título de la clase actual</h2>
                            <div class="border-t-2 border-gray-200 pt-6">
                                <div class="flex space-x-6 md:space-x-8 text-sm md:text-base overflow-x-auto">
                                    <button @click="detalleItemVista = 'descripcion'" :class="{
                                            'text-gray-700 font-semibold whitespace-nowrap pb-3 transition-all': true,
                                            'border-b-3 border-blue-900 text-blue-900': detalleItemVista === 'descripcion'
                                        }">Descripción</button>
                                    <button x-show="item_actual.tipo === 'clase'"
                                        @click="detalleItemVista = 'comentarios'; obtenerComentarios()" :class="{
                                                    'text-gray-700 font-semibold whitespace-nowrap pb-3 transition-all': true,
                                                    'border-b-3 border-blue-900 text-blue-900': detalleItemVista === 'comentarios'
                                    }">Comentarios</button>
                                </div>
                                <div class="mt-6 text-gray-700 text-base leading-relaxed">
                                    <template x-if="detalleItemVista === 'descripcion'">
                                        <div>
                                            <p x-text="item_actual.detalle.descripcion"></p>
                                        </div>
                                    </template>

                                    <template x-if="detalleItemVista === 'comentarios'">
                                        <div>
                                            <template x-if="comentarios_cargando">
                                                <div class="space-y-3">
                                                    <div class="h-4 bg-gray-200 rounded w-3/4 animate-pulse"></div>
                                                    <div class="h-4 bg-gray-200 rounded w-1/2 animate-pulse"></div>
                                                    <div class="h-4 bg-gray-200 rounded w-5/6 animate-pulse"></div>
                                                </div>
                                            </template>
                                            <template x-if="!comentarios_cargando">
                                                <div class="space-y-6">
                                                    <div class="flex justify-between items-center mb-4">
                                                        <h3 class="text-lg font-semibold text-gray-900">Comentarios</h3>
                                                        <button @click="activarModalComentario()"
                                                            class="flex items-center gap-2 px-4 py-2 bg-blue-900 text-white rounded shadow hover:bg-blue-700 transition text-sm font-medium">
                                                            <i class="fas fa-comment-medical"></i>
                                                            Agregar Comentario
                                                        </button>
                                                    </div>
                                                    <template x-if="comentarios.length === 0">
                                                        <div class="flex flex-col items-center py-8">
                                                            <i class="fas fa-comments text-4xl text-gray-300 mb-2"></i>
                                                            <p class="text-gray-500 text-center">No hay comentarios
                                                                aún.<br>¡Sé el primero en comentar!</p>
                                                        </div>
                                                    </template>
                                                    <template x-for="comentario in comentarios"
                                                        :key="comentario.id_comentario">
                                                        <div
                                                            class="flex items-start space-x-4 bg-gray-50 rounded-lg p-4 shadow-sm border border-gray-100 mb-2">
                                                            <div class="">
                                                                <div class="w-10 h-10 bg-blue-500 rounded-full flex items-center justify-center text-white font-bold text-lg shadow"
                                                                    :title="comentario.nombre_usuario">
                                                                    <span
                                                                        x-text="comentario.nombre_usuario.charAt(0).toUpperCase()"></span>
                                                                </div>
                                                            </div>
                                                            <div class="flex-1 min-w-0">
                                                                <div class="flex items-center gap-2">
                                                                    <span class="font-semibold text-gray-900"
                                                                        x-text="comentario.nombre_usuario"></span>
                                                                    <span class="text-xs text-gray-400"
                                                                        x-text="new Date(comentario.fecha_creacion).toLocaleString()"></span>
                                                                </div>
                                                                <p class="text-gray-700 mt-1 whitespace-pre-line"
                                                                    x-text="comentario.comentario"></p>
                                                            </div>
                                                        </div>
                                                    </template>
                                                </div>
                                            </template>
                                        </div>
                                    </template>
                                </div>
                            </div>
                        </div>
                    </div>
                </template>
            </section>

            <aside x-show="!modo_evaluacion"
                class="lg:col-span-4 bg-white rounded-2xl shadow-lg border border-gray-200 overflow-hidden flex flex-col max-h-[600px] lg:max-h-[calc(100vh-8rem)] lg:sticky lg:top-6">
                <div class="p-5 bg-blue-900 text-white">
                    <h3 class="font-bold text-base md:text-lg">📚 Contenido del curso</h3>
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
                            <div class="border-b border-gray-100">

                                <div class="p-4 bg-gradient-to-r from-gray-50 to-blue-50 border-l-4 border-blue-500">
                                    <h4 class="font-bold text-sm md:text-base text-gray-900"
                                        x-text="(temaIndex + 1) + '. ' + tema.nombre"></h4>
                                </div>

                                <div>
                                    <template x-for="(item, itemIndex) in tema.items"
                                        :key="'item-' + tema.id_tema + '-' + itemIndex">
                                        <div @click="seleccionarItem(temaIndex, itemIndex)" :class="[
                                                    'p-4 cursor-pointer border-b border-gray-50 flex items-center space-x-3 hover:bg-blue-50 transition-all duration-200',
                                                    item_actual.id_item === item.id_item ? 'bg-blue-100 border-l-4 border-blue-600 shadow-inner' : ''
                                                ]">
                                            <div class="shrink-0">
                                                <div
                                                    class="w-4 h-4 border rounded-full flex items-center justify-center transition-all" :class="[
                                                        item.completado == 1 ? 'bg-green-100 border-green-400' : 'border-gray-300 bg-white'
                                                    ]">
                                                    <template x-if="item.completado == 1">
                                                        <i class="fas fa-check text-green-500 text-[10px]"></i>
                                                    </template>
                                                </div>
                                            </div>

                                            <div class="shrink-0">
                                                <template x-if="item.tipo === 'clase'">
                                                    <i class="fas fa-play-circle text-gray-400 text-lg"></i>
                                                </template>
                                                <template x-if="item.tipo === 'evaluacion'">
                                                    <i class="fas fa-file-alt text-gray-400 text-lg"></i>
                                                </template>
                                                <template x-if="item.tipo === 'anuncio'">
                                                    <i class="fas fa-bullhorn text-gray-400 text-lg"></i>
                                                </template>
                                                <template x-if="item.tipo === 'asistencia'">
                                                    <i class="fas fa-user-check text-gray-400 text-lg"></i>
                                                </template>
                                            </div>

                                            <div class="flex-1 min-w-0">
                                                <p class="text-sm font-medium text-gray-900 truncate"
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
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/js-confetti@latest/dist/js-confetti.browser.js"></script>
<script src="public/js/tomar_curso.js?v=<?= APP_VERSION ?>"></script>