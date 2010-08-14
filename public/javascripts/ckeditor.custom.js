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
			['Maximize', 'ShowBlocks'], ['WPMore'], ['SyntaxHighlighter']
		 ];
	// mediaembed plugin
	// config.extraPlugins += (config.extraPlugins ? ',mediaembed' : 'mediaembed' );
	// CKEDITOR.plugins.addExternal('mediaembed', ckeditorSettings.pluginPath + 'plugins/mediaembed/');
        config.extraPlugins += (config.extraPlugins ? ',wpmore,syntaxhighlighter' : 'wpmore,syntaxhighlighter' );
        CKEDITOR.plugins.addExternal('wpmore',  '/javascripts/ckeditor_plugins/wpmore/');
        CKEDITOR.plugins.addExternal('syntaxhighlighter',  '/javascripts/ckeditor_plugins/syntaxhighlighter/');
};
