/*
Copyright (c) 2003-2010, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/

/**
 * Documentation:
 * http://docs.cksource.com/ckeditor_api/symbols/CKEDITOR.config.html
 */

CKEDITOR.editorConfig = function(config) {
        //config.baseHref = "";
	// The minimum editor width, in pixels, when resizing it with the resize handle.
	config.resize_minWidth = 450;


	// Define toolbars, you can remove or add buttons.
	// List of all buttons is here: http://docs.cksource.com/ckeditor_api/symbols/CKEDITOR.config.html#.toolbar_Full

	config.toolbar_Basic = [ [ 'Bold', 'Italic', '-', 'NumberedList','BulletedList', '-', 'Link', 'Unlink', 'Image' ] ];

	config.toolbar_Full = [
			['Source'],
			['Cut','Copy','Paste','PasteText','PasteFromWord','-','SpellChecker', 'Scayt'],
			['Undo','Redo','Find','Replace','-','SelectAll','RemoveFormat'],
			['Image','Flash','Table','HorizontalRule','Smiley','SpecialChar'],
			'/',
			['Bold','Italic','Underline','Strike','-','Subscript','Superscript'],
			['NumberedList','BulletedList','-','Outdent','Indent','Blockquote'],
			['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
			['Link','Unlink','Anchor'],
			'/',
			['Format','Font','FontSize'],
			['TextColor','BGColor'],
			['Maximize', 'ShowBlocks'], ['WPMore'], ['SyntaxHighlighter'],['LatexFormula']
		 ];
        config.contentsCss = "/javascripts/ckeditor_plugins/contents.css";

        config.filebrowserBrowseUrl = "/admin/files/list?type=File&editor=1";
        config.filebrowserImageBrowseUrl = "/admin/files/list?type=Image&editor=1";
        config.filebrowserUploadUrl = "/admin/files/create_file?type=File&editor=1";
        config.filebrowserImageUploadUrl = "/admin/files/create_file?type=Image&editor=1";

        config.filebrowserWindowWidth = "640";
        config.filebrowserWindowHeight = "480";
        config.filebrowserImageWindowWidth = "640";
        config.filebrowserImageWindowHeight = "480";
	// mediaembed plugin
	// config.extraPlugins += (config.extraPlugins ? ',mediaembed' : 'mediaembed' );
	// CKEDITOR.plugins.addExternal('mediaembed', ckeditorSettings.pluginPath + 'plugins/mediaembed/');
        config.extraPlugins += (config.extraPlugins ? ',wpmore,syntaxhighlighter,latexformula' : 'wpmore,syntaxhighlighter,latexformula' );
        CKEDITOR.plugins.addExternal('wpmore',  '/javascripts/ckeditor_plugins/wpmore/');
        CKEDITOR.plugins.addExternal('syntaxhighlighter',  '/javascripts/ckeditor_plugins/syntaxhighlighter/');
        CKEDITOR.plugins.addExternal('latexformula',  '/javascripts/ckeditor_plugins/latexformula/');
};
