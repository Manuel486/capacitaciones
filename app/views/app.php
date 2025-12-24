<!doctype html>
<html>

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <!-- <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script> -->
    <link rel="stylesheet" href="public/css/app.css?v=<?= APP_VERSION ?>" />
    <script defer src="public/js/alpine.min.js"></script>
    <link rel="stylesheet" href="public/fontawesome/css/all.min.css"/>
    <script src="public/js/sortable.min.js"></script>
    <link rel="icon" href="public/assets/favicon.ico" type="image/x-icon">
    <link href="https://cdn.quilljs.com/1.3.7/quill.snow.css" rel="stylesheet">
    <style>
        [x-cloak] {
            display: none !important;
        }
    </style>
    <title>SEPCON</title>
</head>

<body class="<?= $vista === 'tomar_curso' ? 'bg-white' : 'bg-gray-100' ?>">
    <div x-data="appComponente()" @abrir-modal.window="abrirModalConDatos($event.detail)" @cerrar-modal.window="cerrarModalDialogo()" @obtener-usuario-logueado.window="obtenerUsuarioLogueado($event.detail)">

        <div x-show="modalDialogo.activo" x-cloak class="fixed inset-0 flex items-center justify-center z-1000">
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
                            <template x-if="modalDialogo.tipo === 'cargando'">
                                <svg class="animate-spin h-8 w-8 text-gray-500" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                                    <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                                    <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8v4a4 4 0 00-4 4H4z"></path>
                                </svg>
                            </template>
                        </div>
                        <div class="mt-3 text-center sm:mt-0 sm:ml-4 sm:text-left">
                            <h3 class="text-center font-semibold text-gray-900" x-text="modalDialogo.titulo"></h3>
                            <div class="mt-2">
                                <p class="text-sm text-gray-700 text-center" x-text="modalDialogo.mensaje"></p>
                            </div>
                        </div>
                        <div class="w-full mt-4 items-center justify-center flex">
                            <button type="button" x-show="modalDialogo.tipo !== 'cargando'" x-cloak
                                class="cursor-pointer rounded-md hover:bg-blue-900 px-3 py-2 text-sm font-semibold hover:text-white shadow-xs border bg-white border-blue-900 text-blue-900"
                                @click="cerrarModalDialogo()">Cerrar</button>
                        </div>
                    </div>

                </div>

            </div>
        </div>

        <div x-show="modalIniciarSesion.activo" x-cloak class="fixed inset-0 flex items-center justify-center z-50">
            <div class="fixed inset-0 bg-black/75"></div>
            <div class="relative bg-white rounded-lg shadow-xl w-full max-w-sm mx-auto z-10">
                <div class="px-4 pt-5 pb-4 sm:p-6 sm:pb-4">
                    <div class="flex flex-col gap-4">
                        <div class="text-center mb-2">
                            <h3 class="text-xl font-bold text-gray-900">Iniciar Sesión</h3>
                        </div>
                        <div class="space-y-4">
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Usuario</label>
                                <input x-model="sesion.usuario" type="text" placeholder="Ingresa tu usuario"
                                    autocomplete="off"
                                    class="border border-gray-300 rounded-lg w-full py-2.5 px-3 text-sm focus:ring-2 focus:ring-blue-900 focus:border-transparent outline-none transition">
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Contraseña</label>
                                <input x-model="sesion.password" type="password" placeholder="Ingresa tu contraseña"
                                    autocomplete="off"
                                    class="border border-gray-300 rounded-lg w-full py-2.5 px-3 text-sm focus:ring-2 focus:ring-blue-900 focus:border-transparent outline-none transition">
                            </div>
                            <div x-show="credencialesInvalidas.activo" x-cloak
                                class="flex items-center gap-2 bg-red-100 border border-red-400 text-red-700 px-4 py-2 rounded-lg shadow-sm animate-shake">
                                <i class="fa-solid fa-circle-exclamation text-red-500"></i>
                                <span x-text="credencialesInvalidas.mensaje"></span>
                            </div>
                        </div>
                        <div class="flex gap-3 mt-2">
                            <button type="button"
                                class="cursor-pointer flex-1 bg-blue-900 text-white rounded-lg px-4 py-2.5 text-sm font-semibold hover:bg-blue-800 transition shadow-sm"
                                @click="iniciarSesion()">
                                Ingresar
                            </button>
                            <button type="button"
                                class="cursor-pointer flex-1 bg-white text-gray-700 border border-gray-300 rounded-lg px-4 py-2.5 text-sm font-semibold hover:bg-gray-50 transition shadow-sm"
                                @click="cerrarModalIniciarSesion()">
                                Cancelar
                            </button>
                        </div>
                    </div>
                </div>

            </div>
        </div>
        <?php if ($vista !== "tomar_curso"): ?>
            <nav class="bg-white shadow-md">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                    <div class="flex justify-between items-center h-16">
                        <div>
                            <h1 class="text-2xl font-bold text-blue-900">SEPCON LEARN</h1>
                        </div>
                        <div class="md:hidden">
                            <button @click="menuAbierto = !menuAbierto" type="button"
                                class="inline-flex items-center justify-center p-2 rounded-md text-blue-900 hover:text-white hover:bg-blue-900 focus:outline-none focus:ring-2 focus:ring-inset focus:ring-blue-900"
                                aria-controls="mobile-menu" aria-expanded="false">
                                <span class="sr-only">Abrir menú principal</span>
                                <svg x-show="!menuAbierto" class="h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
                                </svg>
                                <svg x-show="menuAbierto" class="h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                                </svg>
                            </button>
                        </div>
                        <div class="hidden md:block">
                            <div class="ml-10 flex gap-4 items-center">
                                <a href="inicio" class="text-gray-900 hover:text-blue-900 px-3 py-2 rounded-md text-sm font-medium <?php if ($vista === 'inicio') echo 'border-b-4 border-blue-900'; ?>">
                                    Inicio
                                </a>
                                <a href="cursos" class="text-gray-900 hover:text-blue-900 px-3 py-2 rounded-md text-sm font-medium <?php if ($vista === 'cursos') echo 'border-b-4 border-blue-900'; ?>">
                                    Cursos
                                </a>
                                <template x-if="cargandoSesion">
                                    <div class="flex items-center px-3 py-2 h-8 bg-gray-100 rounded-md">
                                        <span class="text-gray-700 text-sm">Cargando...</span>
                                    </div>
                                </template>
                                <div x-show="!cargandoSesion && !usuarioLogueado" x-cloak>
                                    <button @click="activarModalIniciarSesion()"
                                        class="bg-blue-900 text-white px-4 py-2 rounded-md text-sm font-medium border hover:bg-white hover:border-blue-900 hover:text-blue-900">
                                        Iniciar Sesión
                                    </button>
                                </div>
                                <div x-show="!cargandoSesion && usuarioLogueado" x-cloak class="flex gap-4 items-center">
                                    <a href="mis_cursos" class="text-gray-900 hover:text-blue-900 px-3 py-2 rounded-md text-sm font-medium <?php if ($vista === 'mis_cursos') echo 'border-b-4 border-blue-900'; ?>">
                                        Mis Cursos
                                    </a>
                                    <a x-show="usuarioLogueado && usuarioLogueado.accesos && usuarioLogueado.accesos.includes('gestionar_cursos')"
                                        href="gestionar_cursos" class="text-gray-900 hover:text-blue-900 px-3 py-2 rounded-md text-sm font-medium <?php if ($vista === 'gestionar_cursos') echo 'border-b-4 border-blue-900'; ?>">
                                        Gestionar Cursos
                                    </a>
                                    <button @click="cerrarSesion()"
                                        class="bg-red-600 cursor-pointer text-white px-4 py-2 rounded-md text-sm font-medium border hover:bg-white hover:border-red-600 hover:text-red-600">
                                        Cerrar Sesión
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="md:hidden" x-show="menuAbierto" x-transition x-cloak id="mobile-menu">
                    <div class="px-2 pt-2 pb-3 space-y-1">
                        <a href="inicio" class="block text-gray-900 hover:text-blue-900 px-3 py-2 rounded-md text-base font-medium <?php if ($vista === 'inicio') echo 'border-l-4 border-blue-900'; ?>">
                            Inicio
                        </a>
                        <a href="cursos" class="block text-gray-900 hover:text-blue-900 px-3 py-2 rounded-md text-base font-medium <?php if ($vista === 'cursos') echo 'border-l-4 border-blue-900'; ?>">
                            Cursos
                        </a>
                        <template x-if="cargandoSesion">
                            <div class="flex items-center px-3 py-2 h-8 bg-gray-100 rounded-md">
                                <span class="text-gray-700 text-sm">Cargando...</span>
                            </div>
                        </template>
                        <div x-show="!cargandoSesion && !usuarioLogueado" x-cloak>
                            <button @click="activarModalIniciarSesion(); menuAbierto = false"
                                class="w-full bg-blue-900 text-white px-4 py-2 rounded-md text-base font-medium border hover:bg-white hover:border-blue-900 hover:text-blue-900">
                                Iniciar Sesión
                            </button>
                        </div>
                        <div x-show="!cargandoSesion && usuarioLogueado" x-cloak class="flex flex-col gap-2">
                            <a href="mis_cursos" class="block text-gray-900 hover:text-blue-900 px-3 py-2 rounded-md text-base font-medium <?php if ($vista === 'mis_cursos') echo 'border-l-4 border-blue-900'; ?>">
                                Mis Cursos
                            </a>
                            <a x-show="usuarioLogueado && usuarioLogueado.accesos && usuarioLogueado.accesos.includes('gestionar_cursos')"
                                href="gestionar_cursos" class="block text-gray-900 hover:text-blue-900 px-3 py-2 rounded-md text-base font-medium <?php if ($vista === 'gestionar_cursos') echo 'border-l-4 border-blue-900'; ?>">
                                Gestionar Cursos
                            </a>
                            <button @click="cerrarSesion(); menuAbierto = false"
                                class="w-full bg-red-600 cursor-pointer text-white px-4 py-2 rounded-md text-base font-medium border hover:bg-white hover:border-red-600 hover:text-red-600">
                                Cerrar Sesión
                            </button>
                        </div>
                    </div>
                </div>
            </nav>
        <?php endif; ?>

        <?= $contenido ?>

    </div>

    <script src="https://cdn.quilljs.com/1.3.7/quill.min.js"></script>
    <script src="public/js/app.js?v=<?= APP_VERSION ?>"></script>
</body>

</html>