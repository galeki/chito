FCKCommands.RegisterCommand( 'SyntaxHighlighter', new FCKDialogCommand( 'SyntaxHighlighter', FCKLang['SyntaxHighlighterTitle'], FCKConfig.PluginsPath + 'syntaxhighlighter/syntaxhighlighter.html', 600, 600 ) )
var oSyntaxHighlighter = new FCKToolbarButton('SyntaxHighlighter', FCKLang['SyntaxHighlighterTitle'],FCKLang['SyntaxHighlighterTitle'],FCK_TOOLBARITEM_ICONTEXT,null,null);
oSyntaxHighlighter.IconPath = FCKConfig.PluginsPath + 'syntaxhighlighter/toolbar.png';
FCKToolbarItems.RegisterItem( 'SyntaxHighlighter', oSyntaxHighlighter );

