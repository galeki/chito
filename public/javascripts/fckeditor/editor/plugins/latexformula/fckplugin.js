FCKCommands.RegisterCommand( 'Latex_Formula', new FCKDialogCommand( 'Latex_Formula', 'tex数学公式', FCKConfig.PluginsPath + 'latexformula/latexformula.html', 500, 300 ) )
var oLatexFormula = new FCKToolbarButton('Latex_Formula', 'tex数学公式','tex数学公式',FCK_TOOLBARITEM_ICONTEXT,null,null);
oLatexFormula.IconPath = FCKConfig.PluginsPath + 'latexformula/toolbar.gif';
FCKToolbarItems.RegisterItem( 'Latex_Formula', oLatexFormula );

