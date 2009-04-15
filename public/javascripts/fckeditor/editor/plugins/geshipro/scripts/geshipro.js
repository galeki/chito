var FCKorig = window.parent.InnerDialogLoaded();
var FCK	= FCKorig.FCK ;
var FCKLang	= FCKorig.FCKLang;
var FCKConfig = FCKorig.FCKConfig;

window.addEvent('domready', function () {
	FCKorig.FCKLanguageManager.TranslatePage (document) ;
	window.parent.SetOkButton (true) ;
});

//#### Dialog Tabs
var tabs = ['SourceCode', 'Options'];

// Set the dialog tabs.
tabs.each(function(tab){
	var lang = 'Geshipro' + tab;
	window.parent.AddTab(tab, FCKLang[lang]);
})
	
// Function called when a dialog tag is selected.
function OnDialogTabChange(tabCode) {
	tabs.each(function(tab){
		$('div' + tab).setStyle('display', (tabCode == tab ? 'block' : 'none'));
	});
}

function ajaxResponse(response) {
	FCK.InsertHtml(response);
	//window.parent.close();
}
function set_cookie(name, value)
{
    var theCookie = name + "=" + encodeURIComponent(value);
    document.cookie = theCookie;
}
function get_cookie(searchName)
{
    var sRE = "(?:; )?" + searchName + "=([^;]*);?";
    var oRE = new RegExp(sRE);

    if(oRE.test(document.cookie)) {
	return decodeURIComponent(RegExp["$1"]);	
    }else {
	return null;
    }
}
form_field = ['lang', 'style', 'first_number', 'height', 'code_container', 'font-size', 'font-family'];
form_checkbox = ['is_bold', 'is_fixed', 'is_linenumber'];
function set_form_cookie()
{
    var form = document.forms["f1"];
    for (var i = 0; i < form_field.length; i++)
    {	
	var name = form_field[i];
	var val = form[name].value;
	set_cookie(name, val);
    }
    for (var i = 0; i < form_checkbox.length; i++)
    {	
	var name = form_checkbox[i];
	if (form[name].checked)
	{
	    set_cookie(name, 'true');
	}else{
	    set_cookie(name, 'false');
	}
    }
}
function set_form()
{
    var form = document.forms["f1"];
    for (var i = 0; i < form_field.length; i++)
    {	
	var name = form_field[i];
	var val = get_cookie(name);
	if(val)
	{
	    form[name].value = val;
	}
    }
    for (var i = 0; i < form_checkbox.length; i++)
    {
	var name = form_checkbox[i];
	var val = get_cookie(name);
	if(val)
	{
	    if(val=='true')
	    {
		form[name].checked = true;
	    }
	}
    }    
}
function get_hl(form)
{
    if(window.XMLHttpRequest){
	request=new XMLHttpRequest();
    }else{
	request=new ActiveXObject("Msxml2.XMLHTTP");
	if(!request){
	    request=new ActiveXObject("Microsoft.XMLHTTP");
	}
    }
    query=$('f1').toQueryString();
    request.open("POST",'/getgeshi.php',false);
    request.setRequestHeader("Content-Type","application/x-www-form-urlencoded; charset=UTF-8");
    request.send(query);
    FCK.InsertHtml(request.responseText);
}
function Ok() {
	// hier de highlighted content in de editor zetten.
	set_form_cookie();
	$('wait').setStyle('display', 'block');
	var form = $('f1');
	get_hl(form);
	return true;

}

