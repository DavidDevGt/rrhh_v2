"use strict";

//* NOTE: Funciones para manipular elementos del DOM
// Mostrar/Ocultar elementos del DOM con animación lenta
function toggleElemento(elementoId) {
  $("#" + elementoId).fadeToggle("slow");
}

// Mostrar/Ocultar elementos del DOM con efecto de deslizamiento
function deslizarElemento(elementoId) {
  $("#" + elementoId).slideToggle("slow");
}

//* NOTE: Validaciones
// Validar si un campo de texto está vacío
function validarCampoVacio(campoId) {
  var campo = $("#" + campoId);
  if (campo.val().trim() === "") {
    campo.addClass("is-invalid");
    return false;
  } else {
    campo.removeClass("is-invalid");
    return true;
  }
}

// Limitar cantidad de caracteres de un textarea
function limitarCaracteres(textareaId, maxCaracteres) {
  $("#" + textareaId).on("input", function () {
    var texto = $(this).val();
    if (texto.length > maxCaracteres) {
      $(this).val(texto.substring(0, maxCaracteres));
    }
  });
}

