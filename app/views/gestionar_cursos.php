<div x-data="gestionarCursosComponente()">
    <div class="container mx-auto px-4 py-8">
        <div class="bg-white rounded-lg shadow p-6">
            <div class="">
                <div>
                    <input type="text" class="border" placeholder="Ingrese el nombre del curso a buscar">
                    <a href="formulario_curso" class="border">Crear nuevo curso</a>
                </div>
                <table class="w-full text-center">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Nombre del Curso</th>
                            <th>Inscritos</th>
                            <th>Valoración del Curso</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <template x-for="(curso, index) in cursos" :key="curso.id_curso">
                            <tr class="border-t">
                                <td class="py-2" x-text="index + 1"></td>
                                <td class="py-2" x-text="curso.nombre"></td>
                                <td class="py-2" x-text="curso.inscritos"></td>
                                <td class="py-2" x-text="curso.valoracion ? curso.valoracion.toFixed(1) + ' / 5' : 'Sin valoraciones'"></td>
                                <td class="py-2">
                                    <a :href="'formulario_curso?id_curso=' + curso.id_curso"
                                        class="bg-blue-900 text-white px-4 py-2 rounded-lg font-medium border hover:bg-white hover:border-blue-900 hover:text-blue-900 transition">
                                        Editar Curso
                                    </a>
                                </td>
                            </tr>
                        </template>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script src="public/js/gestionar_cursos.js?v=<?= APP_VERSION ?>"></script>