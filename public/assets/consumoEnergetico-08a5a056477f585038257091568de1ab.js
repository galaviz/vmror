$(document).ready(function() {
  $('#manual-info').hide();
  $('#energy-info-next-button').prop('disabled', true);
  $('#rpu-help-block').hide();

  $("#rpu").on('input propertychange paste', function() {
    if ($("#energy-info-auth").is(':checked')) {
      validateRpuField();
    }
  });

  $("#energy-info-auth").click(function(){
    if ($("#energy-info-auth").is(':checked')) {
      validateRpuField();
      $('#manual-info').fadeOut();
    } else{
      $('#manual-info').fadeIn();
      $('#energy-info-next-button').prop('disabled', false);
      $('#rpu-form-group').removeClass('has-error');
      $('#rpu-help-block').hide();
    }
  });

  $(".monthly-comsumption").on('input propertychange paste', function() {
    var sum = 0;
    $('.monthly-comsumption').each(function() {
        val = parseInt($(this).val());
        if (!isNaN(val)) {
          sum += val;
        }
    });
    $('#consumo-total').html(numberWithCommas(sum));
    $('#consumo-total-hidden').val(sum);
  });

  $(".monthly-import").on('input propertychange paste', function() {
    var sum = 0;
    $('.monthly-import').each(function() {
        val = parseFloat($(this).val());
        if (!isNaN(val)) {
          sum += val;
        }
    });
    var iva = sum * 0.16;
    var total = sum * 1.16;
    $('#import-subtotal').html('$' + numberWithCommas(sum.toFixed(2)) + " MN");
    $('#import-iva').html('$' + numberWithCommas(iva.toFixed(2)) + " MN");
    $('#import-total').html('$' + numberWithCommas(total.toFixed(2)) + " MN");
    $('#import-total-hidden').val(total);
  });

  $("#cargo-fijo, #energia").on('input propertychange paste', function() {
    computeDepuracion();
  });

});

/*src: http://stackoverflow.com/questions/2901102/how-to-print-a-number-with-commas-as-thousands-separators-in-javascript*/
function numberWithCommas(x) {
    var parts = x.toString().split(".");
    parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    return parts.join(".");
}

function computeDepuracion(){
  var depuracion = parseFloat($("#cargo-fijo").val().replace(/,/g,'')) / parseFloat($("#energia").val().replace(/,/g,''));
  var depuracionPercent = 100 * depuracion;
  if (!isNaN(depuracionPercent)){
    $("#depuracion").html(depuracionPercent.toFixed(2)+"%")
  }
}

function validateRpuField(){
    var rpu = parseInt($("#rpu").val().replace(/\s/g, ""));
    console.log(rpu);
    if (isValidRpu(rpu)){
      $('#energy-info-next-button').prop('disabled', false);
      $('#rpu-form-group').addClass('has-success');
      $('#rpu-form-group').removeClass('has-error');
      $('#rpu-help-block').hide();
      $('#consumo-total').html("13110");//TODO: Fetch from DB
      $('#consumo-total-hidden').val(13110);
      $('#import-total').html("13110");//TODO: Fetch from DB
      $('#import-total-hidden').val(13110);
    } else{
      $('#rpu-form-group').removeClass('has-success');
      $('#rpu-form-group').addClass('has-error');
      $('#energy-info-next-button').prop('disabled', true);
      $('#consumo-total').html("");
      $('#import-total').html("");
      $('#consumo-total-hidden').val(0);
      $('#import-total-hidden').val(0);
      $('#rpu-help-block').show();
    }
}

function isValidRpu(rpu){
  //TODO: Currently hardcoded. Maked AJAX call to db
  return rpu == 376780500123;
}

;
