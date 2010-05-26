var post_show = false;
var insert = false;
var g_user_name, g_time, g_id, g_text;
var FCKeditorAPI = null;
function set_cookie(name, value)
{
    var theCookie = name + "=" + encodeURIComponent(value);
    document.cookie = theCookie;
}
function change_list_by(e)
{
    var url = e.options[e.selectedIndex].value;
    location.replace(url);
}
function insert_cite(user_name, time, id, text)
{
    if(!post_show)
    {
	g_user_name = user_name;
	g_time = time;
	g_id = id;
	g_text = text;
	insert = true;
	show_editor();
    }else
	 _insert_cite(user_name, time, id, text)
}
function _insert_cite(user_name, time, id, text)
{
    if(!post_show)
	show_editor();
    var cite_info = document.getElementById(id).innerHTML;
    var cite = "<div class='cite_box'><div class='cite_header'>" + text  + 
    "<a>" + user_name + "</a>" +
    " @ " + "<small>" + time + "</small>" +
    "</div>" + cite_info + "</div>";
    var oEditor = FCKeditorAPI.GetInstance('comment_content');
    oEditor.InsertHtml(cite);
}
function clean_field()
{
    if(FCKeditorAPI)
    {
	var oEditor = FCKeditorAPI.GetInstance('comment_content');
	oEditor.SetHTML("");
    }else
    {
	var e = document.getElementById('comment_content');
	e.value = '';
    }
}
function update_field()
{
    if(FCKeditorAPI)
    {
	var oEditor = FCKeditorAPI.GetInstance('comment_content');
	oEditor.UpdateLinkedField();
    }
    
}
function show_editor()
{
    var e0 = document.getElementById('comment_editor_button');
    e0.style.display="none";
    var e1 = document.getElementById('comment_mode');
    e1.value = "html";
    var oFCKeditor = new FCKeditor('comment_content', '90%', '250px', 'Basic');
    oFCKeditor.BasePath = "/javascripts/fckeditor/"
    oFCKeditor.Config['CustomConfigurationsPath'] = '../../fckcustom.js';
    oFCKeditor.ReplaceTextarea();
    post_show = true;
}
function FCKeditor_OnComplete( editorInstance )
{
    if(insert)
	_insert_cite(g_user_name, g_time, g_id, g_text);
}
function re_captcha()
{
   //new Ajax.Updater('show_simple_captcha', '/simple_captcha_ajax', {asynchronous:true, evalScripts:true}); 
    $('#show_simple_captcha').load('/simple_captcha_ajax');

}
function ReImgSize(w, text){
  for (i=0;i<document.images.length;i++)
   {
   if (document.all){
	if (document.images[i].width>w)
	 {
	    newHeight=document.images[i].height*w/document.images[i].width;
	    document.images[i].width=w;
	    document.images[i].height=newHeight;
       try{
	       document.images[i].outerHTML='<a href="'+document.images[i].src+'" target="_blank" title="'+text+'">'+document.images[i].outerHTML+'</a>';
  	 	}catch(e){}
  	 }
   }
  else{
	if (document.images[i].width>w) {
	  document.images[i].title=text;
	  document.images[i].style.cursor="pointer";
	    newHeight=document.images[i].height*w/document.images[i].width;
	    document.images[i].width=w;
	    document.images[i].height=newHeight;  
	  document.images[i].onclick=function(e){window.open(this.src)};
	}
  }
  }
 }
