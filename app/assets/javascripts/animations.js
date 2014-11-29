jQuery(document).ready(function($) {

	//Only animate elements when using non-mobile devices    
    if (jQuery.browser.mobile === false) {

    	/* Animate elements in Features Wrap */
        $('.featureswrap img.left').css('opacity', 0).one('inview', function(isInView) {
            if (isInView) {$(this).addClass('animated fadeInLeftBig delayp1');}
        });
        $('.featureswrap img.right').css('opacity', 0).one('inview', function(isInView) {
            if (isInView) {$(this).addClass('animated fadeInRightBig delayp1');}
        });

    }

});