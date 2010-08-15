(function() {
/*
Copyright (c) 2003-2010, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/

CKEDITOR.plugins.add( 'latexformula',
{
	requires: [ 'iframedialog' ],
	init : function( editor )
	{
		var me = this;
		CKEDITOR.dialog.add( 'LatexFormulaDialog', function (){
			return {
				title : 'Latex Formula Dialog',
				minWidth : 350,
				minHeight : 200,
				contents :
					[
						{
							id : 'iframe',
							label : 'LatexFormula',
							expand : true,
							elements :
								[
									{
										type : 'html',
										id : 'pageSyntaxHighlighter',
										label : 'SyntaxHighlighter',
										style : 'width : 350px;height: 200px;',
										html : '<iframe src="'+me.path+'dialog.html" frameborder="0" name="iframeLatex" id="iframeLatex" allowtransparency="1" style="width:100%;height:190px;margin:0;padding:0;"></iframe>'
									}
								]
						}
					],
				onOk : function() {
					var editor = this.getParentEditor();

                                        var frame_doc = document.getElementById('iframeLatex').contentWindow.document;

                                        var formula = frame_doc.getElementById('formula');
                                        if(formula)
	                                    editor.insertHtml(formula.innerHTML);
				}
			};
		});


		// Register the toolbar buttons.
		editor.ui.addButton( 'LatexFormula',
			{
				label : 'LatexFormula',
				icon : this.path + 'toolbar.gif',
				command : 'latexformula'
			});

		// Register the commands.
		editor.addCommand( 'latexformula', new CKEDITOR.dialogCommand( 'LatexFormulaDialog' ));
	}
});
})();
