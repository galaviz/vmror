$(document).ready(function() {
  //Carousel
  $('#form-carousel').carousel('pause');

  registrationModel = {};//store global variables as a hash
  $("#energy-info-button").click(function(){
    $('#consumo-mensual-promedio').val($("#registration2-consumo-mensual-promedio").val());
    updateFields($('#consumo-mensual-promedio').val());
  });

  registrationModel.membershipType = ""

  $("#select-vm-small").click(function(){
    registrationModel.membershipType = "VM Pequeño";
    registrationModel.tamano = tamanoPequeno;
    registrationModel.production = 12 * productionPequeno;
    registrationModel.subtotal = inversionPequeno;
    registrationModel.ahorro = ahorroPequeno;
    registrationModel.tir = irrPequeno;
    registrationModel.payback = paybackPequeno;
    console.log(registrationModel);
  });

  $("#select-vm-medium").click(function(){
    registrationModel.membershipType = "VM Mediano";
    registrationModel.tamano = tamanoMediano;
    registrationModel.production = 12 * productionMediano;
    registrationModel.subtotal = inversionMediano;
    registrationModel.ahorro = ahorroMediano;
    registrationModel.tir = irrMediano;
    registrationModel.payback = paybackMediano;
    console.log(registrationModel);
  });

  $("#select-vm-large").click(function(){
    registrationModel.membershipType = "VM Grande";
    registrationModel.tamano = tamanoGrande;
    registrationModel.production = 12 * productionGrande;
    registrationModel.subtotal = inversionGrande;
    registrationModel.ahorro = ahorroGrande;
    registrationModel.tir = irrGrande;
    registrationModel.payback = paybackGrande;
    console.log(registrationModel);
  });

  //Pickadate
  $('#fecha-visita').pickadate({
      monthsFull: ["Enero", "Febrero", "Marzo", "Abril","Mayo","Junio","Julio","Agosto","Setiembre","Octubre","Noviembre","Diciembre"],
      weekdaysShort: ['Dom', 'Lun', 'Mar', 'Mie', 'Jue', 'Vie', 'Sab'],
      showWeekdaysFull: false,
      today: 'Hoy',
      clear: 'Borrar',
      close: 'Cerrar'
  });
  $('#hora-visita').pickatime({
      format: 'H:i A',
      min: [8,0],
      max: [17,0],
      interval: 45
  });

  //Payment mode dropdown toggle
  hidePaymentModeInfo();

  $(".payment-selection").click(function() {
    hidePaymentModeInfo();
    $(this).siblings(".payment-info").show();
    registrationModel.selectedPaymentMode = $(this).attr('value');
    console.log(registrationModel.selectedPaymentMode);
    registrationModel.paymentTotal = registrationModel.subtotal * 1.16;
    $(".payment-iva").text("$" + numberWithCommas((registrationModel.subtotal * 0.16).toFixed(2))+" USD");
    $(".payment-subtotal").text("$" + numberWithCommas(registrationModel.subtotal.toFixed(2)) + " USD");
    $(".payment-total").text("$" + numberWithCommas(registrationModel.paymentTotal.toFixed(2)) + " USD");
  });

  //Submit button
  $("#btn-crear-cuenta").click(function() {
    window.location.href = "dashboard.html";
  });

  function hidePaymentModeInfo() {
    $(".payment-info").each(function() {
      $(this).hide();
    });
  }

  $( "#last-registration-button" ).click(function() {
      /* Populate user info table*/

      //first, reset table (this is necessary, e.g. if user clicks back)
      $("#user-info-table").empty();

      addHeaderToUserInfoTable("Resumen de Usuario");
      addRowToUserInfoTable("Tipo de Membresía",registrationModel.membershipType);
      $("#registration-form-user :input").each(function(index){
        var input = $(this);
        var label = $('label[for='+input.attr('name')+']').text();
        if (label.length > 0){
          addRowToUserInfoTable(label, input.val());
        }
      });

      addHeaderToUserInfoTable("Resumen Energetico");
      $("#registration-form-energy :input, #tarifa").each(function(index){
        var input = $(this);
        var label = $('label[for='+input.attr('name')+']').text();
        if (label.length > 0){
          addRowToUserInfoTable(label, input.val());
        }
      });
      addRowToUserInfoTable("Consumo Anual (kWh)", $("#consumo-total").html() + " kWh");

      addHeaderToUserInfoTable("Resumen de Propuesta");
      addRowToUserInfoTable("Tamaño", numberWithCommas(registrationModel.tamano.toFixed(1)) + " kWp");
      addRowToUserInfoTable("Produccion Anual (Estimada)", numberWithCommas(registrationModel.production.toFixed(0)) + " kWh");
      addRowToUserInfoTable("Ahorro Económico", "$" +numberWithCommas(registrationModel.ahorro.toFixed(2)) + " MN");
      addRowToUserInfoTable("Payback (Años)", registrationModel.payback.toFixed(1) );
      addRowToUserInfoTable("TIR", registrationModel.tir.toFixed(1) + "%");
      addRowToUserInfoTable("Total", "$" +numberWithCommas(registrationModel.paymentTotal.toFixed(2)) + " USD");

      addHeaderToUserInfoTable("Resumen de Visita y Pago");
      $("#registration-form-date :input, #registration-form-payment :input").each(function(index){
        var input = $(this);
        var label = $('label[for='+input.attr('name')+']').text();
        if (label.length > 0){
          addRowToUserInfoTable(label, input.val());
        }
      });

      addRowToUserInfoTable("Modo de Pago",registrationModel.selectedPaymentMode);
      addHeaderToUserInfoTable("Firma");
      $("#user-info-table").append("<tr><td><input type='checkbox' id='contract-checkbox' name='contract-checkbox'>Acepto el contrato</span></td><td></td></tr>");
      $("#user-info-table").append("<tr><td><input type='checkbox' id='contract-checkbox2' name='contract-checkbox2'>Acepto otorgar poder</span></td><td></td></tr>");

      /*Create pdf (contract)*/
      createContract2(false);
      $('#contract-checkbox2').change(function() {
          createContract2($(this).is(":checked"));
      });

      /* Fill out fields in user welcome*/
      $("#user-welcome :input[name='account-email']").val($("#registration-form-user :input[name='email']").val());
      $("#user-welcome .nombre").text($("#registration-form-user :input[name='nombre']").val());
      $("#user-welcome .descuento").text("57% ");
      $("#user-welcome .energia-renovable").text("27% ");

  });

  function addRowToUserInfoTable(label, val){
    $("#user-info-table").append("<tr><td><span class='bold'>"+label+": </span>    </td><td>"+val+"</td></tr>");
  }

  function addHeaderToUserInfoTable(text) {
    $("#user-info-table").append("<tr><td><h4 style='margin-top:20px;'>"+text+": </h4>    </td><td> </td></tr>");
  }

  function createContract2(isSigned){
      var doc = new jsPDF();
      doc.setFont("helvetica");
      doc.setFontSize(12);
      var textStr = "";

      var today = new Date();
      var months = ["Enero", "Febrero", "Marzo", "Abril","Mayo","Junio","Julio","Agosto","Setiembre","Octubre","Noviembre","Diciembre"];
      textStr += "Monterrey, Nuevo Leon a " + today.getDate() + " de " + months[today.getMonth()] + " de "+ today.getFullYear() + "\n";
      textStr += "\n\nComision Federal de Electricidad\n";
      textStr += "A quien corresponda:\n\n\n";

      textStr += "Por  medio de  la  presente,  otorgo el  poder para que  a mi nombre y representacion\n";
      textStr += "la empresa  Verde  Monarca,  en  representacion del Ing.  David  Eduardo  Arrambide\n";
      textStr += "Montemayor, realice los tramites necesarios ante la Comision Federal de Electricidad\n";
      textStr += "para gestionar el Contrato de Interconexion para fuente de energia renovable.\n";

      textStr += "\n\nSin mas por el momento me despido, reiterandome a sus ordenes.\n\n\n\n";
      if (isSigned){
        textStr += "Otorga el Poder: " + $("input[name='nombre'").val() + " " + $("input[name='apellido'").val() + "\n";
      } else{
        textStr += "Otorga el Poder: _____________________________\n\n";
      }
      textStr += "Acepta el Poder: David Eduardo Arrambide Montemayor";
      // textStr += "Nombre: " + $("input[name='nombre'").val() +"\n";
      // textStr += "apellido: " + $("input[name='apellido'").val() +"\n";
      // textStr += "Telefono: " + $("input[name='telefono'").val() +"\n";
      // textStr += "Email: " + $("input[name='email'").val() +"\n";
      // textStr += "RPU: " + $("input[name='rpu'").val() +"\n";
      // textStr += "Consumo Anual Promedio (kWh): " + $("#consumo-total").html() +"\n";
      doc.text(30, 30, textStr);
      $('#contrato2-pdf').attr('src', doc.output('datauristring'));
  }

  function splitStr(str){
    tempArr = str.match(/.{1,3}/g);
    return tempArr.join('\n')
  }

  $("#energy-info-next-button").click(function() {
    createPropuesta($('#consumo-total').html() / 12.0);
  });

});

