/*
Copyright (c) 2003-2010, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/

/**
 * @file Plugin for inserting Drupal teaser and page breaks.
 */
var WPMORE_COFIRME = {};
WPMORE_COFIRME['zh-cn'] = "文档中已经插入了一个 more 标记，删除并插入新标记吗？";
WPMORE_COFIRME['en'] = 'The document already contains a more. Do you want to proceed by removing it first?';
WPMORE_COFIRME['default'] = 'The document already contains a more. Do you want to proceed by removing it first?';
CKEDITOR.plugins.add( 'wpmore',
{
  requires  : [ 'fakeobjects', 'htmldataprocessor' ],

  init : function( editor )
  {
    // Add the styles that renders our fake objects.
    editor.addCss(
      'img.cke_wordpress_more' +
      '{' +
        'background-image: url(' + CKEDITOR.getUrl( this.path + 'images/more_bug.gif' ) + ');' +
        'background-position: right center;' +
        'background-repeat: no-repeat;' +
        'clear: both;' +
        'display: block;' +
        'float: none;' +
        'width: 100%;' +
        'border-top: #999999 1px dotted;' +
        'height: 10px;' +
      '}'
    );

    // Register the toolbar buttons.
    editor.ui.addButton( 'WPMore',
      {
        label : '&lt;!--More--&gt;',
        icon : this.path + 'images/more.gif',
        command : 'wpmore'
      });

    // Register the commands.

    editor.addCommand( 'wpmore',
    {
      exec : function()
      {
        // There should be only one <!--break--> in document. So, look
        // for an image with class "cke_drupal_break" (the fake element).
        var images = editor.document.getElementsByTag( 'img' );
        for ( var i = 0, len = images.count() ; i < len ; i++ )
        {
          var img = images.getItem( i );
          if ( img.hasClass( 'cke_wordpress_more' ) )
          {
            if ( confirm( WPMORE_COFIRME[editor.langCode] || WPMORE_COFIRME['default'] ) )
            {
              img.remove();
              break;
            }
            else
              return;
          }
        }

        insertComment( 'more' );
      }
    } );

    // This function effectively inserts the comment into the editor.
    function insertComment( text )
    {
      // Create the fake element that will be inserted into the document.
      // The trick is declaring it as an <hr>, so it will behave like a
      // block element (and in effect it behaves much like an <hr>).
      if ( !CKEDITOR.dom.comment.prototype.getAttribute ) {
        CKEDITOR.dom.comment.prototype.getAttribute = function() { return ''; };
        CKEDITOR.dom.comment.prototype.attributes = { align : '' };
      }
      var fakeElement = editor.createFakeElement( new CKEDITOR.dom.comment( text ), 'cke_wordpress_' + text, 'hr' );

      // This is the trick part. We can't use editor.insertElement()
      // because we need to put the comment directly at <body> level.
      // We need to do range manipulation for that.

      // Get a DOM range from the current selection.
      var range = editor.getSelection().getRanges()[0],
        elementsPath = new CKEDITOR.dom.elementPath( range.getCommonAncestor( true ) ),
        element = ( elementsPath.block && elementsPath.block.getParent() ) || elementsPath.blockLimit,
        hasMoved;

      // If we're not in <body> go moving the position to after the
      // elements until reaching it. This may happen when inside tables,
      // lists, blockquotes, etc.
      while ( element && element.getName() != 'body' )
      {
        range.moveToPosition( element, CKEDITOR.POSITION_AFTER_END );
        hasMoved = 1;
        element = element.getParent();
      }

      // Split the current block.
      if ( !hasMoved )
        range.splitBlock( 'p' );

      // Insert the fake element into the document.
      range.insertNode( fakeElement );

      // Now, we move the selection to the best possible place following
      // our fake element.
      var next = fakeElement;
      while ( ( next = next.getNext() ) && !range.moveToElementEditStart( next ) )
      {}

      range.select();
    }
  },

  afterInit : function( editor )
  {
    // Adds the comment processing rules to the data filter, so comments
    // are replaced by fake elements.
    editor.dataProcessor.dataFilter.addRules(
      {
        comment : function( value )
        {
          if ( !CKEDITOR.htmlParser.comment.prototype.getAttribute ) {
            CKEDITOR.htmlParser.comment.prototype.getAttribute = function() { return ''; };
            CKEDITOR.htmlParser.comment.prototype.attributes = { align : '' };
          }
          if ( value == 'more' )
            return editor.createFakeParserElement( new CKEDITOR.htmlParser.comment( value ), 'cke_wordpress_' + value, 'hr' );

          return value;
        }
      });
  }
});
