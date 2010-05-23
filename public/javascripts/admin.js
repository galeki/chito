var formSubmit = false;
var index_list = {};
function remote_form(index)
{
    var url = "/admin/remote_update";
    if(index >= 0)
        url += "?index_id=" + index;
    //alert($('#remote_form').find('input').serialize() + $('#remote_form').find('textarea').serialize());
    $.post(url, $('#remote_form').find('input').serialize() + '&' + $('#remote_form').find('textarea').serialize()  , function(data)
    {
	eval(data);
    });
}
function open_remote_form(options)
{
	//var url = this.href;
        var dialog = $('<div style="display:hidden"></div>').appendTo('body');
                        // load remote content
	dialog.ajaxComplete(function() {                         
			dialog.dialog( {  
				modal: true,  
				buttons: {  
				    "Save": function(){  
					    remote_form(options['index']);  
					    $(this).html("");
					    $(this).dialog("close");  
				    },  
				    "Cancel": function(){  
					$(this).html("");
					$(this).dialog("close");  
				    }  
				},
				title: options['title'],
				width: options['width']
			})
		});
        dialog.load(
                     options['url'], 
                     function (data) {
			dialog.html(data);

                     }
                   );
}
function sortable_serialize(config)
{
    return $('#' + config).sortable('serialize',{key:(config + '[]'), expression:/^bar_(.*)$/});
}
function form_serialize(form)
{
    return ( $('form').find('input').serialize());
}
function bars_config(form, config)
{
    var config_data = '' ;
    for(i=0; i<config.length; i++ )
	config_data = config_data + '&' + sortable_serialize(config[i]) ;
    return ( form_serialize(form) + config_data	);
}

function navbars_config(form)
{
    return form_serialize(form) + '&' + sortable_serialize("enable") + '&' + sortable_serialize("disable") ;
}
function postbars_config(form)
{
    return form_serialize(form) + '&' + sortable_serialize("enable") + '&' + sortable_serialize("disable") ;
}
function filter_config(form)
{
    return form_serialize(form) + '&' + sortable_serialize("enable_filters") + '&' + sortable_serialize("disable_filters") ;
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
function show_index_info(e)
{
    var key = e.options[e.selectedIndex].value;
    var url = index_list[key]['url'];
    var info = index_list[key]['info'];
    var theme = index_list[key]['theme'];
    var avatar = index_list[key]['avatar'];
    $('#index_url').html("<a href='http://" + url + "' target='_blank'>http://" + url + "</a>");
    $('#index_info').html(info);
    $('#index_img').html("<img width='60' height='60' src='" + avatar + "' />");
}
function clean_category_field()
{
    $('#category_name').val("");
    $('#category_info').val("");
}
function clean_link_field()
{
    $('#link_title').val("");
    $('#link_info').val("");
    $('#link_url').val("");
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

    $('#' + main_menu_id).addClass("selected");
    $('#' + sub_menu_id).addClass("selected");

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
   $("#article_autosave_notifier").html("<span id='autosaving'>" + text + "</span>");
}
function autosave_ok(text)
{
   var now = new Date();
   $("#article_autosave_notifier").html("<span id='autosave_ok'>" + text + " " + now.getHours() + ":" + now.getMinutes() +  "</span>");
   $("#article_autosave_notifier").highlight({ startcolor: '#ffff00', endcolor: '#ffffff', duration: 10 });
}
function autosave_fail(text)
{
   $("#article_autosave_notifier").html("<span id='autosave_fail'>" + text + "</span>");
}