function fix_comment_mode(){
	var e = document.getElementById('comment_mode');
	if(e)
	    e.value = 'plain';
        $("#comment_reply_to").val("");
        $("#comment_info").val("");
}
function setCaretAtEnd (field) {
   if (field.createTextRange) {
       var r = field.createTextRange();
       r.moveStart('character', field.value.length);
       r.collapse();
       r.select();
   }else
    field.focus();
}
function reply_to(s, id){
    var content;
    if(s){
	content = "@" + s + ": ";
	if(FCKeditorAPI){
	    var oEditor = FCKeditorAPI.GetInstance('comment_content');
	    if(oEditor.GetHtml != "")
		content = "<br/>" + content;
	    oEditor.InsertHtml(content);
	}else{
	    var e = document.getElementById('comment_content');
	    if(e)
	    {
		if(e && e.value != "")
		    content = "\n" + content;
		e.value += content;
	    }
	}
	window.location.hash="comment_writer";
	var e1 = document.getElementById('comment_content');
	setCaretAtEnd(e);
    }
    $("#comment_reply_to").val(id);
}
function reply_to_id(id)
{
    $("#post_comment").appendTo('#comment'+id+'  > div.comment_body');
    $("#comment_reply_to").val(id);
    $("#cancel_reply_link").show();

}
function cancel_reply_to_id()
{
    $("#cancel_reply_link").hide();
    $("#post_comment").insertAfter('#comments');
    $("#comment_reply_to").val("");
}
function thread_comment()
{
    $(".comment_reply").each(function() {
        $(this).appendTo("#comment"+ $(this).attr("reply_id"));
        $(this).addClass("reply_comment_box");
        $(this).find(".comments_count").html("");
    });
}
var rtlang = {'zh-CN':{}, 'en':{}};
rtlang['en']['less than a minute'] = 'less than a minute';
rtlang['en'][' minutes'] = ' minutes';
rtlang['en']['about 1 hour'] = 'about 1 hour';
rtlang['en'][' hour'] = ' hour';
rtlang['en']['1 day'] = '1 day';
rtlang['en'][' days'] = ' days';
rtlang['en']['about 1 month'] = 'about 1 month';
rtlang['en'][' months'] = ' months';
rtlang['en']['about 1 year'] = 'about 1 year';
rtlang['en'][' years'] = ' years';
rtlang['en'][' ago'] = ' ago';


rtlang['zh-CN']['less than a minute'] = '小于一分钟';
rtlang['zh-CN'][' minutes'] = ' 分钟';
rtlang['zh-CN']['about 1 hour'] = '大约 1 小时';
rtlang['zh-CN'][' hour'] = ' 小时';
rtlang['zh-CN']['1 day'] = '1 天';
rtlang['zh-CN'][' days'] = ' 天';
rtlang['zh-CN']['about 1 month'] = '大约 1 个月';
rtlang['zh-CN'][' months'] = ' 个月';
rtlang['zh-CN']['about 1 year'] = '大约 1 年';
rtlang['zh-CN'][' years'] = ' 年';
rtlang['zh-CN'][' ago'] = '前';

function relative_time_text(m, local){
    var text;
    if(!rtlang[local])
	local = 'en';

    if(m <= 1)
	text = rtlang[local]['less than a minute'];
    else if(m > 1 && m <= 45)
	text = m + rtlang[local][' minutes'];
    else if(m > 45 && m <= 90)
	text = rtlang[local]['about 1 hour'];
    else if(m > 90 && m <= 1440)
	text = Math.round(m/60) + rtlang[local][' hour'];
    else if(m > 1440 && m <= 2880)
	text = rtlang[local]['1 day'];
    else if(m > 2880 && m <= 43200)
	text = Math.round(m/1440)+ rtlang[local][' days'];
    else if(m > 43200 && m <= 86400)
	text = rtlang[local]['about 1 month'];
    else if(m > 86400 && m <= 525600)
	text = Math.round(m/43200) + rtlang[local][' months'];
    else if(m > 525600 && m <= 1051200)
	text = rtlang[local]['about 1 year'];
    else
	text = Math.round(m/525600) + rtlang[local][' years'];

    return text + rtlang[local][' ago'];
}
function _show_relative_time(selector, local){
    var now = new Date();
    $(selector).each(function(index){
	var t = new Date($(this).text());
	var diff = now - t;
	$(this).html(relative_time_text(Math.floor(Math.abs(diff/1000/60)), local))
    
    })
}
$(document).ready(fix_comment_mode)
