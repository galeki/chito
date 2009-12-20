var formSubmit = false;
function remote_form()
{
    var url = "/admin/remote_update";
    var form = document.getElementById('remote_form');
    new Ajax.Request(url, {asynchronous:true, evalScripts:true, parameters:Form.serialize(form)});
}
function bars_config(form, config)
{
    var config_data = '' ;
    for(i=0; i<config.length; i++ )
	config_data = config_data + '&' + Sortable.serialize(config[i]) ;
    return Form.serialize(form) + config_data	;
}
function navbars_config(form)
{
    return Form.serialize(form) + '&' + Sortable.serialize("enable") + '&' + Sortable.serialize("disable") ;
}
function postbars_config(form)
{
    return Form.serialize(form) + '&' + Sortable.serialize("enable") + '&' + Sortable.serialize("disable") ;
}
function filter_config(form)
{
    return Form.serialize(form) + '&' + Sortable.serialize("enable_filters") + '&' + Sortable.serialize("disable_filters") ;
}
function unload_form()
{
    if(formSubmit)
	return;
    else
	return away_text;
}
function go_to(url)
{
    location.replace(url);
}
function add_category_remote(category_name,token)
{
    if(category_name.length > 0){ 
	var url = '/admin/categories.js';
	var data = {'category[name]':  category_name,
		    '_method': "POST",
		    "authenticity_token": encodeURIComponent(token)};
	$('#_category_name').val("");
	$.post(url, data, function(data)
	{
	    eval(data);
	});
	//new Ajax.Request(url, {asynchronous:true, evalScripts:true, parameters:data});
    }
    return false;
}
function update_field()
{
    var oEditor = FCKeditorAPI.GetInstance('article_content');
    oEditor.UpdateLinkedField();
}
function change_list_by(e)
{
    var url = e.options[e.selectedIndex].value;
    location.replace(url);
}
function clean_category_field()
{
    $('category_name').value='';
    $('category_info').value='';
}
function clean_link_field()
{
    $('link_title').value='';
    $('link_info').value='';
    $('link_url').value='';
}
function check_url(url, t1, t2)
{
    var re = /^http:\/\/[\w\/\.-]+/
    if(!url)	
	alert(t1);
    else if(re.test(url))
	return true;
    else{
	alert(t2);
	return false;
    }
}
function add_tag(tag)
{
    var tag_list = document.getElementById('article_tag_list');
    if(tag_list.value.length == 0)
    {
	tag_list.value = tag_list.value + tag;
    }
    else
    {
	tag_list.value = tag_list.value + ', ' + tag;
    }
}
function select_menu(main_menu_id, controller)
{
    var sub_menu_id = controller;
    var menu = $(main_menu_id);
    if(menu){ menu.addClassName("selected");}
    menu = $(sub_menu_id);
    if(menu){ menu.addClassName("selected");}

}
function submit_as(type, form)
{
    formSubmit=true;
    form.action = form.action.replace(/posts|drafts|pages/, type);
    form.submit();
}
function checkall(trigger, form) 
{
    for(var e = 0; e < form.elements.length; e++)
    {
	var v = form.elements[e];
	v.checked = form.elements[trigger].checked;
    }
}

function autosaving(text)
{
   $("article_autosave_notifier").innerHTML = "<span id='autosaving'>" + text + "</span>";
}
function autosave_ok(text)
{
   var now = new Date();
   $("article_autosave_notifier").innerHTML = "<span id='autosave_ok'>" + text + " " + now.getHours() + ":" + now.getMinutes() +  "</span>";
   new Effect.Highlight("article_autosave_notifier", { startcolor: '#ffff00', endcolor: '#ffffff', duration: 3 });
}
function autosave_fail(text)
{
   $("article_autosave_notifier").innerHTML = "<span id='autosave_fail'>" + text + "</span>";
}
