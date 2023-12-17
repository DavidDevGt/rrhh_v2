<?php
include_once 'components/header/default.php';
include_once 'includes/db/db.php';
include_once 'includes/funciones.php';
?>

<!-- Contenido del cuerpo principal -->
<main class="container">
    <h1 class="text-center">Bienvenido al Sistema de RRHH</h1>
    <div class="row justify-content-center">
        <div class="col-md-6">
            <!-- Formulario de Inicio de Sesión -->
            <form id="loginForm">
                <div class="form-group">
                    <label for="username">Nombre de Usuario</label>
                    <input type="text" class="form-control" id="username" name="username" required>
                </div>
                <div class="form-group">
                    <label for="password">Contraseña</label>
                    <input type="password" class="form-control" id="password" name="password" required>
                    <!-- Icono para ver contraseña -->
                    <span toggle="#password" class="fa fa-fw fa-eye field-icon toggle-password"></span>
                </div>
                <button type="submit" class="btn btn-primary">Iniciar Sesión</button>
            </form>
        </div>
    </div>
</main>

<script>
    $(document).ready(function() {
        // Función para alternar la visibilidad de la contraseña
        $(".toggle-password").click(function() {
            $(this).toggleClass("fa-eye fa-eye-slash");
            var input = $($(this).attr("toggle"));
            if (input.attr("type") == "password") {
                input.attr("type", "text");
            } else {
                input.attr("type", "password");
            }
        });

        // Manejo del formulario de inicio de sesión
        $("#loginForm").submit(function(event) {
            event.preventDefault();
            $.ajax({
                url: 'includes/auth/login.php',
                type: 'post',
                dataType: 'json',
                data: $(this).serialize(),
                success: function(response) {
                    if (response.success) {
                        window.location.href = '/dashboard'; // Ruta del dashboard
                    } else {
                        // Mostrar mensaje de error
                        swal("Error", response.error, "error");
                    }
                }
            });
        });
    });
</script>

<?php include_once 'components/footer/default.php'; ?>