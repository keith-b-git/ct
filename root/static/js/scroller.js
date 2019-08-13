var scrolling = null;
$(document).ready(function(){
	$(".sb_link").mouseenter(function() { 
		d = $(this);
		d.scrollTop(d.scrollTop() + 5) ;
		scrolling = window.setTimeout(function() {
	                scroll_down(d);
	            }, 100);
	        }
	     
	 )
	 

	$(".sb_link").mouseleave(function() { 
		$(this).scrollTop(0);
		window.clearTimeout(scrolling);
		}
	); 
});
$(document).ready(function(){
	$(".shop_item_content").mouseenter(function() { 
		d = $(this);
		d.scrollTop(d.scrollTop() + 5) ;
		scrolling = window.setTimeout(function() {
	                scroll_down(d);
	            }, 100);
	        }
	     
	 )
	 

	$(".shop_item_content").mouseleave(function() { 
		$(this).scrollTop(0);
		window.clearTimeout(scrolling);
		}
	); 
});
function scroll_down(d) {
	var c = d.scrollTop();
	d.scrollTop(c + 5) ;
	if (d.scrollTop() > c) {
		scrolling = window.setTimeout(function() {
					scroll_down(d);
	            }, 100);
		}
}
