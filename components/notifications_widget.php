<div class="notification-widget">
    <div class="list-group" id="notificationList" aria-live="polite" aria-atomic="true" style="position: relative;">
        <!-- Las notificaciones se insertarán aquí -->
    </div>
</div>

<style>
    .notification-widget {
        position: fixed;
        top: 10px;
        right: 10px;
        z-index: 1050;
        /* Revisar */
        width: 300px;
        max-height: 300px;
        overflow-y: auto;
    }

    .notification-widget .list-group-item {
        word-wrap: break-word;
    }
</style>

<script>
    function mostrarNotificacion(mensaje, tipo = 'success') {
        var notificacion = $('<a href="#" class="list-group-item list-group-item-action list-group-item-' + tipo + '">' + mensaje + '</a>');
        $('#notificationList').prepend(notificacion);
        setTimeout(function() {
            notificacion.fadeOut('slow', function() {
                $(this).remove();
            });
        }, 5000); // La notificación se va después de 5 segundos
    }

    // Ejemplo de uso
    // mostrarNotificacion('Operación realizada con éxito', 'success');
</script>