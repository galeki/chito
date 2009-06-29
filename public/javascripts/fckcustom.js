FCKRelativePath = '';

FCKConfig.LinkBrowserURL = FCKConfig.BasePath + 'filemanager/browser/default/browser.html?Type=File&Connector='+FCKRelativePath+'/fckeditor/command';
FCKConfig.ImageBrowserURL = FCKConfig.BasePath + 'filemanager/browser/default/browser.html?Type=Image&Connector='+FCKRelativePath+'/fckeditor/command';
FCKConfig.FlashBrowserURL = FCKConfig.BasePath + 'filemanager/browser/default/browser.html?Type=Flash&Connector='+FCKRelativePath+'/fckeditor/command';

FCKConfig.LinkUploadURL = FCKRelativePath+'/fckeditor/upload?Type=File';
FCKConfig.ImageUploadURL = FCKRelativePath+'/fckeditor/upload?Type=Image';
FCKConfig.FlashUploadURL = FCKRelativePath+'/fckeditor/upload?Type=Flash';
FCKConfig.AllowQueryStringDebug = false;
FCKConfig.SpellChecker = 'SpellerPages';

FCKConfig.SkinPath = FCKConfig.BasePath + 'skins/silver/';

FCKConfig.EditorAreaCSS = FCKConfig.BasePath + 'css/fck_editorarea.css' ;
FCKConfig.SourcePopup	= true ;

FCKConfig.Plugins.Add( 'wpmore');
//
FCKConfig.Plugins.Add( 'latexformula' ) ;
FCKConfig.Plugins.Add( 'syntaxhighlighter', 'zh,en') ;
FCKConfig.Plugins.Add( 'geshipro', 'zh' ) ;
//
FCKConfig.ToolbarSets["Default"] = [
	['Source','Undo','Redo'],
	['Bold','Italic','Underline','StrikeThrough','-','Subscript','Superscript'],['Templates'],
	['OrderedList','UnorderedList','-','Outdent','Indent','Blockquote'],
	['JustifyLeft','JustifyCenter','JustifyRight','JustifyFull'],
	['Link','Unlink','Anchor'],
	['Image','Table','Rule','Smiley'],['GeSHiPro','SyntaxHighlighter', 'Latex_Formula'], ['wpmore']
	//['Image','Table','Rule','Smiley'],['wpmore']
	,'/',
	['Style','FontFormat','FontName','FontSize'],
	['TextColor','BGColor'],
	['FitWindow']
] ;

FCKConfig.ToolbarSets["Basic"] = [
	//['GeSHiPro','Bold','-','TextColor','BGColor','Blockquote','-','Smiley','-','Latex_Formula']
	['Bold','-','TextColor','BGColor','Blockquote','-','Smiley']
] ;
FCKConfig.ToolbarSets["Set"] = [
	['Insert_Code','Bold','Italic','-','TextColor','BGColor','-','Link','Unlink','-','Smiley','-']
] ;

FCKConfig.FlashUpload = false ;

FCKConfig.SmileyPath	= FCKConfig.BasePath + 'images/smiley/chito/' ;
FCKConfig.SmileyImages	= ['regular_smile.gif','sad_smile.gif','wink_smile.gif','teeth_smile.gif','confused_smile.gif','tounge_smile.gif','embaressed_smile.gif','omg_smile.gif','whatchutalkingabout_smile.gif','angry_smile.gif','angel_smile.gif','shades_smile.gif','devil_smile.gif','cry_smile.gif','lightbulb.gif','thumbs_down.gif','thumbs_up.gif','heart.gif','broken_heart.gif','kiss.gif','envelope.gif', 'icon_biggrin.gif', 'icon_confused.gif', 'icon_cool.gif', 'icon_cry.gif', 'icon_eek.gif', 'icon_lol.gif', 'icon_mad.gif', 'icon_neutral.gif', 'icon_question.gif', 'icon_razz.gif', 'icon_redface.gif', 'icon_rolleyes.gif', 'icon_sad.gif', 'icon_smile.gif', 'icon_surprised.gif', 'icon_wink.gif', '1.gif','2.gif','3.gif','4.gif','5.gif','6.gif','7.gif','8.gif','9.gif','10.gif','11.gif','12.gif','13.gif','14.gif','15.gif','16.gif','17.gif','18.gif','19.gif','20.gif','21.gif','22.gif','23.gif','24.gif','25.gif','26.gif','27.gif','28.gif','29.gif','30.gif'] ;
FCKConfig.SmileyColumns = 8 ;
FCKConfig.SmileyWindowWidth		= 630 ;
FCKConfig.SmileyWindowHeight	= 550 ;

FCKConfig.LinkUploadAllowedExtensions	= ".(7z|aiff|asf|avi|bmp|csv|doc|fla|flv|gif|gz|gzip|jpeg|jpg|mid|mov|mp3|mp4|mpc|mpeg|mpg|ods|odt|pdf|png|ppt|pxd|qt|ram|rar|rm|rmi|rmvb|rtf|sdc|sitd|swf|sxc|sxw|tar|tgz|tif|tiff|txt|vsd|wav|wma|wmv|xls|xml|zip|bz2|ico)$" ;
 
FCKConfig.TabSpaces = 8 ;
