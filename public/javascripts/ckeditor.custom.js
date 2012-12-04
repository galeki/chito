/*
Copyright (c) 2003-2010, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/

/**
 * Documentation:
 * http://docs.cksource.com/ckeditor_api/symbols/CKEDITOR.config.html
 */

CKEDITOR.editorConfig = function(config) {

    config.resize_minWidth = 450;
    config.skin = 'kama';

    config.toolbar = [
            ['Source'],
            ['Bold','Italic','Underline','Strike','-','Subscript','Superscript'],
            ['Undo','Redo','Find'],
            ['Image'],['Flash','Table','HorizontalRule','Smiley','SpecialChar'],
            ['NumberedList','BulletedList'],
            ['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
            ['Link','Unlink','Anchor'],
            '/',
            ['Format','Styles','Font','FontSize'],
                        ['Outdent','Indent','Blockquote'],
            ['TextColor','BGColor'],
            ['Maximize', 'ShowBlocks'], ['WPMore'], ['SyntaxHighlighter'], ['Autosave']
         ];
        config.contentsCss = "/javascripts/ckeditor_plugins/contents.css";

        config.filebrowserBrowseUrl = "/admin/files/list?type=File&editor=1";
        config.filebrowserImageBrowseUrl = "/admin/files/list?type=Image&editor=1";
        config.filebrowserUploadUrl = "/admin/files/create_file?type=File&editor=1";
        config.filebrowserImageUploadUrl = "/admin/files/create_file?type=Image&editor=1";

        config.filebrowserWindowWidth = "850";
        config.filebrowserWindowHeight = "500";
        config.filebrowserImageWindowWidth = "850";
        config.filebrowserImageWindowHeight = "500";

        config.smiley_path = "/images/smiley/chito/";
        config.smiley_images = ['regular_smile.gif','sad_smile.gif','wink_smile.gif','teeth_smile.gif','confused_smile.gif','tounge_smile.gif','embaressed_smile.gif','omg_smile.gif','whatchutalkingabout_smile.gif','angry_smile.gif','angel_smile.gif','shades_smile.gif','devil_smile.gif','cry_smile.gif','lightbulb.gif','thumbs_down.gif','thumbs_up.gif','heart.gif','broken_heart.gif','kiss.gif','envelope.gif', 'icon_biggrin.gif', 'icon_confused.gif', 'icon_cool.gif', 'icon_cry.gif', 'icon_eek.gif', 'icon_lol.gif', 'icon_mad.gif', 'icon_neutral.gif', 'icon_question.gif', 'icon_razz.gif', 'icon_redface.gif', 'icon_rolleyes.gif', 'icon_sad.gif', 'icon_smile.gif', 'icon_surprised.gif', 'icon_wink.gif', '1.gif','2.gif','3.gif','4.gif','5.gif','6.gif','7.gif','8.gif','9.gif','10.gif','11.gif','12.gif','13.gif','14.gif','15.gif','16.gif','17.gif','18.gif','19.gif','20.gif','21.gif','22.gif','23.gif','24.gif','25.gif','26.gif','27.gif','28.gif','29.gif','30.gif','31.gif','32.gif','33.gif','34.gif','35.gif','36.gif','37.gif','38.gif','39.gif','40.gif','41.gif','42.gif','43.gif','44.gif','45.gif','46.gif','47.gif','48.gif','49.gif','50.gif','51.gif','52.gif','53.gif','54.gif','55.gif','56.gif','57.gif','58.gif','59.gif','60.gif','61.gif','62.gif','63.gif','64.gif','65.gif','66.gif'] ;
    // mediaembed plugin
    // config.extraPlugins += (config.extraPlugins ? ',mediaembed' : 'mediaembed' );
    // CKEDITOR.plugins.addExternal('mediaembed', ckeditorSettings.pluginPath + 'plugins/mediaembed/');
        config.extraPlugins += (config.extraPlugins ? ',wpmore,syntaxhighlighter,autosave' : 'wpmore,syntaxhighlighter,autosave' );
        CKEDITOR.plugins.addExternal('wpmore',  '/javascripts/ckeditor_plugins/wpmore/');
        CKEDITOR.plugins.addExternal('syntaxhighlighter',  '/javascripts/ckeditor_plugins/syntaxhighlighter/');
        CKEDITOR.plugins.addExternal('autosave',  '/javascripts/ckeditor_plugins/autosave/');

        config.smiley_columns = 12;
        //config.ignoreEmptyParagraph = false;
       
        config.autosaveTargetUrl = "autosave.xml";
        config.autosaveRefreshTime = 300;
        config.autosaveRequestTimeout = 120;
        config.autosaveUseOnBeforeUnload = false;
        //config.autosaveMinTimeBetweenRequests =30;
};
