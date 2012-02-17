function img_resize_normal(w, text){
  for (i=0;i<document.images.length;i++)
   {
   if (document.all){
	if (document.images[i].width>w || document.images[i].style.width>w)
	 {
	    var newHeight=document.images[i].height*w/document.images[i].width;
	    document.images[i].width=w;
	    document.images[i].height=newHeight;
	    document.images[i].style.width=w;
	    document.images[i].style.height=newHeight;  
       try{
	       document.images[i].outerHTML='<a href="'+document.images[i].src+'" target="_blank" title="'+text+'">'+document.images[i].outerHTML+'</a>';
  	 	}catch(e){}
  	 }
   }
  else{
	if (document.images[i].width>w || document.images[i].style.width>w) {
	  document.images[i].title=text;
	  document.images[i].style.cursor="pointer";
	    var newHeight=document.images[i].height*w/document.images[i].width;
	    document.images[i].width=w;
	    document.images[i].height=newHeight;
            $(document.images[i]).css({'width': w, 'height':newHeight});
	  document.images[i].onclick=function(e){window.open(this.src)};
	}
  }
  }
}
function img_resize_lightbox(w){
  $('img').each(function(){
    var myw = $(this).width();
    var myh = $(this).height();
    if(myw > w)
    {
	var newh = myh * w / myw;
        $(this).attr({'width': w, 'height': newh});
        $(this).css({'width': w, 'height': newh});

        $(this).wrap('<a href="' + $(this).attr('src') + '" class="lightbox"></a>');
    }
  });
 $('a.lightbox').rlightbox();
}
