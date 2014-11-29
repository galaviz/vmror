/* TODO: Put these in a main.js file */
$(document).ready(function() {
  $('#form-carousel').carousel('pause');
  $('#quotes-carousel').carousel({
    interval: 5000,
    pause: "none"
  });

  /** Form formatting. **/
  $('#telefono').formatter({
    'pattern': '({{999}}) {{999}}-{{9999}}',
    'persistent': true
  });

  $('#celular').formatter({
    'pattern': '({{999}}) {{999}}-{{9999}}',
    'persistent': true
  });

  $('#consumo-mensual-promedio').formatter({
    'pattern': '{{9999999}}',
    'persistent': true
  });

  /** Form Validation**/
  var notEmptyMessage = "Campo requerido (no puede estar vacio)";
  $('#registration-form-1').bootstrapValidator({
      fields: {
          nombre: {
              validators: {
                  notEmpty: {
                      message: notEmptyMessage
                  }
              }
          },
          apellido: {
              validators: {
                  notEmpty: {
                      message: notEmptyMessage
                  }
              }
          },
          email: {
              validators: {
                  notEmpty: {
                      message: notEmptyMessage
                  },
                  emailAddress: {
                      message: 'No es un e-mail valido'
                  }
              }
          }
      }
  });

});
