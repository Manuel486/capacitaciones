<!doctype html>
<html>

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
    <script defer src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sortablejs@latest/Sortable.min.js"></script>
    <style>
        [x-cloak] {
            display: none !important;
        }
    </style>
    <title>SEPCON</title>
</head>

<body class="bg-gray-50">
    <div x-data="appComponente()">
        <div x-show="modalDialogo.activo" x-cloak class="fixed inset-0 flex items-center justify-center z-50">
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
                                @click="cerrarModalDialogo()">
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
                        <div class="flex-shrink-0">
                            <h1 class="text-2xl font-bold text-blue-900">SEPCON LEARN</h1>
                        </div>
                        <div class="hidden md:block">
                            <div class="ml-10 flex items-baseline space-x-4">
                                <a href="inicio" class="text-gray-900 hover:text-blue-900 px-3 py-2 rounded-md text-sm font-medium <?php if ($vista === 'inicio')
                                    echo 'border-b-4 border-blue-900'; ?>">
                                    Inicio
                                </a>
                                <a href="cursos" class="text-gray-900 hover:text-blue-900 px-3 py-2 rounded-md text-sm font-medium <?php if ($vista === 'cursos')
                                    echo 'border-b-4 border-blue-900'; ?>">
                                    Cursos
                                </a>
                                <template x-if="cargandoSesion">
                                    <div class="flex items-center px-3 py-2 h-8 bg-gray-100 rounded-md">
                                        <span class="text-gray-700 text-sm">Cargando...</span>
                                    </div>
                                </template>
                                <div x-show="!cargandoSesion && !usuarioLogueado" x-cloak>
                                    <button @click="activarModalDialogo()"
                                        class="bg-blue-900 text-white px-4 py-2 rounded-md text-sm font-medium border hover:bg-white hover:border-blue-900 hover:text-blue-900">
                                        Iniciar Sesión
                                    </button>
                                </div>
                                <div x-show="!cargandoSesion && usuarioLogueado" x-cloak>
                                    <a href="mis_cursos" class="text-gray-900 hover:text-blue-900 px-3 py-2 rounded-md text-sm font-medium <?php if ($vista === 'mis_cursos')
                                        echo 'border-b-4 border-blue-900'; ?>">
                                        Mis Cursos
                                    </a>
                                    <a x-show="usuarioLogueado && usuarioLogueado.accesos && usuarioLogueado.accesos.includes('gestionar_cursos')"
                                        href="gestionar_cursos" class="text-gray-900 hover:text-blue-900 px-3 py-2 rounded-md text-sm font-medium <?php if ($vista === 'gestionar_cursos')
                                            echo 'border-b-4 border-blue-900'; ?>">
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
            </nav>
        <?php endif; ?>

        <?= $contenido ?>

    </div>

    <script src="public/js/app.js?v=<?= APP_VERSION ?>"></script>
</body>

</html>