//PRESUPUESTO

/* Constants and Multipliers*/

var consumos = [150, 150, 150, 400];
var precios = [0.717, 0.844, 1.077, 2.88, 3.524];//currency = MN

var basicConsumption = consumos[0] + consumos[1] + consumos[2];//450
var consumoExcedente = consumos[3];
var consumoMaximo = basicConsumption + consumoExcedente;//850

var focosConstant = 0.0545;
var arbolesConstant = 0.1725;
var co2Constant = 0.1326;
var gasolinaConstant = 2.9435;

var safetyFactorMin = 0.8;
var safetyFactorExcess = 1.2;

var systemOversizeFactor = 1.2;
var avgConsumptionInArea = 1694;

var systemCostPequeno = 3.0;
var systemCostMediano = 2.75;
var systemCostGrande = 2.60;

/* Constants subject to change, or that might depend on each individual user */
var maintenanceAnualCost = 3000;//currency = MN, might vary per user.
var cfeAnualIncrement = 0.06;//6%
var currencyExchangeRate = 13;//USD to MN
var taxRate = 1.16;
var NUM_YEARS = 25;

//param input: avg monthly consumption
function createPropuesta(input){
  //compute values
  var consumoRestante = input - consumoMaximo;

  //TODO: Organize global variables
  //pv monthly production options
  // registrationModel.production = {};
  // registrationModel.production.grande = (input) * safetyFactorMin;
  // registrationModel.production.mediano = Math.max(input - basicConsumption, 0) * safetyFactorExcess;
  // registrationModel.production.pequeno = Math.max(input - consumoMaximo,0) * safetyFactorExcess;

  productionGrande = (input) * safetyFactorMin;
  productionMediano = Math.max(input - basicConsumption, 0) * safetyFactorExcess;
  productionPequeno = Math.max(input - consumoMaximo,0) * safetyFactorExcess;

  //calculate sizes (in kWp)
  tamanoGrande = productionGrande * 12.0 * systemOversizeFactor / avgConsumptionInArea;
  tamanoMediano = productionMediano * 12.0 * systemOversizeFactor / avgConsumptionInArea;
  tamanoPequeno = productionPequeno * 12.0 * systemOversizeFactor / avgConsumptionInArea;

  //calculate energy consumption
  consumptionPequeno = input - productionPequeno;
  consumptionMediano = input - productionMediano;
  consumptionGrande = input - productionGrande;

  //calculate costs
  costoActual = precios[4] * input;
  costoActualAnual = 12.0 * costoActual;

  costoPequeno = 0;//monthly. pequeno
  for (var i = 0; i < 3; i++) {
    costoPequeno += precios[i] * consumos[i];
  }
  costoPequeno += maintenanceAnualCost / 12.0;
  costoPequeno += Math.min(400, Math.max(consumptionPequeno - basicConsumption, 0)) * precios[3];
  costoPequeno += Math.max(consumptionPequeno - consumoMaximo, 0) * precios[4];
  costoPequenoAnual = 12.0 * costoPequeno;

  avgSubsidizedCost = (precios[0] + precios[1] + precios[2]) / 3.0;
  costoMedianoAnual = 12.0 * (consumptionMediano * avgSubsidizedCost) + maintenanceAnualCost;
  costoGrandeAnual = 12.0 * (consumptionGrande * avgSubsidizedCost) + maintenanceAnualCost;

  ahorroPequeno = costoActualAnual - costoPequenoAnual;
  ahorroMediano = costoActualAnual - costoMedianoAnual;
  ahorroGrande = costoActualAnual - costoGrandeAnual;

  //calculate energy savings
  ahorroEnergeticoPequeno = 100 * (input - consumptionPequeno) / input;
  ahorroEnergeticoMediano = 100 * (input - consumptionMediano)  / input;
  ahorroEnergeticoGrande = 100 * (input - consumptionGrande) / input;

  //calculate return on investment
  inversionPequeno = 1000 * tamanoPequeno * systemCostPequeno;
  inversionMediano = 1000 * tamanoMediano * systemCostMediano;
  inversionGrande = 1000 * tamanoGrande * systemCostGrande;

  //inversion total (currency = MN). Includes tax
  inversionTotalPequeno = inversionPequeno * currencyExchangeRate * taxRate;
  inversionTotalMediano = inversionMediano * currencyExchangeRate * taxRate;
  inversionTotalGrande = inversionGrande * currencyExchangeRate * taxRate;

  // calculate payback
  paybackPequeno = inversionTotalPequeno / (costoActualAnual - costoPequenoAnual);
  paybackMediano = inversionTotalMediano / (costoActualAnual - costoMedianoAnual);
  paybackGrande = inversionTotalGrande / (costoActualAnual - costoGrandeAnual);

  // calcualate IRR
  irrPequeno = computeIRR(inversionTotalPequeno, costoActualAnual - costoPequenoAnual, cfeAnualIncrement, NUM_YEARS);
  irrMediano = computeIRR(inversionTotalMediano, costoActualAnual - costoMedianoAnual, cfeAnualIncrement, NUM_YEARS);
  irrGrande = computeIRR(inversionTotalGrande, costoActualAnual - costoGrandeAnual, cfeAnualIncrement, NUM_YEARS);

  // update plot
  createPropuestaChart(irrPequeno, irrMediano, irrGrande, tamanoPequeno, tamanoMediano, tamanoGrande);

  //set values

  $("#vm-pequeno .tamano-sistema-solar").text(tamanoPequeno.toFixed(1) + " kWp");
  $("#vm-mediano .tamano-sistema-solar").text(tamanoMediano.toFixed(1) + " kWp");
  $("#vm-grande .tamano-sistema-solar").text(tamanoGrande.toFixed(1) + " kWp");

  $("#vm-pequeno .produccion-anual").text(numberWithCommas((12 * productionPequeno).toFixed(1)) + " kWh");
  $("#vm-mediano .produccion-anual").text(numberWithCommas((12 * productionMediano).toFixed(1)) + " kWh");
  $("#vm-grande .produccion-anual").text(numberWithCommas((12 * productionGrande).toFixed(1)) + " kWh");

  $("#vm-pequeno .costo-anual-sin-vm").text("\$" + numberWithCommas(costoActualAnual.toFixed(2)) + " MN");
  $("#vm-mediano .costo-anual-sin-vm").text("\$" + numberWithCommas(costoActualAnual.toFixed(2)) + " MN");
  $("#vm-grande .costo-anual-sin-vm").text("\$" + numberWithCommas(costoActualAnual.toFixed(2)) + " MN");

  $("#vm-pequeno .costo-anual").text("\$" + numberWithCommas(costoPequenoAnual.toFixed(2)) + " MN");
  $("#vm-mediano .costo-anual").text("\$" + numberWithCommas(costoMedianoAnual.toFixed(2)) + " MN");
  $("#vm-grande .costo-anual").text("\$" + numberWithCommas(costoGrandeAnual.toFixed(2)) + " MN");

  $("#vm-pequeno .ahorro-economico").text("\$" + numberWithCommas(ahorroPequeno.toFixed(0)) + " MN");
  $("#vm-mediano .ahorro-economico").text("\$" + numberWithCommas(ahorroMediano.toFixed(0)) + " MN");
  $("#vm-grande .ahorro-economico").text("\$" + numberWithCommas(ahorroGrande.toFixed(0)) + " MN");

  $("#vm-pequeno .ahorro-energetico").text(ahorroEnergeticoPequeno.toFixed(0) + "\%");
  $("#vm-mediano .ahorro-energetico").text(ahorroEnergeticoMediano.toFixed(0) + "\%");
  $("#vm-grande .ahorro-energetico").text(ahorroEnergeticoGrande.toFixed(0) + "\%");

  $("#vm-pequeno .arboles-no-talados").text((productionPequeno * arbolesConstant).toFixed(0));
  $("#vm-mediano .arboles-no-talados").text((productionMediano * arbolesConstant).toFixed(0));
  $("#vm-grande .arboles-no-talados").text((productionGrande * arbolesConstant).toFixed(0));

  $("#vm-pequeno .co2").text((productionPequeno * co2Constant).toFixed(0));
  $("#vm-mediano .co2").text((productionMediano * co2Constant).toFixed(0));
  $("#vm-grande .co2").text((productionGrande * co2Constant).toFixed(0));

  $("#vm-pequeno .inversion-total").text("\$" + numberWithCommas(inversionPequeno.toFixed(0)) + " USD");
  $("#vm-mediano .inversion-total").text("\$" + numberWithCommas(inversionMediano.toFixed(0)) + " USD");
  $("#vm-grande .inversion-total").text("\$" + numberWithCommas(inversionGrande.toFixed(0)) + " USD");

  $("#vm-pequeno .payback").text(numberWithCommas(paybackPequeno.toFixed(1)));
  $("#vm-mediano .payback").text(numberWithCommas(paybackMediano.toFixed(1)));
  $("#vm-grande .payback").text(numberWithCommas(paybackGrande.toFixed(1)));

  $("#vm-pequeno .tir").text(irrPequeno.toFixed(0) + "\%");
  $("#vm-mediano .tir").text(irrMediano.toFixed(0) + "\%");
  $("#vm-grande .tir").text(irrGrande.toFixed(0) + "\%");

  //update plot
}

