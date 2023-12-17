<?php
function usuarioAutenticado() {
    return isset($_SESSION['user_id']);
}
