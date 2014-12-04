$(document).ready(function(){
    
});


function ASPR(thisData, thisLocation,thisSuccess, thisError){
    $.ajax({
          type: "POST",
          url: thisLocation,
          data: thisData,
          dataType: "json",
          beforeSend: function(){
          },
          success: function(pRespuesta) {
			  propiedades = pRespuesta;
			  if (propiedades.success === 1) {
				thisSuccess(propiedades);                                                            
			  } else {
				thisError(propiedades);
			  }
		  },
          error: function() {
          },
          complete: function() {
          }
      });
}
;