function setPropuestaValue(field, value, prefix, suffix, numDecimals) {
  var sizes = ["pequeno", "mediano", "grande"];
  for (var i=0;i<sizes.length;i++) {
    $("vm-" + sizes[i] + " ." + field).text(prefix + numberWithCommas(value[sizes[i]].toFixed(numDecimals)) + suffix);
  }
}

function computeIRR(initialInvestment, baseSavings, annualIncrement, numYears) {
  cashFlows = [];
  cashFlows.push(-1.0 * initialInvestment);
  for (var i = 0; i < numYears; i++) {
    cashFlows.push(baseSavings * Math.pow(1 + annualIncrement, i));
  }
  return 100 * IRR(cashFlows, 0.2);
}


function createPropuestaChart(irrPequeno, irrMediano, irrGrande, tamanoPequeno, tamanoMediano, tamanoGrande) {
  $('#tir-chart').highcharts({
      chart: {
          type: 'column'
      },
      title: {
          text: 'Tasa Interna de Rendimiento (TIR)'
      },
      legend: {
          enabled: false,
      },
      plotOptions: {
          series: {
              borderWidth: 0,
              dataLabels: {
                  enabled: true,
                  format: '{point.y:.1f}%'
              }
          }
      },
      xAxis: {
          type: 'category'
      },
      yAxis: {
          title: {
              text: 'Tasa Interna de Rendimiento (TIR)'
          }
      },
      tooltip: {
          headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
          pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
              '<td style="padding:0"><b>{point.y:.0f} %</b></td></tr>',
          footerFormat: '</table>',
          shared: true,
          useHTML: true
      },
      plotOptions: {
          series: {
              borderWidth: 0,
              dataLabels: {
                  enabled: true,
                  format: '{point.y:.0f}%'
              }
          }
      },
      series: [{
          name: 'TIR',
          colorByPoint: true,
          data: [{name:'VM Pequeño (' + tamanoPequeno.toFixed(1) +' kWp)', y:irrPequeno}, {name:'VM Mediano (' + tamanoMediano.toFixed(1) +' kWp)', y:irrMediano}, {name:'VM Grande (' + tamanoGrande.toFixed(1) +' kWp)', y:irrGrande}, {name:'Banco', y:6}]
      }]
  });
}

