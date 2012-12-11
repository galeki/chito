/*
 * Copyright (C) 2003-2011 CKSource - Frederico Knabben
 * Plugin for CKEditor to send the current data to the server so it can be saved automatically.
 *
 * File Author:
 *   Jakub Świderski
 *
 * How to Use & Change log: docs/install.html
 *
 * == BEGIN LICENSE ==
 *
 * Licensed under the terms of any of the following licenses at your
 * choice:
 *
 *  - GNU General Public License Version 2 or later (the "GPL")
 *    http://www.gnu.org/licenses/gpl.html
 *
 *  - GNU Lesser General Public License Version 2.1 or later (the "LGPL")
 *    http://www.gnu.org/licenses/lgpl.html
 *
 *  - Mozilla Public License Version 1.1 or later (the "MPL")
 *    http://www.mozilla.org/MPL/MPL-1.1.html
 *
 * == END LICENSE ==
 *
 */

( function()
{
	// Counts number of times when editor was dirty.
	var autosaveCounter = 0;

	//Remembers state of autosaveCounter in case of an error
	var autosaveCounterPrevious = 0;

	// Flag indicating if button 'autosave' was pressed.
	var autosaveButtonUsed = false;

	// Flag indicating if 'autosave' interval was fired.
	var autosaveIntervalUsed = false;

	// Flag indicating whether editor contents are being saved at the moment.
	var autosaveWorking = false;

	// Holds array of icon-message pairs.
	var autosaveIcons = '';

	// Holds the name of "autosave" interval (used in window.clearInterval).
	var autosaveInterval = '';

	// Time of last successful save. It is set by AJAX on success save.
	var autosaveLastSave = '';

	// Hook to timeout used to set default/dirty icon (used in
	// window.clearTimeout).
	var autosaveTimeoutDefaultDirtyIcon = '';

	// Hook to timeout used to abort client-side request (used in window.clearTimeout).
	var autosaveTimeoutRequest = '';

	// Flag indicating if min time between two requests has passed.
	var autosaveIsMinTimeBetweenRequests = true;

	// Hook to timeout used to count time between requests (used in window.clearTimeout).
	var autosaveTimeoutBetweenRequests = '';

	var autosaveTestPattern =  /^form$|^body$/i;

	var autosaveTestPatternSmall =  /^form$/i;

	// Ajax object handler.
	var autosaveAjax = ( function()
	{

		// private
		var _editor = null;

		var _doBasicActions = function( editorInstance, targetUrl )
		{
			if ( !targetUrl )
			{
				// show error, set timeout for dirty icon and throw an exception.
				autosaveChangeIcon( editorInstance, autosaveIcons[5].path,
					autosaveIcons[5].title
						+ editorInstance.lang.autosave.noUrl );

				window.clearTimeout( autosaveTimeoutDefaultDirtyIcon );

				autosaveTimeoutDefaultDirtyIcon = CKEDITOR.tools.setTimeout(
					autosaveChangeIcon, 5000, null, [ editorInstance,
							autosaveIcons[1].path, autosaveIcons[1].title ] );

				throw new Error( editorInstance.lang.autosave.noUrl );
			}
			_editor = editorInstance;
		};

		/**
		* The first time this method is called, it will test three different
		* ways of creating an XHR object, and when it finds one that works, it
		* will return the object created and overwrite itself with the function
		* used to create the object. This new function becomes the _createXhrObj
		* method.
		*/
		var _createXhrObj = ( function()
		{ // Factory method.
			var methods = [
				function()
				{
					return {
						xhr : new XMLHttpRequest(),
						xhrTimeout : false
					};
				},
				function()
				{
					return {
						xhr : new ActiveXObject( 'Msxml2.XMLHTTP' ),
						xhrTimeout : false
					};
				},
				function()
				{
					return {
						xhr : new ActiveXObject( 'Microsoft.XMLHTTP' ),
						xhrTimeout : false
					};
				}
			];

			for ( var i = 0, len = methods.length ; i < len ; i++ )
			{
				try
				{
					methods[i]();
				}
				catch ( e ) { continue; }
				// If we have reached this point, method[i] worked.
				_createXhrObj = methods[i];
				return methods[i];
			}

			// If we have reached this point, none of the methods worked.
			throw new Error( _editor.lang.autosave.noXhr );
		} )();

		var _encodeGetParams = function( getUrl )
		{
			// get query string.
			var helper = ( getUrl.split( "?" ) )[1];
			// if there were no params return URL.
			if ( !helper )
				return getUrl;
			var encodedQueryString = _encodeParams( helper );
			getUrl = getUrl.replace( /\?.*/, "?" + encodedQueryString );
			return getUrl;
		};

		var _encodeParams = function( requestParams )
		{
			var helper = requestParams.split( "&" );
			var encodedQueryString = '';
			for ( var w = 0, len = helper.length ; w < len ; w++ )
			{
				// contents are already encoded
				if ( helper[w].substring( 0, helper[w].indexOf( "=" ) ) != _editor.config.autosaveContentParamName )
					helper[w] = helper[w].replace( /\=.*/, "="
						+ encodeURIComponent( helper[w].substring( helper[w]
							.indexOf( "=" ) + 1 ) ) );
				encodedQueryString += ( w === 0 ? "" : "&" ) + helper[w];
			}
			return encodedQueryString;
		};

		// Handles common errors like error404 or error500.
		// More messages can be added in language files.
		var _handleError = function( errorCode, xhrStatusText )
		{
			var message = '';
			message = _editor.lang.autosave['error'+errorCode];
			if(!message){
				if ( xhrStatusText )
				{
					message =
					 '(' + errorCode + ') ' + xhrStatusText ;
				} else
				{
					message = _editor.lang.autosave.defaultErrorMessage
						.replace( /(###)/, errorCode );
				}
			}


			autosaveChangeIcon( _editor, autosaveIcons[5].path,
				autosaveIcons[5].title + message );
		};

		// Gets time on client-side to tell user when
		// his data was saved. Server date can't be used in this case.
		var _getTimeOnClinetSide = function()
		{
			var now = new Date();
			var hours = now.getHours();
			var mins = now.getMinutes();
			var secs = now.getSeconds();
			if ( hours < 10 )
				hours = "0" + hours;
			if ( mins < 10 )
				mins = "0" + mins;
			if ( secs < 10 )
				secs = "0" + secs;
			return ( hours + ':' + mins + ':' + secs );
		};

		// Returns appropriate icon when error occurred.
		var _getTimeoutParameters = function( isPath, isDirty )
		{
			if ( isPath )
				return ( isDirty ? autosaveIcons[1].path
					: autosaveIcons[0].path );
			else
				return ( isDirty ? autosaveIcons[1].title
					 : autosaveIcons[0].title + autosaveLastSave);
		};

		// privileged
		return {
			request : function( editorInstance, method, targetUrl, requestParams )
			{
				_doBasicActions( editorInstance, targetUrl );
				var xhrObject = _createXhrObj();

				xhrObject.xhr.onreadystatechange = function()
				{
					xhrObject.xhrTimeout = false;
					if ( _editor.config.autosaveRequestTimeout )
					{
						if ( xhrObject.xhr.readyState == 1 )
						{
							autosaveTimeoutRequest = window.setTimeout(
								function()
								{
									if ( xhrObject.xhr.readyState == 1
										|| ( xhrObject.xhr.readyState == 2 && CKEDITOR.env.opera ) )
									{
										xhrObject.xhr.abort(); // Stop
										xhrObject.xhrTimeout = true;

										autosaveChangeIcon( _editor, autosaveIcons[5].path,
											autosaveIcons[5].title
												+ _editor.lang.autosave.requestTimeout );

										window.clearTimeout( autosaveTimeoutDefaultDirtyIcon );

										autosaveTimeoutDefaultDirtyIcon = CKEDITOR.tools
										.setTimeout( checkAndRestoreIcon, 10000, null,
											[ _editor, _getTimeoutParameters( true, autosaveCounterPrevious ),
												_getTimeoutParameters( false, autosaveCounterPrevious ) ] );

										// ajax is not working anymore.
										autosaveWorking = false;
										if(autosaveCounterPrevious)
											autosaveCounter += autosaveCounterPrevious;
									}
								}, _editor.config.autosaveRequestTimeout * 1000 );
						}
					}

					if ( xhrObject.xhr.readyState == 4 && !xhrObject.xhrTimeout )
					{
						// HTTP Status Codes:
						  //  2xx : Success
						  //  304 : Not Modified
						  //    0 : Returned when running locally (file://)
						  // 1223 : IE may change 204 to 1223 (see http://dev.jquery.com/ticket/1450)
						if ( ( xhrObject.xhr.status >= 200 && xhrObject.xhr.status < 300 ) ||
							xhrObject.xhr.status == 304 || xhrObject.xhr.status === 0
							||  xhrObject.xhr.status == 1223 )
						{
							if ( _editor.config.autosaveRequestTimeout )
								window.clearTimeout( autosaveTimeoutRequest );

							var ok = '';
							var err = '';
							if(xhrObject.xhr.responseXML){
								ok = xhrObject.xhr.responseXML.getElementsByTagName( "result" )[0];
								err = xhrObject.xhr.responseXML.getElementsByTagName( "error" )[0];
							}

							// <result status="ok" />
							if ( ( ok && ok.attributes.getNamedItem( 'status' ) && ok.attributes
								.getNamedItem( 'status' ).value == 'ok' ) )
							{
								autosaveLastSave = _getTimeOnClinetSide();

								autosaveChangeIcon( _editor, autosaveIcons[4].path,
									autosaveIcons[4].title + autosaveLastSave );

								window.clearTimeout( autosaveTimeoutDefaultDirtyIcon );

								autosaveTimeoutDefaultDirtyIcon = CKEDITOR.tools
									.setTimeout( checkAndRestoreIcon, 5000,
										null, [ _editor, autosaveIcons[0].path,
												autosaveIcons[0].title + autosaveLastSave
											  ] );

								autosaveCounterPrevious = 0;

								// <error statuscode="" message=""/>
								// <error statuscode="" />
								// <error message=""/>
							} else if ( err
								&& ( ( err.attributes.getNamedItem( 'statuscode' )
								&& err.attributes.getNamedItem( 'statuscode' ).value )
								|| ( err.attributes.getNamedItem( 'message' )
									&& err.attributes.getNamedItem( 'message' ).value ) ) )
							{
								if ( err.attributes.getNamedItem( 'message' )
									&& err.attributes.getNamedItem( 'message' ).value )
								{
									// if message form server was provided.
									autosaveChangeIcon(	_editor, autosaveIcons[5].path,
										autosaveIcons[5].title
											+ err.attributes.getNamedItem( 'message' ).value );
								} else
								{
									// if only error number was provided.
									_handleError( err.attributes
										.getNamedItem( 'statuscode' ).value );
								}
								window.clearTimeout( autosaveTimeoutDefaultDirtyIcon );

								autosaveTimeoutDefaultDirtyIcon = CKEDITOR.tools
								.setTimeout( checkAndRestoreIcon, 10000, null,
									[ _editor, _getTimeoutParameters( true, autosaveCounterPrevious ),
										_getTimeoutParameters( false, autosaveCounterPrevious ) ] );
							} else
							{
								// No XML or not expected XML provided; we assume it is an error.
								// Use responseText object because even if the response is XML, plugin
								// won't be able to read it.
								autosaveChangeIcon( _editor, autosaveIcons[5].path,
									autosaveIcons[5].title
										+ ( ( xhrObject.xhr.responseText ) ? xhrObject.xhr.responseText
											: ( ( xhrObject.xhr.status ) ? _editor.lang.autosave.defaultErrorMessage
												.replace( /(###)/, xhrObject.xhr.status )
												: _editor.lang.autosave.unknownError ) ) );

								window.clearTimeout( autosaveTimeoutDefaultDirtyIcon );

								autosaveTimeoutDefaultDirtyIcon = CKEDITOR.tools
								.setTimeout( checkAndRestoreIcon, 10000, null,
									[ _editor, _getTimeoutParameters( true, autosaveCounterPrevious ),
										_getTimeoutParameters( false, autosaveCounterPrevious ) ] );
							}
						} else
						{
							// Inform about XML request error and try to set default icon.
							// Use responseText object because even if the response is XML, plugin
							// won't be able to read it.
							_handleError( xhrObject.xhr.status, xhrObject.xhr.responseText );

							window
								.clearTimeout( autosaveTimeoutDefaultDirtyIcon );

							autosaveTimeoutDefaultDirtyIcon = CKEDITOR.tools
							.setTimeout( checkAndRestoreIcon, 10000, null,
								[ _editor, _getTimeoutParameters( true, autosaveCounterPrevious ),
									_getTimeoutParameters( false, autosaveCounterPrevious ) ] );
						}
						// ajax is not working anymore.
						autosaveWorking = false;
						if(autosaveCounterPrevious)
							autosaveCounter += autosaveCounterPrevious;
					}

				};

				if ( method == 'GET' )
				{	// if GET, join data with URL.

					// URL might already have params.
					targetUrl = ( ( targetUrl.indexOf( "?" ) > 0 ) ? ( targetUrl
						+ '&' + requestParams ) : ( targetUrl + '?' + requestParams ) );
					// encode request params. All except for contents as
					// they were already encoded.
					targetUrl = _encodeGetParams( targetUrl );
					requestParams = null;
				}

				xhrObject.xhr.open( method, targetUrl, true );

				if ( method == 'POST' )
				{
					xhrObject.xhr.setRequestHeader( 'Content-Type',
						'application/x-www-form-urlencoded; charset=UTF-8' );
					// encode request params. All except for contents as
					//they were already encoded.
					requestParams = _encodeParams( requestParams );
				}
				xhrObject.xhr.send( requestParams );
			}
		};

	} )();

	function autosaveEnable( editor )
	{
		// Neither autosave button nor interval should update counter.
		if ( editor.checkDirty() )
		{
			autosaveCounter++ ;
			editor.resetDirty();
			// change Icon to saveDirty
			autosaveChangeIcon( editor, autosaveIcons[1].path,
				autosaveIcons[1].title );
		}

		// if content is being saved at the moment don't do anything.
		if ( !autosaveWorking )
		{
			autosaveWorking = true;
			if ( autosaveButtonUsed || autosaveIntervalUsed )
			{
				if ( autosaveIntervalUsed )
				{
					autosaveIntervalUsed = false;
					// don't bother server with unnecessary requests.
					if ( autosaveCounter > 0
						&& autosaveIsMinTimeBetweenRequests)
					{
						invokeExecute( editor );
					} else
					{
						autosaveWorking = false;
					}
				} else
				{
					// button is user decision to send request no checking is needed
					autosaveButtonUsed = false;
					invokeExecute( editor );
				}
			} else if ( editor.config.autosaveSensitivity
						&& autosaveCounter >= editor.config.autosaveSensitivity )
			{
				if( autosaveIsMinTimeBetweenRequests )
				{
					window.clearTimeout( autosaveTimeoutBetweenRequests );//just in case
					autosaveIsMinTimeBetweenRequests = false;
					invokeExecute( editor );// for all events.
				} else
				{
					autosaveWorking = false;
				}

			}else{
				autosaveWorking = false;// nothing matches.
				
				//If only button works, reset counter after every non button saving attempt.
				if( !editor.config.autosaveSensitivity 
						&& !editor.config.autosaveRefreshTime)
					autosaveCounter = 0;
			}	
		}

		// reset autosaveButtonUsed if button was used and autosaveWorking ==
		// true.
		if ( autosaveButtonUsed )
		{
			autosaveButtonUsed = false;
		}
	}

	function invokeExecute( editor )
	{
		var currentData = editor.getData(); // get editor's data.
		// remember counter in case of an error
		autosaveCounterPrevious = autosaveCounter;
		autosaveCounter = 0;// reset counter as early as possible.
		autosaveExecute( editor, currentData );
	}

	function autosaveExecute( editor, currentData )
	{
		// change icon to loading.
		autosaveChangeIcon( editor, autosaveIcons[3].path,
			autosaveIcons[3].title );

		autosaveAjax.request( editor, editor.config.autosaveMethod,
			editor.config.autosaveTargetUrl, 'autosaveaction=draft&ckeditorname='
				+ editor.name + '&' + editor.config.autosaveContentParamName
				+ '=' + encodeURIComponent( currentData ) );

		// set timeout between requests.
		window.clearTimeout( autosaveTimeoutBetweenRequests );
		autosaveIsMinTimeBetweenRequests = false;
		autosaveTimeoutBetweenRequests = window.setTimeout(
			function(){
				autosaveIsMinTimeBetweenRequests = true;
			},	editor.config.autosaveMinTimeBetweenRequests * 1000 );
	}
		
	function autosaveChangeIcon( editor, iconPath, description )
	{
		var autosaveButton = CKEDITOR.document
			.getById( editor.commands.autosave.uiItems[0]._.id );

		autosaveButton.getFirst().setStyle( 'background-image',
			'url(' + editor.plugins.autosave.path + iconPath + ')' );

		autosaveButton.setAttribute( 'title', description );
		// changes the value of label
		autosaveButton.getChild( 1 ).setHtml( description );
	}

	// If editor was NOT modified since last save or error, this method changes
	// the icon to default (Otherwise there is no need of changing the icon).
	//Only default or dirty icon should be passed as parameter.
	//autosaveCounter!==autosaveCounterPrevious - icon was already changed to dirty
	//autosaveWorking - icon was already changed to dirty
	//autosaveCheckDirty(editor) - icon was already changed to dirty
	function checkAndRestoreIcon( editor, iconPath, description )
	{
		if ( autosaveCounter === autosaveCounterPrevious && !autosaveWorking && !editor.checkDirty() )
			autosaveChangeIcon( editor, iconPath, description );
	}

	function addEvent( element, eventType, fn )
	{
		if ( element.addEventListener )
		{
			element.addEventListener( eventType, fn, false );
		} else if ( element.attachEvent )
		{
			element.attachEvent( 'on' + eventType, fn );
		}
	}

	// Method used when form is submitted.
	function onSave( editor )
	{
		// Don't fire auto save.
		autosaveWorking = true;
		// don't fire beforeunload.
		editor.config.autosaveUseOnBeforeUnload = false;
		// cleanup.
		window.clearInterval( autosaveInterval );
		window.clearTimeout( autosaveTimeoutDefaultDirtyIcon );
		window.clearTimeout( autosaveTimeoutBetweenRequests );
		return true;
	}

	//Gets first element with specified class name
	function getElementByClassName( classname, node )
	{
		if( !node )
	        node = document.getElementsByTagName( 'body' )[0];
        var result = '';
		var regExp = new RegExp( '\\b' + classname + '\\b' );
        var elements = node.getElementsByTagName( '*' );
        for( var i=0, len=elements.length ; i<len ; i++ )
        {
        	if( regExp.test( elements[i].className ) )
        	{
	        	result = elements[i];
	        	break; //break on first element found
        	}
        }
        return result;
    }

	//Walks up the DOM tree until it
	//finds form or body element
	function getParentForm( elem )
	{
		if( !autosaveTestPattern.test( elem.nodeName ) )
		{
			return getParentForm( elem.parentNode );
		}else
		{
			if( autosaveTestPatternSmall.test( elem.nodeName ) )
				return elem;
			else
				return null;
		}
	}

	CKEDITOR.plugins.add( 'autosave', {
		// List of available localizations.
		lang : [ 'en', 'pl' ],

		init : function( editor )
		{

			// initialize events for CKEditor.
			editor.on( 'instanceReady', function( evt )
			{
				//Interval can't be smaller than min time between two following requests.
				//An exception from this rule is when interval is switched off (set to 0).
				if(editor.config.autosaveRefreshTime && 
						parseInt( editor.config.autosaveRefreshTime, 10 ) < 
						parseInt( editor.config.autosaveMinTimeBetweenRequests, 10 ) )
					editor.config.autosaveRefreshTime =
						editor.config.autosaveMinTimeBetweenRequests;

				// Set several listeners to watch for changes to the content...

				// Fired whenever something changes.
				editor.on( 'saveSnapshot', function()
				{
					if ( !evt.data || !evt.data.contentOnly )
						autosaveEnable( editor );
				} );

				//Disable plugin when using CKEditor Save button.
				editor.on('beforeCommandExec', function(event){
					if( event.data.name == 'save' )
						onSave( editor );
				});

				// Fired on undo/redo.
				editor.getCommand( 'undo' ).on( 'afterUndo', function()
				{
					autosaveEnable( editor );
				} );
				editor.getCommand( 'redo' ).on( 'afterRedo', function()
				{
					autosaveEnable( editor );
				} );

				// catches changes in WYSIWYG mode.
				editor.on( 'contentDom', function()
				{
					editor.document.on( 'keydown', function( event )
					{
						if ( event.data.$.ctrlKey || event.data.$.metaKey )
							return;

						var keyCode = event.data.$.keyCode;
						// Filter movement keys and related
						if ( keyCode == 8 || keyCode == 13 || keyCode == 32 ||
							( keyCode >= 46 && keyCode <= 90 ) ||
							( keyCode >= 96 && keyCode <= 111 ) ||
							( keyCode >= 186 && keyCode <= 222 ) )
								window.setTimeout( function()
								{
									autosaveEnable( editor );
								}, 100 );
					} );
					editor.document.on( 'drop', function()
					{
						autosaveEnable( editor );
					} );
					editor.document.getBody().on( 'drop', function()
					{
						autosaveEnable( editor );
					} );
				} );
				// If you won't fire this event keydowns and drops won't work
				// until you switch to source and back.
				editor.fire( 'contentDom' );

				// Detect changes in source mode.
				editor.on( 'mode', function( e )
				{
					if ( editor.mode != 'source' )
						return;

					editor.textarea.on( 'keydown', function( event )
					{
						// Do not capture CTRL hotkeys.
						if ( event.data.$.ctrlKey || event.data.$.metaKey )
							return;

						var keyCode = event.data.$.keyCode;
						// Filter movement keys and related
						if ( keyCode == 8 || keyCode == 13 || keyCode == 32 ||
							( keyCode >= 46 && keyCode <= 90 ) ||
							( keyCode >= 96 && keyCode <= 111 ) ||
							( keyCode >= 186 && keyCode <= 222 ) )
								window.setTimeout( function()
								{
									autosaveEnable( editor );
								}, 100 );
					} );

					editor.textarea.on( 'drop', function()
					{
						autosaveEnable( editor );
					} );
					editor.textarea.on( 'input', function()
					{
						autosaveEnable( editor );
					} );
				} );

				// Fired after command execution; (We might say that it works
				// with non-dialog plugins).
				editor.on( 'afterCommandExec', function( event )
				{
					if ( event.data.name == 'source' )
						return;

					if ( event.data.command.canUndo !== false )
						autosaveEnable( editor );

				} );

				// Cleanup ondestroying instance of ckeditor.
				evt.editor.on( 'destroy', function( event )
				{
					window.clearInterval( autosaveInterval );
					window.clearTimeout( autosaveTimeoutDefaultDirtyIcon );
					window.clearTimeout( autosaveTimeoutBetweenRequests );
				} );

				// Activate 'autosave' disabling action for form submition.
				if ( editor.config.autosaveParentFormId
					&& document
						.getElementById( editor.config.autosaveParentFormId ) )
				{
					var form = document
						.getElementById( editor.config.autosaveParentFormId );
					addEvent( form, 'submit', function()
					{
						onSave( editor );
					} );
				}else
				{
					var mainElement = getElementByClassName( editor.id );
					if( mainElement )
					{
						var formElement = getParentForm( mainElement );
						if( formElement ){
							addEvent( formElement, 'submit', function()
							{
								onSave( editor );
							} );
						}
					}
				}

				// Activate beforeunload.
				if ( editor.config.autosaveUseOnBeforeUnload )
				{
					window.onbeforeunload = function()
					{
						if ( editor.config.autosaveUseOnBeforeUnload )
						{
							if ( autosaveCounter > 0 || autosaveWorking)
							{
								return editor.lang.autosave.looseChanges;
							}
						}
					};
				}

				// Activate interval.
				if ( editor.config.autosaveRefreshTime
					&& !parseInt( editor.config.autosaveRefreshTime, 10 ) < 1 )
				{
					autosaveInterval = window.setInterval( function()
					{
						autosaveIntervalUsed = true;
						autosaveEnable( editor );
					}, editor.config.autosaveRefreshTime * 1000 );
				}

				// Cleanup.
				window.onunload = function()
				{
					window.clearInterval( autosaveInterval );
					window.clearTimeout( autosaveTimeoutDefaultDirtyIcon );
					window.clearTimeout( autosaveTimeoutBetweenRequests );
					window.onbeforeunload = null;
				};
			} );

			// Set icon-message pairs.
			autosaveIcons = [
			{
				path : 'images/autosaveClean.gif',
				title : editor.lang.autosave.draftSaved
			},
			{
				path : 'images/autosaveDirty.gif',
				title : editor.lang.autosave.needsSaving
			},
			{
				path : 'images/loadingBig.gif',
				title : editor.lang.autosave.inProgress
			},
			{
				path : 'images/loadingSmall.gif',
				title : editor.lang.autosave.inProgress
			},
			{
				path : 'images/tick_animated.gif',
				title : editor.lang.autosave.draftSaved
			},
			{
				path : 'images/cross_animated.gif',
				title : editor.lang.autosave.errorTemplate
			} ];

			// Register plugin command.
			editor.addCommand( 'autosave', {

				modes : { wysiwyg:1, source:1 },

				// Contains method to be executed for autosave on button
				// click, time interval or events.
				exec : function( editor )
				{
					autosaveEnable( editor );
				}
			} );

			editor.ui.addButton( 'Autosave', {
				label : editor.lang.autosave.defaultMessage,

				command : 'autosave',

				click : function( editor )
				{
					autosaveButtonUsed = true;

					// Invoking execution of autosave command.
					editor.execCommand( 'autosave' );
				},
				
				icon : this.path + 'images/autosaveClean.gif'
			} );
		}
	} );
} )();

// Extend CKEditor configuration options.
CKEDITOR.tools.extend( CKEDITOR.config, {
	//Informs after how many changes made in the editor’s data
	//autosave should be fired. If set to zero this trigger will not be used. 
	//Default value is 20.
	autosaveSensitivity : 20,

	//Time in seconds after which autosave will fire.
	//If set to zero, interval will not be used (it will be switched off).  
	//Default value is 30.
	//NOTE: If not set to zero then the value for this property  
	//can be either bigger or equal to autosaveMinTimeBetweenRequests. 
	autosaveRefreshTime : 30,

	// Specifies if onbeforeunload event should be used.
	// If user has changed editor data which haven’t yet been
	// saved and he/she wants to leave the page, browser will
	//ask him if he really wants to leave without saving the data.
	//Default value is true.
	autosaveUseOnBeforeUnload : true,

	// Target url (required). URL for connector handling the
	// request on server side E.g.
	// http://192.168.1.100:8080/AjaxAutosave/cksource/connector/java/connector.java
	autosaveTargetUrl : '',

	// Id of parent form element containing the editor instance.
	// If specified, plugin will be disabled when form is submitted.
	// Default value is empty string.
	// NOTE: If id is not specified, plugin will try to search for the
	// parent form element and attach the same events as when id for the
	// form is given.
	autosaveParentFormId : '',

	//Method used to send request. Only POST and GET are supported.
	//Default value is POST.
	autosaveMethod : 'POST',

	//Name of parameter, holding editor data, to use in GET or POST request.
	//Default value is ‘content’.
	autosaveContentParamName : 'content',

	//Time in seconds after which client-side request will timeout if it is not
	//yet finished on server-side. If set to zero timeout for client-side request
	//will not be used. Default value is 10.
	//NOTE: This only aborts the client-side request so that application on browser
	//side could return to its default state.
	autosaveRequestTimeout : 10,

	//Minimum amount of time in seconds which has to pass before another request
	//is send to server. Default value is 15.
	autosaveMinTimeBetweenRequests : 15
} );
