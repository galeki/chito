var CKEDITOR_PLUGINS_LANG = {};
var CKEDITOR_LANG_CODE = "";
if(window.parent)
    CKEDITOR_LANG_CODE = window.parent.CKEDITOR.instances['article_content'].langCode;

function _t(key)
{
    if(CKEDITOR_LANG_CODE.length == 0)
        return null;
    if(CKEDITOR_PLUGINS_LANG[CKEDITOR_LANG_CODE])
    {
        return CKEDITOR_PLUGINS_LANG[CKEDITOR_LANG_CODE][key];
    }else
    {
        return null;
    }
}

function _trans_all()
{
    $('.trans_rq').each(function(){
        var key = $(this).attr('trans_id');
        var transed = _t(key);
        if(key && transed)
        {
            if($(this).attr('value'))
                $(this).val(transed);
            else
                $(this).text(transed);
        }
    });
}