/*src: http://stackoverflow.com/questions/2901102/how-to-print-a-number-with-commas-as-thousands-separators-in-javascript*/
function numberWithCommas(x) {
    var parts = x.toString().split(".");
    parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    return parts.join(".");
}
// Copyright (c) 2012 Sutoiku, Inc. (MIT License)

// Some algorithms have been ported from Apache OpenOffice:

/**************************************************************
 *
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 *
 *************************************************************/

function IRR(values, guess) {
  // Credits: algorithm inspired by Apache OpenOffice

  // Calculates the resulting amount
  var irrResult = function(values, dates, rate) {
    var r = rate + 1;
    var result = values[0];
    for (var i = 1; i < values.length; i++) {
      result += values[i] / Math.pow(r, (dates[i] - dates[0]) / 365);
    }
    return result;
  }

  // Calculates the first derivation
  var irrResultDeriv = function(values, dates, rate) {
    var r = rate + 1;
    var result = 0;
    for (var i = 1; i < values.length; i++) {
      var frac = (dates[i] - dates[0]) / 365;
      result -= frac * values[i] / Math.pow(r, frac + 1);
    }
    return result;
  }

  // Initialize dates and check that values contains at least one positive value and one negative value
  var dates = [];
  var positive = false;
  var negative = false;
  for (var i = 0; i < values.length; i++) {
    dates[i] = (i === 0) ? 0 : dates[i - 1] + 365;
    if (values[i] > 0) positive = true;
    if (values[i] < 0) negative = true;
  }

  // Return error if values does not contain at least one positive value and one negative value
  if (!positive || !negative) return '#NUM!';

  // Initialize guess and resultRate
  var guess = (typeof guess === 'undefined') ? 0.1 : guess;
  var resultRate = guess;

  // Set maximum epsilon for end of iteration
  var epsMax = 1e-10;

  // Set maximum number of iterations
  var iterMax = 50;

  // Implement Newton's method
  var newRate, epsRate, resultValue;
  var iteration = 0;
  var contLoop = true;
  do {
    resultValue = irrResult(values, dates, resultRate);
    newRate = resultRate - resultValue / irrResultDeriv(values, dates, resultRate);
    epsRate = Math.abs(newRate - resultRate);
    resultRate = newRate;
    contLoop = (epsRate > epsMax) && (Math.abs(resultValue) > epsMax);
  } while(contLoop && (++iteration < iterMax));

  if(contLoop) return '#NUM!';

  // Return internal rate of return
  return resultRate;
}
;
