function Ajax(thisData, thisLocation,thisSuccess, thisError){
    $.ajax({
          type: "POST",
          url: thisLocation,
          data: thisData,
          dataType: "json",
          beforeSend: function(){
	    
          },
          success: function(pResponse) {
			  if (pResponse.success === 1) {
				thisSuccess(pResponse);                                                            
			  } else {
				thisError(pResponse);
			  }
		  },
          error: function() {
	    
          },
          complete: function() {
	    
          }
    });
}