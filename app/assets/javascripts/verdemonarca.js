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


// Function to watch for attribute changes
// http://darcyclarke.me/development/detect-attribute-changes-with-jquery
$.fn.watch = function(props, callback, timeout){
    if(!timeout)
        timeout = 10;
    return this.each(function(){
        var el         = $(this),
            func     = function(){ __check.call(this, el) },
            data     = {    props:     props.split(","),
                        func:     callback,
                        vals:     [] };
        $.each(data.props, function(i) { data.vals[i] = el.attr(data.props[i]); });
        el.data(data);
        if (typeof (this.onpropertychange) == "object"){
            el.bind("propertychange", callback);
        } else if ($.browser.mozilla){
            el.bind("DOMAttrModified", callback);
        } else {
            setInterval(func, timeout);
        }
    });
    function __check(el) {
        var data     = el.data(),
            changed = false,
            temp    = "";
        for(var i=0;i < data.props.length; i++) {
            temp = el.attr(data.props[i]);
            if(data.vals[i] != temp){
                data.vals[i] = temp;
                changed = true;
                break;
            }
        }
        if(changed && data.func) {
            data.func.call(el, data);
        }
    }
}


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