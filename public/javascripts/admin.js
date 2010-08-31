var formSubmit = false;
var index_list = {};
function remote_form(index)
{
    var url = "/admin/remote_update";
    if(index >= 0)
        url += "?index_id=" + index;

    $.post(url, $('#remote_form').find('input').serialize() + '&' + $('#remote_form').find('textarea').serialize()  , function(data)
    {
	eval(data);
    });
}
function open_remote_form(options)
{
        var dialog = $('<div></div>');
	dialog.ajaxComplete(function() {                         
			dialog.dialog( {  
				modal: true,  
				buttons: {  
				    "Save": function(){  
					    remote_form(options['index']);  
					    $(this).html("");
					    $(this).dialog("close");  
                                            $(this).remove();
				    },  
				    "Cancel": function(){  
					$(this).html("");
					$(this).dialog("close");  
                                        $(this).remove();
				    }  
				},
				title: options['title'],
				width: options['width']
			});

		});
        dialog.load(
                     options['url'], 
                     function (data) {
			dialog.html(data);

                     }
                   );
}
function append_data_str_to_form(form, data_str)
{
    var pary = data_str.split('&');
    for(i=0; i<pary.length; i++)
    {
        if(pary[i].length > 0)
        {
            var p = pary[i].split('=');
            if(p.length == 2 && p[0].length > 0 && p[1].length > 0)
            {
                var hfield = document.createElement("input");
                hfield.setAttribute("type", "hidden");
                hfield.setAttribute("name", p[0]);
                hfield.setAttribute("value", p[1]);

                form.appendChild(hfield);
            }
        }
    }
}
function sortable_serialize(config)
{
    
    return $('#' + config).sortable('serialize',{key:(config + '[]'), expression:/^bar_(.*)$/});
}
function sidebars_config(form, config)
{
    var config_data = '' ;
    for(i=0; i<config.length; i++ )
	config_data = config_data + '&' + sortable_serialize(config[i]) ;

    append_data_str_to_form(form, config_data);
}

function navbars_config(form)
{
    var config_data = sortable_serialize("enable") + '&' + sortable_serialize("disable") ;
    append_data_str_to_form(form, config_data);
}
function postbars_config(form)
{
    var config_data = sortable_serialize("enable") + '&' + sortable_serialize("disable") ;
    append_data_str_to_form(form, config_data);
}
function filter_config(form)
{
    var config_data = sortable_serialize("enable_filters") + '&' + sortable_serialize("disable_filters") ;
    append_data_str_to_form(form, config_data);
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
	$.post(url, data);
	//new Ajax.Request(url, {asynchronous:true, evalScripts:true, parameters:data});
    }
    return false;
}
function update_field()
{
    CKEDITOR.instances['article_content'].updateElement();
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
function article_content_not_blank()
{
    update_field();
    var article_content = "not blank";
    var e = document.getElementById('article_content');
    if(e)
        article_content = e.value;

    var strip_content = article_content.replace(/<p>&#160;<\/p>/g,'').replace(/<p>&nbsp;<\/p>/g,'');
    //alert(strip_content.length);
    if(strip_content.length == 0)
        return false;

    return true;
}
function submit_as(type, form, cf_text)
{
    if(article_content_not_blank() || confirm(cf_text))
    {
        formSubmit=true;
        form.action = form.action.replace(/posts|drafts|pages/, type);
        form.submit();
    }
}
function submit_and_edit(form, cf_text)
{
    if(article_content_not_blank() || confirm(cf_text))
    {
        formSubmit=true;
        form.action += '?continue_editing=1';
        form.submit();
    }
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
   var hours = (now.getHours() < 10 ? "0" + now.getHours() : now.getHours());
   var mins = (now.getMinutes() < 10 ? "0" + now.getMinutes() : now.getMinutes());
   $("#article_autosave_notifier").html("<span id='autosave_ok'>" + text + " " + hours + ":" + mins +  "</span>");
   $("#article_autosave_notifier").highlight({ startcolor: '#ffff00', endcolor: '#ffffff', duration: 10 });
}
function autosave_fail(text)
{
   $("#article_autosave_notifier").html("<span id='autosave_fail'>" + text + "</span>");
}
function change_api_status(ck, url)
{
    if(ck.checked)
    {
        url += "?" + "enable=true"; 
    }else
    {
        url += "?" + "enable=false"; 
    }
    $.post(url, {});
}
