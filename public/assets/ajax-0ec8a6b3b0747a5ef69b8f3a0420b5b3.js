(function($){
	$(document).ready(function(){
		$('ul.dropdown-menu [data-toggle=dropdown]').on('click', function(event) {
			event.preventDefault(); 
			event.stopPropagation(); 
			$(this).parent().siblings().removeClass('open');
			$(this).parent().toggleClass('open');
		});
	});
})(jQuery);

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
;
