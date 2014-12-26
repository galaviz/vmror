// $("#energy-info-button").click(function(){
//   $('#consumo-mensual-promedio').val($("#registration2-consumo-mensual-promedio").val());
//   updateFields($('#consumo-mensual-promedio').val());
// });

// membershipType = ""

// $("#select-vm-estandar").click(function(){
//   membershipType = "estandar";
//   console.log(membershipType);
// });

// $("#select-vm-platino").click(function(){
//   membershipType = "platino";
//   console.log(membershipType);
// });


// $( "#last-registration-button" ).click(function() {

//     /* Populate user info table*/
//     $("#user-info-table").empty();  
//     $("#registration-form-1 :input, #registration-form-2 :input, #registration-form-3 input:checked").each(function(index){
//       var input = $(this);
//       var label = $('label[for='+input.attr('name')+']').text();
//       if (label.length > 0){
//         $("#user-info-table").append("<tr><td><span class='bold'>"+label+": </span>    </td><td>"+input.val()+"</td></tr>");
//       }
//     });
//     $("#user-info-table").append("<tr><td><span class='bold'>Tipo de Membresía: </span>    </td><td>"+membershipType+"</td></tr>");    
//     $("#user-info-table").append("<tr><td><input type='checkbox' name='contract-checkbox'>Acepto el contrato</span></td><td></td></tr>");

//     /*Create pdf (contract)*/
//     var doc = new jsPDF();
//     doc.text(35, 25, "Hello Wold");
//     $('#contrato-pdf').attr('src', doc.output('datauristring'));


//     /* Fill out fields in user welcome*/
//     $("#user-welcome :input[name='account-email']").val($("#registration-form-1 :input[name='email']").val());
//     $("#user-welcome .nombre").text($("#registration-form-1 :input[name='nombre']").val());
//     if(membershipType=="platino"){
//       $("#user-welcome .tipo-membresia").text("platino")
//     }
// });
