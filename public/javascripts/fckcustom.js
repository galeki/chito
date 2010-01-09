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
	['Image','Table','Rule','Smiley'],['SyntaxHighlighter', 'Latex_Formula'], ['wpmore']
	//['Image','Table','Rule','Smiley'],['wpmore']
	,'/',
	['Style','FontFormat','FontName','FontSize'],
	['TextColor','BGColor'],
	['FitWindow']
] ;

FCKConfig.ToolbarSets["Basic"] = [
	['Bold','-','TextColor','BGColor','Blockquote','-','Smiley']
] ;
FCKConfig.ToolbarSets["Set"] = [
	['Insert_Code','Bold','Italic','-','TextColor','BGColor','-','Link','Unlink','-','Smiley','-']
] ;

FCKConfig.FlashUpload = false ;

FCKConfig.SmileyPath	= FCKConfig.BasePath + 'images/smiley/chito/' ;
FCKConfig.SmileyImages	= ['regular_smile.gif','sad_smile.gif','wink_smile.gif','teeth_smile.gif','confused_smile.gif','tounge_smile.gif','embaressed_smile.gif','omg_smile.gif','whatchutalkingabout_smile.gif','angry_smile.gif','angel_smile.gif','shades_smile.gif','devil_smile.gif','cry_smile.gif','lightbulb.gif','thumbs_down.gif','thumbs_up.gif','heart.gif','broken_heart.gif','kiss.gif','envelope.gif', 'icon_biggrin.gif', 'icon_confused.gif', 'icon_cool.gif', 'icon_cry.gif', 'icon_eek.gif', 'icon_lol.gif', 'icon_mad.gif', 'icon_neutral.gif', 'icon_question.gif', 'icon_razz.gif', 'icon_redface.gif', 'icon_rolleyes.gif', 'icon_sad.gif', 'icon_smile.gif', 'icon_surprised.gif', 'icon_wink.gif', '1.gif','2.gif','3.gif','4.gif','5.gif','6.gif','7.gif','8.gif','9.gif','10.gif','11.gif','12.gif','13.gif','14.gif','15.gif','16.gif','17.gif','18.gif','19.gif','20.gif','21.gif','22.gif','23.gif','24.gif','25.gif','26.gif','27.gif','28.gif','29.gif','30.gif','31.gif','32.gif','33.gif','34.gif','35.gif','36.gif','37.gif','38.gif','39.gif','40.gif','41.gif','42.gif','43.gif','44.gif','45.gif','46.gif','47.gif','48.gif','49.gif','50.gif','51.gif','52.gif','53.gif','54.gif','55.gif','56.gif','57.gif','58.gif','59.gif','60.gif','61.gif','62.gif','63.gif','64.gif','65.gif','66.gif'] ;
FCKConfig.SmileyColumns = 8 ;
FCKConfig.SmileyWindowWidth		= 630 ;
FCKConfig.SmileyWindowHeight	= 550 ;

FCKConfig.LinkUploadAllowedExtensions	= ".(7z|aiff|asf|avi|bmp|csv|doc|fla|flv|gif|gz|gzip|jpeg|jpg|mid|mov|mp3|mp4|mpc|mpeg|mpg|ods|odt|pdf|png|ppt|pxd|qt|ram|rar|rm|rmi|rmvb|rtf|sdc|sitd|swf|sxc|sxw|tar|tgz|tif|tiff|txt|vsd|wav|wma|wmv|xls|xml|zip|bz2|ico)$" ;
 
FCKConfig.TabSpaces = 8 ;
