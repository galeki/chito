/**
 * SyntaxHighlighter
 * http://alexgorbatchev.com/SyntaxHighlighter
 *
 * SyntaxHighlighter is donationware. If you are using it, please donate.
 * http://alexgorbatchev.com/SyntaxHighlighter/donate.html
 *
 * @version
 * 3.0.83 (July 02 2010)
 * 
 * @copyright
 * Copyright (C) 2004-2010 Alex Gorbatchev.
 *
 * @license
 * Dual licensed under the MIT and GPL licenses.
 */
;(function()
{
	// CommonJS
	typeof(require) != 'undefined' ? SyntaxHighlighter = require('shCore').SyntaxHighlighter : null;

	function Brush()
	{
		// Created by Peter Atoria @ http://iAtoria.com
	
		var inits 	 =  'class interface function package';
	
		var keywords =	'-Infinity ...rest Array as AS3 Boolean break case catch const continue Date decodeURI ' + 
						'decodeURIComponent default delete do dynamic each else encodeURI encodeURIComponent escape ' + 
						'extends false final finally flash_proxy for get if implements import in include Infinity ' + 
						'instanceof int internal is isFinite isNaN isXMLName label namespace NaN native new null ' + 
						'Null Number Object object_proxy override parseFloat parseInt private protected public ' + 
						'return set static String super switch this throw true try typeof uint undefined unescape ' + 
						'use void while with'
						;
	
		this.regexList = [
			{ regex: SyntaxHighlighter.regexLib.singleLineCComments,	css: 'comments' },		// one line comments
			{ regex: SyntaxHighlighter.regexLib.multiLineCComments,		css: 'comments' },		// multiline comments
			{ regex: SyntaxHighlighter.regexLib.doubleQuotedString,		css: 'string' },		// double quoted strings
			{ regex: SyntaxHighlighter.regexLib.singleQuotedString,		css: 'string' },		// single quoted strings
			{ regex: /\b([\d]+(\.[\d]+)?|0x[a-f0-9]+)\b/gi,				css: 'value' },			// numbers
			{ regex: new RegExp(this.getKeywords(inits), 'gm'),			css: 'color3' },		// initializations
			{ regex: new RegExp(this.getKeywords(keywords), 'gm'),		css: 'keyword' },		// keywords
			{ regex: new RegExp('var', 'gm'),							css: 'variable' },		// variable
			{ regex: new RegExp('trace', 'gm'),							css: 'color1' }			// trace
			];
	
		this.forHtmlScript(SyntaxHighlighter.regexLib.scriptScriptTags);
	};

	Brush.prototype	= new SyntaxHighlighter.Highlighter();
	Brush.aliases	= ['actionscript3', 'as3'];

	SyntaxHighlighter.brushes.AS3 = Brush;

	// CommonJS
	typeof(exports) != 'undefined' ? exports.Brush = Brush : null;
})();
/**
 * SyntaxHighlighter
 * http://alexgorbatchev.com/SyntaxHighlighter
 *
 * SyntaxHighlighter is donationware. If you are using it, please donate.
 * http://alexgorbatchev.com/SyntaxHighlighter/donate.html
 *
 * @version
 * 3.0.83 (July 02 2010)
 * 
 * @copyright
 * Copyright (C) 2004-2010 Alex Gorbatchev.
 *
 * @license
 * Dual licensed under the MIT and GPL licenses.
 */
;(function()
{
	// CommonJS
	typeof(require) != 'undefined' ? SyntaxHighlighter = require('shCore').SyntaxHighlighter : null;

	function Brush()
	{
		// AppleScript brush by David Chambers
		// http://davidchambersdesign.com/
		var keywords   = 'after before beginning continue copy each end every from return get global in local named of set some that the then times to where whose with without';
		var ordinals   = 'first second third fourth fifth sixth seventh eighth ninth tenth last front back middle';
		var specials   = 'activate add alias AppleScript ask attachment boolean class constant delete duplicate empty exists false id integer list make message modal modified new no paragraph pi properties quit real record remove rest result reveal reverse run running save string true word yes';

		this.regexList = [

			{ regex: /(--|#).*$/gm,
			    css: 'comments' },

			{ regex: /\(\*(?:[\s\S]*?\(\*[\s\S]*?\*\))*[\s\S]*?\*\)/gm, // support nested comments
			    css: 'comments' },

			{ regex: /"[\s\S]*?"/gm,
			    css: 'string' },

			{ regex: /(?:,|:|¬|'s\b|\(|\)|\{|\}|«|\b\w*»)/g,
			    css: 'color1' },

			{ regex: /(-)?(\d)+(\.(\d)?)?(E\+(\d)+)?/g, // numbers
			    css: 'color1' },

			{ regex: /(?:&(amp;|gt;|lt;)?|=|� |>|<|≥|>=|≤|<=|\*|\+|-|\/|÷|\^)/g,
			    css: 'color2' },

			{ regex: /\b(?:and|as|div|mod|not|or|return(?!\s&)(ing)?|equals|(is(n't| not)? )?equal( to)?|does(n't| not) equal|(is(n't| not)? )?(greater|less) than( or equal( to)?)?|(comes|does(n't| not) come) (after|before)|is(n't| not)?( in)? (back|front) of|is(n't| not)? behind|is(n't| not)?( (in|contained by))?|does(n't| not) contain|contain(s)?|(start|begin|end)(s)? with|((but|end) )?(consider|ignor)ing|prop(erty)?|(a )?ref(erence)?( to)?|repeat (until|while|with)|((end|exit) )?repeat|((else|end) )?if|else|(end )?(script|tell|try)|(on )?error|(put )?into|(of )?(it|me)|its|my|with (timeout( of)?|transaction)|end (timeout|transaction))\b/g,
			    css: 'keyword' },

			{ regex: /\b\d+(st|nd|rd|th)\b/g, // ordinals
			    css: 'keyword' },

			{ regex: /\b(?:about|above|against|around|at|below|beneath|beside|between|by|(apart|aside) from|(instead|out) of|into|on(to)?|over|since|thr(ough|u)|under)\b/g,
			    css: 'color3' },

			{ regex: /\b(?:adding folder items to|after receiving|choose( ((remote )?application|color|folder|from list|URL))?|clipboard info|set the clipboard to|(the )?clipboard|entire contents|display(ing| (alert|dialog|mode))?|document( (edited|file|nib name))?|file( (name|type))?|(info )?for|giving up after|(name )?extension|quoted form|return(ed)?|second(?! item)(s)?|list (disks|folder)|text item(s| delimiters)?|(Unicode )?text|(disk )?item(s)?|((current|list) )?view|((container|key) )?window|with (data|icon( (caution|note|stop))?|parameter(s)?|prompt|properties|seed|title)|case|diacriticals|hyphens|numeric strings|punctuation|white space|folder creation|application(s( folder)?| (processes|scripts position|support))?|((desktop )?(pictures )?|(documents|downloads|favorites|home|keychain|library|movies|music|public|scripts|sites|system|users|utilities|workflows) )folder|desktop|Folder Action scripts|font(s| panel)?|help|internet plugins|modem scripts|(system )?preferences|printer descriptions|scripting (additions|components)|shared (documents|libraries)|startup (disk|items)|temporary items|trash|on server|in AppleTalk zone|((as|long|short) )?user name|user (ID|locale)|(with )?password|in (bundle( with identifier)?|directory)|(close|open for) access|read|write( permission)?|(g|s)et eof|using( delimiters)?|starting at|default (answer|button|color|country code|entr(y|ies)|identifiers|items|name|location|script editor)|hidden( answer)?|open(ed| (location|untitled))?|error (handling|reporting)|(do( shell)?|load|run|store) script|administrator privileges|altering line endings|get volume settings|(alert|boot|input|mount|output|set) volume|output muted|(fax|random )?number|round(ing)?|up|down|toward zero|to nearest|as taught in school|system (attribute|info)|((AppleScript( Studio)?|system) )?version|(home )?directory|(IPv4|primary Ethernet) address|CPU (type|speed)|physical memory|time (stamp|to GMT)|replacing|ASCII (character|number)|localized string|from table|offset|summarize|beep|delay|say|(empty|multiple) selections allowed|(of|preferred) type|invisibles|showing( package contents)?|editable URL|(File|FTP|News|Media|Web) [Ss]ervers|Telnet hosts|Directory services|Remote applications|waiting until completion|saving( (in|to))?|path (for|to( (((current|frontmost) )?application|resource))?)|POSIX (file|path)|(background|RGB) color|(OK|cancel) button name|cancel button|button(s)?|cubic ((centi)?met(re|er)s|yards|feet|inches)|square ((kilo)?met(re|er)s|miles|yards|feet)|(centi|kilo)?met(re|er)s|miles|yards|feet|inches|lit(re|er)s|gallons|quarts|(kilo)?grams|ounces|pounds|degrees (Celsius|Fahrenheit|Kelvin)|print( (dialog|settings))?|clos(e(able)?|ing)|(de)?miniaturized|miniaturizable|zoom(ed|able)|attribute run|action (method|property|title)|phone|email|((start|end)ing|home) page|((birth|creation|current|custom|modification) )?date|((((phonetic )?(first|last|middle))|computer|host|maiden|related) |nick)?name|aim|icq|jabber|msn|yahoo|address(es)?|save addressbook|should enable action|city|country( code)?|formatte(r|d address)|(palette )?label|state|street|zip|AIM [Hh]andle(s)?|my card|select(ion| all)?|unsaved|(alpha )?value|entr(y|ies)|group|(ICQ|Jabber|MSN) handle|person|people|company|department|icon image|job title|note|organization|suffix|vcard|url|copies|collating|pages (across|down)|request print time|target( printer)?|((GUI Scripting|Script menu) )?enabled|show Computer scripts|(de)?activated|awake from nib|became (key|main)|call method|of (class|object)|center|clicked toolbar item|closed|for document|exposed|(can )?hide|idle|keyboard (down|up)|event( (number|type))?|launch(ed)?|load (image|movie|nib|sound)|owner|log|mouse (down|dragged|entered|exited|moved|up)|move|column|localization|resource|script|register|drag (info|types)|resigned (active|key|main)|resiz(e(d)?|able)|right mouse (down|dragged|up)|scroll wheel|(at )?index|should (close|open( untitled)?|quit( after last window closed)?|zoom)|((proposed|screen) )?bounds|show(n)?|behind|in front of|size (mode|to fit)|update(d| toolbar item)?|was (hidden|miniaturized)|will (become active|close|finish launching|hide|miniaturize|move|open|quit|(resign )?active|((maximum|minimum|proposed) )?size|show|zoom)|bundle|data source|movie|pasteboard|sound|tool(bar| tip)|(color|open|save) panel|coordinate system|frontmost|main( (bundle|menu|window))?|((services|(excluded from )?windows) )?menu|((executable|frameworks|resource|scripts|shared (frameworks|support)) )?path|(selected item )?identifier|data|content(s| view)?|character(s)?|click count|(command|control|option|shift) key down|context|delta (x|y|z)|key( code)?|location|pressure|unmodified characters|types|(first )?responder|playing|(allowed|selectable) identifiers|allows customization|(auto saves )?configuration|visible|image( name)?|menu form representation|tag|user(-| )defaults|associated file name|(auto|needs) display|current field editor|floating|has (resize indicator|shadow)|hides when deactivated|level|minimized (image|title)|opaque|position|release when closed|sheet|title(d)?)\b/g,
			    css: 'color3' },

			{ regex: new RegExp(this.getKeywords(specials), 'gm'), css: 'color3' },
			{ regex: new RegExp(this.getKeywords(keywords), 'gm'), css: 'keyword' },
			{ regex: new RegExp(this.getKeywords(ordinals), 'gm'), css: 'keyword' }
		];
	};

	Brush.prototype = new SyntaxHighlighter.Highlighter();
	Brush.aliases = ['applescript'];

	SyntaxHighlighter.brushes.AppleScript = Brush;

	// CommonJS
	typeof(exports) != 'undefined' ? exports.Brush = Brush : null;
})();
/**
 * SyntaxHighlighter
 * http://alexgorbatchev.com/SyntaxHighlighter
 *
 * SyntaxHighlighter is donationware. If you are using it, please donate.
 * http://alexgorbatchev.com/SyntaxHighlighter/donate.html
 *
 * @version
 * 3.0.83 (July 02 2010)
 * 
 * @copyright
 * Copyright (C) 2004-2010 Alex Gorbatchev.
 *
 * @license
 * Dual licensed under the MIT and GPL licenses.
 */
;(function()
{
	// CommonJS
	typeof(require) != 'undefined' ? SyntaxHighlighter = require('shCore').SyntaxHighlighter : null;

	function Brush()
	{
		var keywords =	'if fi then elif else for do done until while break continue case function return in eq ne ge le';
		var commands =  'alias apropos awk basename bash bc bg builtin bzip2 cal cat cd cfdisk chgrp chmod chown chroot' +
						'cksum clear cmp comm command cp cron crontab csplit cut date dc dd ddrescue declare df ' +
						'diff diff3 dig dir dircolors dirname dirs du echo egrep eject enable env ethtool eval ' +
						'exec exit expand export expr false fdformat fdisk fg fgrep file find fmt fold format ' +
						'free fsck ftp gawk getopts grep groups gzip hash head history hostname id ifconfig ' +
						'import install join kill less let ln local locate logname logout look lpc lpr lprint ' +
						'lprintd lprintq lprm ls lsof make man mkdir mkfifo mkisofs mknod more mount mtools ' +
						'mv netstat nice nl nohup nslookup open op passwd paste pathchk ping popd pr printcap ' +
						'printenv printf ps pushd pwd quota quotacheck quotactl ram rcp read readonly renice ' +
						'remsync rm rmdir rsync screen scp sdiff sed select seq set sftp shift shopt shutdown ' +
						'sleep sort source split ssh strace su sudo sum symlink sync tail tar tee test time ' +
						'times touch top traceroute trap tr true tsort tty type ulimit umask umount unalias ' +
						'uname unexpand uniq units unset unshar useradd usermod users uuencode uudecode v vdir ' +
						'vi watch wc whereis which who whoami Wget xargs yes'
						;

		this.regexList = [
			{ regex: /^#!.*$/gm,											css: 'preprocessor bold' },
			{ regex: /\/[\w-\/]+/gm,										css: 'plain' },
			{ regex: SyntaxHighlighter.regexLib.singleLinePerlComments,		css: 'comments' },		// one line comments
			{ regex: SyntaxHighlighter.regexLib.doubleQuotedString,			css: 'string' },		// double quoted strings
			{ regex: SyntaxHighlighter.regexLib.singleQuotedString,			css: 'string' },		// single quoted strings
			{ regex: new RegExp(this.getKeywords(keywords), 'gm'),			css: 'keyword' },		// keywords
			{ regex: new RegExp(this.getKeywords(commands), 'gm'),			css: 'functions' }		// commands
			];
	}

	Brush.prototype	= new SyntaxHighlighter.Highlighter();
	Brush.aliases	= ['bash', 'shell'];

	SyntaxHighlighter.brushes.Bash = Brush;

	// CommonJS
	typeof(exports) != 'undefined' ? exports.Brush = Brush : null;
})();
/**
 * SyntaxHighlighter
 * http://alexgorbatchev.com/
 *
 * This brush was originally created by Ildar Shaimordanov
 * homepage:   http://with-love-from-siberia.blogspot.com/
 * brush page: http://with-love-from-siberia.blogspot.com/2009/07/finest-code-syntax-highlighter.html
 */
SyntaxHighlighter.brushes.Cmd = function()
{
    var commands = 'ASSOC AT ATTRIB BREAK CACLS CD CHCP CHDIR CHKDSK CHKNTFS CLS CMD COLOR COMP COMPACT CONVERT COPY DATE '
                 + 'DEL DIR DISKCOMP DISKCOPY DOSKEY ECHO ERASE EXIT FC FIND FINDSTR FORMAT FTYPE GRAFTABL '
                 + 'HELP LABEL MD MKDIR MODE MORE MOVE PATH PAUSE POPD PRINT PROMPT PUSHD RD RECOVER REN RENAME REPLACE '
                 + 'RMDIR SHIFT SORT START SUBST TIME TITLE TREE TYPE VER VERIFY VOL XCOPY';

    var keywords = 'CON DEFINED DO ENABLEDELAYEDEXPANSION ENABLEEXTENSIONS ENDLOCAL FOR GOTO CALL IF IN ELSE NOT NUL REM SET SETLOCAL';

    var variables = 'ALLUSERSPROFILE APPDATA CommonProgramFiles COMPUTERNAME ComSpec DATE FP_NO_HOST_CHECK HOMEDRIVE '
                  + 'HOMEPATH LOGONSERVER NUMBER_OF_PROCESSORS OS Path PATHEXT PROCESSOR_ARCHITECTURE PROCESSOR_IDENTIFIER '
                  + 'PROCESSOR_LEVEL PROCESSOR_REVISION ProgramFiles PROGS PROMPT SANDBOX_DISK SANDBOX_PATH SESSIONNAME '
                  + 'SystemDrive SystemRoot TEMP TIME TMP USERDNSDOMAIN USERDOMAIN USERNAME USERPROFILE windir';

    this.regexList = [
        //
        // REM Comments
        //
        {
            regex: /(^::|rem).*$/gmi,
            css: 'comments'
        },

        //
        // "Strings"
        // 'Strings'
        // `Strings`
        // ECHO String
        //
        {
            regex: SyntaxHighlighter.regexLib.doubleQuotedString,
            css: 'string' 
        },
        {
            regex: SyntaxHighlighter.regexLib.singleQuotedString,
            css: 'string' 
        },
        {
            regex: /`(?:\.|(\\\`)|[^\``\n])*`/g,
            css: 'string' 
        },
        {
            regex: /echo.*$/gmi,
            css: 'string'
        },

        //
        // :Labels
        //
        {
            regex: /^:.+$/gmi,
            css: 'color3' 
        },

        //
        // %Variables%
        // !Variables!
        //
        {
            regex: /(%|!)\w+\1/gmi,
            css: 'variable'
        },

        //
        // %%a variable Refs
        // %1 variable Refs
        //
        {
            regex: /%\*|%%?~?[fdpnxsatz]*[0-9a-z]\b/gmi,
            css: 'variable' 
        },

        //
        // keywords
        //
        {
            regex: new RegExp(this.getKeywords(commands), 'gmi'),
            css: 'keyword'
        },

        //
        // keywords
        //
        {
            regex: new RegExp(this.getKeywords(keywords), 'gmi'),
            css: 'keyword' 
        }
    ];
};

SyntaxHighlighter.brushes.Cmd.prototype = new SyntaxHighlighter.Highlighter();
SyntaxHighlighter.brushes.Cmd.aliases = ['bat', 'cmd', 'batch'];
/**
 * SyntaxHighlighter
 * http://alexgorbatchev.com/SyntaxHighlighter
 *
 * SyntaxHighlighter is donationware. If you are using it, please donate.
 * http://alexgorbatchev.com/SyntaxHighlighter/donate.html
 *
 * @version
 * 3.0.83 (July 02 2010)
 * 
 * @copyright
 * Copyright (C) 2004-2010 Alex Gorbatchev.
 *
 * @license
 * Dual licensed under the MIT and GPL licenses.
 */
;(function()
{
	// CommonJS
	typeof(require) != 'undefined' ? SyntaxHighlighter = require('shCore').SyntaxHighlighter : null;

	function Brush()
	{
		var keywords =	'abstract as base bool break byte case catch char checked class const ' +
						'continue decimal default delegate do double else enum event explicit ' +
						'extern false finally fixed float for foreach get goto if implicit in int ' +
						'interface internal is lock long namespace new null object operator out ' +
						'override params private protected public readonly ref return sbyte sealed set ' +
						'short sizeof stackalloc static string struct switch this throw true try ' +
						'typeof uint ulong unchecked unsafe ushort using virtual void while';

		function fixComments(match, regexInfo)
		{
			var css = (match[0].indexOf("///") == 0)
				? 'color1'
				: 'comments'
				;
			
			return [new SyntaxHighlighter.Match(match[0], match.index, css)];
		}

		this.regexList = [
			{ regex: SyntaxHighlighter.regexLib.singleLineCComments,	func : fixComments },		// one line comments
			{ regex: SyntaxHighlighter.regexLib.multiLineCComments,		css: 'comments' },			// multiline comments
			{ regex: /@"(?:[^"]|"")*"/g,								css: 'string' },			// @-quoted strings
			{ regex: SyntaxHighlighter.regexLib.doubleQuotedString,		css: 'string' },			// strings
			{ regex: SyntaxHighlighter.regexLib.singleQuotedString,		css: 'string' },			// strings
			{ regex: /^\s*#.*/gm,										css: 'preprocessor' },		// preprocessor tags like #region and #endregion
			{ regex: new RegExp(this.getKeywords(keywords), 'gm'),		css: 'keyword' },			// c# keyword
			{ regex: /\bpartial(?=\s+(?:class|interface|struct)\b)/g,	css: 'keyword' },			// contextual keyword: 'partial'
			{ regex: /\byield(?=\s+(?:return|break)\b)/g,				css: 'keyword' }			// contextual keyword: 'yield'
			];
		
		this.forHtmlScript(SyntaxHighlighter.regexLib.aspScriptTags);
	};

	Brush.prototype	= new SyntaxHighlighter.Highlighter();
	Brush.aliases	= ['c#', 'c-sharp', 'csharp'];

	SyntaxHighlighter.brushes.CSharp = Brush;

	// CommonJS
	typeof(exports) != 'undefined' ? exports.Brush = Brush : null;
})();

/**
 * SyntaxHighlighter
 * http://alexgorbatchev.com/SyntaxHighlighter
 *
 * SyntaxHighlighter is donationware. If you are using it, please donate.
 * http://alexgorbatchev.com/SyntaxHighlighter/donate.html
 *
 * @version
 * 3.0.83 (July 02 2010)
 * 
 * @copyright
 * Copyright (C) 2004-2010 Alex Gorbatchev.
 *
 * @license
 * Dual licensed under the MIT and GPL licenses.
 */
;(function()
{
	// CommonJS
	typeof(require) != 'undefined' ? SyntaxHighlighter = require('shCore').SyntaxHighlighter : null;

	function Brush()
	{
		// Contributed by Jen
		// http://www.jensbits.com/2009/05/14/coldfusion-brush-for-syntaxhighlighter-plus
	
		var funcs	=	'Abs ACos AddSOAPRequestHeader AddSOAPResponseHeader AjaxLink AjaxOnLoad ArrayAppend ArrayAvg ArrayClear ArrayDeleteAt ' + 
						'ArrayInsertAt ArrayIsDefined ArrayIsEmpty ArrayLen ArrayMax ArrayMin ArraySet ArraySort ArraySum ArraySwap ArrayToList ' + 
						'Asc ASin Atn BinaryDecode BinaryEncode BitAnd BitMaskClear BitMaskRead BitMaskSet BitNot BitOr BitSHLN BitSHRN BitXor ' + 
						'Ceiling CharsetDecode CharsetEncode Chr CJustify Compare CompareNoCase Cos CreateDate CreateDateTime CreateObject ' + 
						'CreateODBCDate CreateODBCDateTime CreateODBCTime CreateTime CreateTimeSpan CreateUUID DateAdd DateCompare DateConvert ' + 
						'DateDiff DateFormat DatePart Day DayOfWeek DayOfWeekAsString DayOfYear DaysInMonth DaysInYear DE DecimalFormat DecrementValue ' + 
						'Decrypt DecryptBinary DeleteClientVariable DeserializeJSON DirectoryExists DollarFormat DotNetToCFType Duplicate Encrypt ' + 
						'EncryptBinary Evaluate Exp ExpandPath FileClose FileCopy FileDelete FileExists FileIsEOF FileMove FileOpen FileRead ' + 
						'FileReadBinary FileReadLine FileSetAccessMode FileSetAttribute FileSetLastModified FileWrite Find FindNoCase FindOneOf ' + 
						'FirstDayOfMonth Fix FormatBaseN GenerateSecretKey GetAuthUser GetBaseTagData GetBaseTagList GetBaseTemplatePath ' + 
						'GetClientVariablesList GetComponentMetaData GetContextRoot GetCurrentTemplatePath GetDirectoryFromPath GetEncoding ' + 
						'GetException GetFileFromPath GetFileInfo GetFunctionList GetGatewayHelper GetHttpRequestData GetHttpTimeString ' + 
						'GetK2ServerDocCount GetK2ServerDocCountLimit GetLocale GetLocaleDisplayName GetLocalHostIP GetMetaData GetMetricData ' + 
						'GetPageContext GetPrinterInfo GetProfileSections GetProfileString GetReadableImageFormats GetSOAPRequest GetSOAPRequestHeader ' + 
						'GetSOAPResponse GetSOAPResponseHeader GetTempDirectory GetTempFile GetTemplatePath GetTickCount GetTimeZoneInfo GetToken ' + 
						'GetUserRoles GetWriteableImageFormats Hash Hour HTMLCodeFormat HTMLEditFormat IIf ImageAddBorder ImageBlur ImageClearRect ' + 
						'ImageCopy ImageCrop ImageDrawArc ImageDrawBeveledRect ImageDrawCubicCurve ImageDrawLine ImageDrawLines ImageDrawOval ' + 
						'ImageDrawPoint ImageDrawQuadraticCurve ImageDrawRect ImageDrawRoundRect ImageDrawText ImageFlip ImageGetBlob ImageGetBufferedImage ' + 
						'ImageGetEXIFTag ImageGetHeight ImageGetIPTCTag ImageGetWidth ImageGrayscale ImageInfo ImageNegative ImageNew ImageOverlay ImagePaste ' + 
						'ImageRead ImageReadBase64 ImageResize ImageRotate ImageRotateDrawingAxis ImageScaleToFit ImageSetAntialiasing ImageSetBackgroundColor ' + 
						'ImageSetDrawingColor ImageSetDrawingStroke ImageSetDrawingTransparency ImageSharpen ImageShear ImageShearDrawingAxis ImageTranslate ' + 
						'ImageTranslateDrawingAxis ImageWrite ImageWriteBase64 ImageXORDrawingMode IncrementValue InputBaseN Insert Int IsArray IsBinary ' + 
						'IsBoolean IsCustomFunction IsDate IsDDX IsDebugMode IsDefined IsImage IsImageFile IsInstanceOf IsJSON IsLeapYear IsLocalHost ' + 
						'IsNumeric IsNumericDate IsObject IsPDFFile IsPDFObject IsQuery IsSimpleValue IsSOAPRequest IsStruct IsUserInAnyRole IsUserInRole ' + 
						'IsUserLoggedIn IsValid IsWDDX IsXML IsXmlAttribute IsXmlDoc IsXmlElem IsXmlNode IsXmlRoot JavaCast JSStringFormat LCase Left Len ' + 
						'ListAppend ListChangeDelims ListContains ListContainsNoCase ListDeleteAt ListFind ListFindNoCase ListFirst ListGetAt ListInsertAt ' + 
						'ListLast ListLen ListPrepend ListQualify ListRest ListSetAt ListSort ListToArray ListValueCount ListValueCountNoCase LJustify Log ' + 
						'Log10 LSCurrencyFormat LSDateFormat LSEuroCurrencyFormat LSIsCurrency LSIsDate LSIsNumeric LSNumberFormat LSParseCurrency LSParseDateTime ' + 
						'LSParseEuroCurrency LSParseNumber LSTimeFormat LTrim Max Mid Min Minute Month MonthAsString Now NumberFormat ParagraphFormat ParseDateTime ' + 
						'Pi PrecisionEvaluate PreserveSingleQuotes Quarter QueryAddColumn QueryAddRow QueryConvertForGrid QueryNew QuerySetCell QuotedValueList Rand ' + 
						'Randomize RandRange REFind REFindNoCase ReleaseComObject REMatch REMatchNoCase RemoveChars RepeatString Replace ReplaceList ReplaceNoCase ' + 
						'REReplace REReplaceNoCase Reverse Right RJustify Round RTrim Second SendGatewayMessage SerializeJSON SetEncoding SetLocale SetProfileString ' + 
						'SetVariable Sgn Sin Sleep SpanExcluding SpanIncluding Sqr StripCR StructAppend StructClear StructCopy StructCount StructDelete StructFind ' + 
						'StructFindKey StructFindValue StructGet StructInsert StructIsEmpty StructKeyArray StructKeyExists StructKeyList StructKeyList StructNew ' + 
						'StructSort StructUpdate Tan TimeFormat ToBase64 ToBinary ToScript ToString Trim UCase URLDecode URLEncodedFormat URLSessionFormat Val ' + 
						'ValueList VerifyClient Week Wrap Wrap WriteOutput XmlChildPos XmlElemNew XmlFormat XmlGetNodeType XmlNew XmlParse XmlSearch XmlTransform ' + 
						'XmlValidate Year YesNoFormat';

		var keywords =	'cfabort cfajaximport cfajaxproxy cfapplet cfapplication cfargument cfassociate cfbreak cfcache cfcalendar ' + 
						'cfcase cfcatch cfchart cfchartdata cfchartseries cfcol cfcollection cfcomponent cfcontent cfcookie cfdbinfo ' + 
						'cfdefaultcase cfdirectory cfdiv cfdocument cfdocumentitem cfdocumentsection cfdump cfelse cfelseif cferror ' + 
						'cfexchangecalendar cfexchangeconnection cfexchangecontact cfexchangefilter cfexchangemail cfexchangetask ' + 
						'cfexecute cfexit cffeed cffile cfflush cfform cfformgroup cfformitem cfftp cffunction cfgrid cfgridcolumn ' + 
						'cfgridrow cfgridupdate cfheader cfhtmlhead cfhttp cfhttpparam cfif cfimage cfimport cfinclude cfindex ' + 
						'cfinput cfinsert cfinterface cfinvoke cfinvokeargument cflayout cflayoutarea cfldap cflocation cflock cflog ' + 
						'cflogin cfloginuser cflogout cfloop cfmail cfmailparam cfmailpart cfmenu cfmenuitem cfmodule cfNTauthenticate ' + 
						'cfobject cfobjectcache cfoutput cfparam cfpdf cfpdfform cfpdfformparam cfpdfparam cfpdfsubform cfpod cfpop ' + 
						'cfpresentation cfpresentationslide cfpresenter cfprint cfprocessingdirective cfprocparam cfprocresult ' + 
						'cfproperty cfquery cfqueryparam cfregistry cfreport cfreportparam cfrethrow cfreturn cfsavecontent cfschedule ' + 
						'cfscript cfsearch cfselect cfset cfsetting cfsilent cfslider cfsprydataset cfstoredproc cfswitch cftable ' + 
						'cftextarea cfthread cfthrow cftimer cftooltip cftrace cftransaction cftree cftreeitem cftry cfupdate cfwddx ' + 
						'cfwindow cfxml cfzip cfzipparam';

		var operators =	'all and any between cross in join like not null or outer some';

		this.regexList = [
			{ regex: new RegExp('--(.*)$', 'gm'),						css: 'comments' },  // one line and multiline comments
			{ regex: SyntaxHighlighter.regexLib.xmlComments,			css: 'comments' },    // single quoted strings
			{ regex: SyntaxHighlighter.regexLib.doubleQuotedString,		css: 'string' },    // double quoted strings
			{ regex: SyntaxHighlighter.regexLib.singleQuotedString,		css: 'string' },    // single quoted strings
			{ regex: new RegExp(this.getKeywords(funcs), 'gmi'),		css: 'functions' }, // functions
			{ regex: new RegExp(this.getKeywords(operators), 'gmi'),	css: 'color1' },    // operators and such
			{ regex: new RegExp(this.getKeywords(keywords), 'gmi'),		css: 'keyword' }    // keyword
			];
	}

	Brush.prototype	= new SyntaxHighlighter.Highlighter();
	Brush.aliases	= ['coldfusion','cf'];
	
	SyntaxHighlighter.brushes.ColdFusion = Brush;

	// CommonJS
	typeof(exports) != 'undefined' ? exports.Brush = Brush : null;
})();
/**
 * SyntaxHighlighter
 * http://alexgorbatchev.com/SyntaxHighlighter
 *
 * SyntaxHighlighter is donationware. If you are using it, please donate.
 * http://alexgorbatchev.com/SyntaxHighlighter/donate.html
 *
 * @version
 * 3.0.83 (July 02 2010)
 * 
 * @copyright
 * Copyright (C) 2004-2010 Alex Gorbatchev.
 *
 * @license
 * Dual licensed under the MIT and GPL licenses.
 */
;(function()
{
	// CommonJS
	typeof(require) != 'undefined' ? SyntaxHighlighter = require('shCore').SyntaxHighlighter : null;

	function Brush()
	{
		// Copyright 2006 Shin, YoungJin
	
		var datatypes =	'ATOM BOOL BOOLEAN BYTE CHAR COLORREF DWORD DWORDLONG DWORD_PTR ' +
						'DWORD32 DWORD64 FLOAT HACCEL HALF_PTR HANDLE HBITMAP HBRUSH ' +
						'HCOLORSPACE HCONV HCONVLIST HCURSOR HDC HDDEDATA HDESK HDROP HDWP ' +
						'HENHMETAFILE HFILE HFONT HGDIOBJ HGLOBAL HHOOK HICON HINSTANCE HKEY ' +
						'HKL HLOCAL HMENU HMETAFILE HMODULE HMONITOR HPALETTE HPEN HRESULT ' +
						'HRGN HRSRC HSZ HWINSTA HWND INT INT_PTR INT32 INT64 LANGID LCID LCTYPE ' +
						'LGRPID LONG LONGLONG LONG_PTR LONG32 LONG64 LPARAM LPBOOL LPBYTE LPCOLORREF ' +
						'LPCSTR LPCTSTR LPCVOID LPCWSTR LPDWORD LPHANDLE LPINT LPLONG LPSTR LPTSTR ' +
						'LPVOID LPWORD LPWSTR LRESULT PBOOL PBOOLEAN PBYTE PCHAR PCSTR PCTSTR PCWSTR ' +
						'PDWORDLONG PDWORD_PTR PDWORD32 PDWORD64 PFLOAT PHALF_PTR PHANDLE PHKEY PINT ' +
						'PINT_PTR PINT32 PINT64 PLCID PLONG PLONGLONG PLONG_PTR PLONG32 PLONG64 POINTER_32 ' +
						'POINTER_64 PSHORT PSIZE_T PSSIZE_T PSTR PTBYTE PTCHAR PTSTR PUCHAR PUHALF_PTR ' +
						'PUINT PUINT_PTR PUINT32 PUINT64 PULONG PULONGLONG PULONG_PTR PULONG32 PULONG64 ' +
						'PUSHORT PVOID PWCHAR PWORD PWSTR SC_HANDLE SC_LOCK SERVICE_STATUS_HANDLE SHORT ' +
						'SIZE_T SSIZE_T TBYTE TCHAR UCHAR UHALF_PTR UINT UINT_PTR UINT32 UINT64 ULONG ' +
						'ULONGLONG ULONG_PTR ULONG32 ULONG64 USHORT USN VOID WCHAR WORD WPARAM WPARAM WPARAM ' +
						'char bool short int __int32 __int64 __int8 __int16 long float double __wchar_t ' +
						'clock_t _complex _dev_t _diskfree_t div_t ldiv_t _exception _EXCEPTION_POINTERS ' +
						'FILE _finddata_t _finddatai64_t _wfinddata_t _wfinddatai64_t __finddata64_t ' +
						'__wfinddata64_t _FPIEEE_RECORD fpos_t _HEAPINFO _HFILE lconv intptr_t ' +
						'jmp_buf mbstate_t _off_t _onexit_t _PNH ptrdiff_t _purecall_handler ' +
						'sig_atomic_t size_t _stat __stat64 _stati64 terminate_function ' +
						'time_t __time64_t _timeb __timeb64 tm uintptr_t _utimbuf ' +
						'va_list wchar_t wctrans_t wctype_t wint_t signed';

		var keywords =	'break case catch class const __finally __exception __try ' +
						'const_cast continue private public protected __declspec ' +
						'default delete deprecated dllexport dllimport do dynamic_cast ' +
						'else enum explicit extern if for friend goto inline ' +
						'mutable naked namespace new noinline noreturn nothrow ' +
						'register reinterpret_cast return selectany ' +
						'sizeof static static_cast struct switch template this ' +
						'thread throw true false try typedef typeid typename union ' +
						'using uuid virtual void volatile whcar_t while';
					
		var functions =	'assert isalnum isalpha iscntrl isdigit isgraph islower isprint' +
						'ispunct isspace isupper isxdigit tolower toupper errno localeconv ' +
						'setlocale acos asin atan atan2 ceil cos cosh exp fabs floor fmod ' +
						'frexp ldexp log log10 modf pow sin sinh sqrt tan tanh jmp_buf ' +
						'longjmp setjmp raise signal sig_atomic_t va_arg va_end va_start ' +
						'clearerr fclose feof ferror fflush fgetc fgetpos fgets fopen ' +
						'fprintf fputc fputs fread freopen fscanf fseek fsetpos ftell ' +
						'fwrite getc getchar gets perror printf putc putchar puts remove ' +
						'rename rewind scanf setbuf setvbuf sprintf sscanf tmpfile tmpnam ' +
						'ungetc vfprintf vprintf vsprintf abort abs atexit atof atoi atol ' +
						'bsearch calloc div exit free getenv labs ldiv malloc mblen mbstowcs ' +
						'mbtowc qsort rand realloc srand strtod strtol strtoul system ' +
						'wcstombs wctomb memchr memcmp memcpy memmove memset strcat strchr ' +
						'strcmp strcoll strcpy strcspn strerror strlen strncat strncmp ' +
						'strncpy strpbrk strrchr strspn strstr strtok strxfrm asctime ' +
						'clock ctime difftime gmtime localtime mktime strftime time';

		this.regexList = [
			{ regex: SyntaxHighlighter.regexLib.singleLineCComments,	css: 'comments' },			// one line comments
			{ regex: SyntaxHighlighter.regexLib.multiLineCComments,		css: 'comments' },			// multiline comments
			{ regex: SyntaxHighlighter.regexLib.doubleQuotedString,		css: 'string' },			// strings
			{ regex: SyntaxHighlighter.regexLib.singleQuotedString,		css: 'string' },			// strings
			{ regex: /^ *#.*/gm,										css: 'preprocessor' },
			{ regex: new RegExp(this.getKeywords(datatypes), 'gm'),		css: 'color1 bold' },
			{ regex: new RegExp(this.getKeywords(functions), 'gm'),		css: 'functions bold' },
			{ regex: new RegExp(this.getKeywords(keywords), 'gm'),		css: 'keyword bold' }
			];
	};

	Brush.prototype	= new SyntaxHighlighter.Highlighter();
	Brush.aliases	= ['cpp', 'c'];

	SyntaxHighlighter.brushes.Cpp = Brush;

	// CommonJS
	typeof(exports) != 'undefined' ? exports.Brush = Brush : null;
})();
/**
 * SyntaxHighlighter
 * http://alexgorbatchev.com/SyntaxHighlighter
 *
 * SyntaxHighlighter is donationware. If you are using it, please donate.
 * http://alexgorbatchev.com/SyntaxHighlighter/donate.html
 *
 * @version
 * 3.0.83 (July 02 2010)
 * 
 * @copyright
 * Copyright (C) 2004-2010 Alex Gorbatchev.
 *
 * @license
 * Dual licensed under the MIT and GPL licenses.
 */
;(function()
{
	// CommonJS
	typeof(require) != 'undefined' ? SyntaxHighlighter = require('shCore').SyntaxHighlighter : null;

	function Brush()
	{
		function getKeywordsCSS(str)
		{
			return '\\b([a-z_]|)' + str.replace(/ /g, '(?=:)\\b|\\b([a-z_\\*]|\\*|)') + '(?=:)\\b';
		};
	
		function getValuesCSS(str)
		{
			return '\\b' + str.replace(/ /g, '(?!-)(?!:)\\b|\\b()') + '\:\\b';
		};

		var keywords =	'ascent azimuth background-attachment background-color background-image background-position ' +
						'background-repeat background baseline bbox border-collapse border-color border-spacing border-style border-top ' +
						'border-right border-bottom border-left border-top-color border-right-color border-bottom-color border-left-color ' +
						'border-top-style border-right-style border-bottom-style border-left-style border-top-width border-right-width ' +
						'border-bottom-width border-left-width border-width border bottom cap-height caption-side centerline clear clip color ' +
						'content counter-increment counter-reset cue-after cue-before cue cursor definition-src descent direction display ' +
						'elevation empty-cells float font-size-adjust font-family font-size font-stretch font-style font-variant font-weight font ' +
						'height left letter-spacing line-height list-style-image list-style-position list-style-type list-style margin-top ' +
						'margin-right margin-bottom margin-left margin marker-offset marks mathline max-height max-width min-height min-width orphans ' +
						'outline-color outline-style outline-width outline overflow padding-top padding-right padding-bottom padding-left padding page ' +
						'page-break-after page-break-before page-break-inside pause pause-after pause-before pitch pitch-range play-during position ' +
						'quotes right richness size slope src speak-header speak-numeral speak-punctuation speak speech-rate stemh stemv stress ' +
						'table-layout text-align top text-decoration text-indent text-shadow text-transform unicode-bidi unicode-range units-per-em ' +
						'vertical-align visibility voice-family volume white-space widows width widths word-spacing x-height z-index';

		var values =	'above absolute all always aqua armenian attr aural auto avoid baseline behind below bidi-override black blink block blue bold bolder '+
						'both bottom braille capitalize caption center center-left center-right circle close-quote code collapse compact condensed '+
						'continuous counter counters crop cross crosshair cursive dashed decimal decimal-leading-zero default digits disc dotted double '+
						'embed embossed e-resize expanded extra-condensed extra-expanded fantasy far-left far-right fast faster fixed format fuchsia '+
						'gray green groove handheld hebrew help hidden hide high higher icon inline-table inline inset inside invert italic '+
						'justify landscape large larger left-side left leftwards level lighter lime line-through list-item local loud lower-alpha '+
						'lowercase lower-greek lower-latin lower-roman lower low ltr marker maroon medium message-box middle mix move narrower '+
						'navy ne-resize no-close-quote none no-open-quote no-repeat normal nowrap n-resize nw-resize oblique olive once open-quote outset '+
						'outside overline pointer portrait pre print projection purple red relative repeat repeat-x repeat-y rgb ridge right right-side '+
						'rightwards rtl run-in screen scroll semi-condensed semi-expanded separate se-resize show silent silver slower slow '+
						'small small-caps small-caption smaller soft solid speech spell-out square s-resize static status-bar sub super sw-resize '+
						'table-caption table-cell table-column table-column-group table-footer-group table-header-group table-row table-row-group teal '+
						'text-bottom text-top thick thin top transparent tty tv ultra-condensed ultra-expanded underline upper-alpha uppercase upper-latin '+
						'upper-roman url visible wait white wider w-resize x-fast x-high x-large x-loud x-low x-slow x-small x-soft xx-large xx-small yellow';

		var fonts =		'[mM]onospace [tT]ahoma [vV]erdana [aA]rial [hH]elvetica [sS]ans-serif [sS]erif [cC]ourier mono sans serif';
	
		this.regexList = [
			{ regex: SyntaxHighlighter.regexLib.multiLineCComments,		css: 'comments' },	// multiline comments
			{ regex: SyntaxHighlighter.regexLib.doubleQuotedString,		css: 'string' },	// double quoted strings
			{ regex: SyntaxHighlighter.regexLib.singleQuotedString,		css: 'string' },	// single quoted strings
			{ regex: /\#[a-fA-F0-9]{3,6}/g,								css: 'value' },		// html colors
			{ regex: /(-?\d+)(\.\d+)?(px|em|pt|\:|\%|)/g,				css: 'value' },		// sizes
			{ regex: /!important/g,										css: 'color3' },	// !important
			{ regex: new RegExp(getKeywordsCSS(keywords), 'gm'),		css: 'keyword' },	// keywords
			{ regex: new RegExp(getValuesCSS(values), 'g'),				css: 'value' },		// values
			{ regex: new RegExp(this.getKeywords(fonts), 'g'),			css: 'color1' }		// fonts
			];

		this.forHtmlScript({ 
			left: /(&lt;|<)\s*style.*?(&gt;|>)/gi, 
			right: /(&lt;|<)\/\s*style\s*(&gt;|>)/gi 
			});
	};

	Brush.prototype	= new SyntaxHighlighter.Highlighter();
	Brush.aliases	= ['css'];

	SyntaxHighlighter.brushes.CSS = Brush;

	// CommonJS
	typeof(exports) != 'undefined' ? exports.Brush = Brush : null;
})();
/**
 * SyntaxHighlighter
 * http://alexgorbatchev.com/SyntaxHighlighter
 *
 * SyntaxHighlighter is donationware. If you are using it, please donate.
 * http://alexgorbatchev.com/SyntaxHighlighter/donate.html
 *
 * @version
 * 3.0.83 (July 02 2010)
 * 
 * @copyright
 * Copyright (C) 2004-2010 Alex Gorbatchev.
 *
 * @license
 * Dual licensed under the MIT and GPL licenses.
 */
;(function()
{
	// CommonJS
	typeof(require) != 'undefined' ? SyntaxHighlighter = require('shCore').SyntaxHighlighter : null;

	function Brush()
	{
		var keywords =	'abs addr and ansichar ansistring array as asm begin boolean byte cardinal ' +
						'case char class comp const constructor currency destructor div do double ' +
						'downto else end except exports extended false file finalization finally ' +
						'for function goto if implementation in inherited int64 initialization ' +
						'integer interface is label library longint longword mod nil not object ' +
						'of on or packed pansichar pansistring pchar pcurrency pdatetime pextended ' +
						'pint64 pointer private procedure program property pshortstring pstring ' +
						'pvariant pwidechar pwidestring protected public published raise real real48 ' +
						'record repeat set shl shortint shortstring shr single smallint string then ' +
						'threadvar to true try type unit until uses val var varirnt while widechar ' +
						'widestring with word write writeln xor';

		this.regexList = [
			{ regex: /\(\*[\s\S]*?\*\)/gm,								css: 'comments' },  	// multiline comments (* *)
			{ regex: /{(?!\$)[\s\S]*?}/gm,								css: 'comments' },  	// multiline comments { }
			{ regex: SyntaxHighlighter.regexLib.singleLineCComments,	css: 'comments' },  	// one line
			{ regex: SyntaxHighlighter.regexLib.singleQuotedString,		css: 'string' },		// strings
			{ regex: /\{\$[a-zA-Z]+ .+\}/g,								css: 'color1' },		// compiler Directives and Region tags
			{ regex: /\b[\d\.]+\b/g,									css: 'value' },			// numbers 12345
			{ regex: /\$[a-zA-Z0-9]+\b/g,								css: 'value' },			// numbers $F5D3
			{ regex: new RegExp(this.getKeywords(keywords), 'gmi'),		css: 'keyword' }		// keyword
			];
	};

	Brush.prototype	= new SyntaxHighlighter.Highlighter();
	Brush.aliases	= ['delphi', 'pascal', 'pas'];

	SyntaxHighlighter.brushes.Delphi = Brush;

	// CommonJS
	typeof(exports) != 'undefined' ? exports.Brush = Brush : null;
})();
/**
 * SyntaxHighlighter
 * http://alexgorbatchev.com/SyntaxHighlighter
 *
 * SyntaxHighlighter is donationware. If you are using it, please donate.
 * http://alexgorbatchev.com/SyntaxHighlighter/donate.html
 *
 * @version
 * 3.0.83 (July 02 2010)
 * 
 * @copyright
 * Copyright (C) 2004-2010 Alex Gorbatchev.
 *
 * @license
 * Dual licensed under the MIT and GPL licenses.
 */
;(function()
{
	// CommonJS
	typeof(require) != 'undefined' ? SyntaxHighlighter = require('shCore').SyntaxHighlighter : null;

	function Brush()
	{
		this.regexList = [
			{ regex: /^\+\+\+.*$/gm,		css: 'color2' },
			{ regex: /^\-\-\-.*$/gm,		css: 'color2' },
			{ regex: /^\s.*$/gm,			css: 'color1' },
			{ regex: /^@@.*@@$/gm,			css: 'variable' },
			{ regex: /^\+[^\+]{1}.*$/gm,	css: 'string' },
			{ regex: /^\-[^\-]{1}.*$/gm,	css: 'comments' }
			];
	};

	Brush.prototype	= new SyntaxHighlighter.Highlighter();
	Brush.aliases	= ['diff', 'patch'];

	SyntaxHighlighter.brushes.Diff = Brush;

	// CommonJS
	typeof(exports) != 'undefined' ? exports.Brush = Brush : null;
})();
/**
 * SyntaxHighlighter
 * http://alexgorbatchev.com/SyntaxHighlighter
 *
 * SyntaxHighlighter is donationware. If you are using it, please donate.
 * http://alexgorbatchev.com/SyntaxHighlighter/donate.html
 *
 * @version
 * 3.0.83 (July 02 2010)
 * 
 * @copyright
 * Copyright (C) 2004-2010 Alex Gorbatchev.
 *
 * @license
 * Dual licensed under the MIT and GPL licenses.
 */
;(function()
{
	// CommonJS
	typeof(require) != 'undefined' ? SyntaxHighlighter = require('shCore').SyntaxHighlighter : null;

	function Brush()
	{
		// Contributed by Jean-Lou Dupont
		// http://jldupont.blogspot.com/2009/06/erlang-syntax-highlighter.html  

		// According to: http://erlang.org/doc/reference_manual/introduction.html#1.5
		var keywords = 'after and andalso band begin bnot bor bsl bsr bxor '+
			'case catch cond div end fun if let not of or orelse '+
			'query receive rem try when xor'+
			// additional
			' module export import define';

		this.regexList = [
			{ regex: new RegExp("[A-Z][A-Za-z0-9_]+", 'g'), 			css: 'constants' },
			{ regex: new RegExp("\\%.+", 'gm'), 						css: 'comments' },
			{ regex: new RegExp("\\?[A-Za-z0-9_]+", 'g'), 				css: 'preprocessor' },
			{ regex: new RegExp("[a-z0-9_]+:[a-z0-9_]+", 'g'), 			css: 'functions' },
			{ regex: SyntaxHighlighter.regexLib.doubleQuotedString,		css: 'string' },
			{ regex: SyntaxHighlighter.regexLib.singleQuotedString,		css: 'string' },
			{ regex: new RegExp(this.getKeywords(keywords),	'gm'),		css: 'keyword' }
			];
	};

	Brush.prototype	= new SyntaxHighlighter.Highlighter();
	Brush.aliases	= ['erl', 'erlang'];

	SyntaxHighlighter.brushes.Erland = Brush;

	// CommonJS
	typeof(exports) != 'undefined' ? exports.Brush = Brush : null;
})();
/**
 * SyntaxHighlighter
 * http://alexgorbatchev.com/SyntaxHighlighter
 *
 * SyntaxHighlighter is donationware. If you are using it, please donate.
 * http://alexgorbatchev.com/SyntaxHighlighter/donate.html
 *
 * @version
 * 3.0.83 (July 02 2010)
 * 
 * @copyright
 * Copyright (C) 2004-2010 Alex Gorbatchev.
 *
 * @license
 * Dual licensed under the MIT and GPL licenses.
 */
;(function()
{
	// CommonJS
	typeof(require) != 'undefined' ? SyntaxHighlighter = require('shCore').SyntaxHighlighter : null;

	function Brush()
	{
		// Contributed by Andres Almiray
		// http://jroller.com/aalmiray/entry/nice_source_code_syntax_highlighter

		var keywords =	'as assert break case catch class continue def default do else extends finally ' +
						'if in implements import instanceof interface new package property return switch ' +
						'throw throws try while public protected private static';
		var types    =  'void boolean byte char short int long float double';
		var constants = 'null';
		var methods   = 'allProperties count get size '+
						'collect each eachProperty eachPropertyName eachWithIndex find findAll ' +
						'findIndexOf grep inject max min reverseEach sort ' +
						'asImmutable asSynchronized flatten intersect join pop reverse subMap toList ' +
						'padRight padLeft contains eachMatch toCharacter toLong toUrl tokenize ' +
						'eachFile eachFileRecurse eachB yte eachLine readBytes readLine getText ' +
						'splitEachLine withReader append encodeBase64 decodeBase64 filterLine ' +
						'transformChar transformLine withOutputStream withPrintWriter withStream ' +
						'withStreams withWriter withWriterAppend write writeLine '+
						'dump inspect invokeMethod print println step times upto use waitForOrKill '+
						'getText';

		this.regexList = [
			{ regex: SyntaxHighlighter.regexLib.singleLineCComments,				css: 'comments' },		// one line comments
			{ regex: SyntaxHighlighter.regexLib.multiLineCComments,					css: 'comments' },		// multiline comments
			{ regex: SyntaxHighlighter.regexLib.doubleQuotedString,					css: 'string' },		// strings
			{ regex: SyntaxHighlighter.regexLib.singleQuotedString,					css: 'string' },		// strings
			{ regex: /""".*"""/g,													css: 'string' },		// GStrings
			{ regex: new RegExp('\\b([\\d]+(\\.[\\d]+)?|0x[a-f0-9]+)\\b', 'gi'),	css: 'value' },			// numbers
			{ regex: new RegExp(this.getKeywords(keywords), 'gm'),					css: 'keyword' },		// goovy keyword
			{ regex: new RegExp(this.getKeywords(types), 'gm'),						css: 'color1' },		// goovy/java type
			{ regex: new RegExp(this.getKeywords(constants), 'gm'),					css: 'constants' },		// constants
			{ regex: new RegExp(this.getKeywords(methods), 'gm'),					css: 'functions' }		// methods
			];

		this.forHtmlScript(SyntaxHighlighter.regexLib.aspScriptTags);
	}

	Brush.prototype	= new SyntaxHighlighter.Highlighter();
	Brush.aliases	= ['groovy'];

	SyntaxHighlighter.brushes.Groovy = Brush;

	// CommonJS
	typeof(exports) != 'undefined' ? exports.Brush = Brush : null;
})();
SyntaxHighlighter.brushes.Haskell = function()
{
	// Copyright 2009 watashi
    // http://watashi.ws/blog
    // Zejun.WU@gmail.com
	
    var constants = 'True False Nothing Just Left Right LT EQ GT';

	var datatypes =	'Bool Maybe Either Ordering Char String Int Integer Float Double Rational ' +
                    'IO ReadS ShowS FilePath IOError Monad Functor Show Read' +
                    'Eq Ord Enum Bounded Num Real Integral Fractional Floating RealFrac RealFloat';
					
	var functions =	'abs acos acosh all and any appendFile applyM asTypeOf asin asinh atan atan2 atanh ' +
                    'break catch ceiling compare concat concatMap const cos cosh curry cycle ' +
                    'decodeFloat div divMod drop dropWhile elem encodeFloat enumFrom enumFromThen ' +
                    'enumFromThenTo enumFromTo error even exp exponent fail filter flip floatDigits ' +
                    'floatRadix floatRange floor fmap foldl foldl1 foldr foldr1 fromEnum fromInteger ' +
                    'fromIntegral fromRational fst gcd getChar getContents getLine head id init interact ' +
                    'ioError isDenormalized isIEEE isInfinite isNaN isNegativeZero iterate last lcm ' +
                    'length lex lines log logBase lookup map mapM mapM_ max maxBound maximum maybe min ' +
                    'minBound minimum mod negate not notElem null odd or otherwise pi pred print product ' +
                    'properFraction putChar putStr putStrLn quot quotRem read readFile readIO readList ' +
                    'readLn readParen reads readsPrec realToFrac recip rem repeat replicate return ' +
                    'reverse round scaleFloat scanl scanl1 scanr scanr1 seq sequence sequence_ show ' +
                    'showChar showList showParen showString shows showsPrec significand signum sin sinh ' +
                    'snd span splitAt sqrt subtract succ sum tail take takeWhile tan tanh toEnum ' +
                    'toInteger toRational truncate uncurry undefined unlines until unwords unzip unzip3 ' +
                    'userError words writeFile zip zip3 zipWith zipWith3';    

	var keywords =	'as case of class data default deriving do forall foreign hiding ' +
                    'if then else import instance let in mdo module newtype qualified type where';

	this.findMatches = function(regexList, code) {
		code = code.replace(/&gt;/g, '>').replace(/&lt;/g, '<').replace(/&amp;/g, '&');
		this.code = code;
		return SyntaxHighlighter.Highlighter.prototype.findMatches.apply(this, [regexList, code]);
	};

    this.regexList = [
		{ regex: /{-#[\s\S]*?#-}/g,	                                css: 'preprocessor' },
		{ regex: /--.*/g,	                                        css: 'comments' },      // one line comments
		{ regex: /{-(?!\$)[\s\S]*?-}/gm,	                        css: 'comments' },      // multiline comments
		{ regex: /'.'/g,                                     		css: 'string' },        // chars
		{ regex: SyntaxHighlighter.regexLib.doubleQuotedString,		css: 'string' },        // strings
        { regex: /([-!#$%&*+/?@^|~:.\\])+/g,                      css: 'keyword bold' },  // infix operators
        { regex: /`[a-z][a-z0-9_']*`/g,                             css: 'keyword bold' },  // infix operators
        { regex: /\b(\d+|0x[0-9a-f]+)\b/gi,                         css: 'value' },         // integer
        { regex: /\b\d+(\.\d*)?([eE][+-]?\d+)?\b/gi,                css: 'value' },         // floating number
        { regex: new RegExp(this.getKeywords(constants), 'g'),      css: 'color1 bold' },
		{ regex: new RegExp(this.getKeywords(datatypes), 'g'),		css: 'color1 bold' },
		{ regex: new RegExp(this.getKeywords(functions), 'g'),		css: 'functions bold' },
		{ regex: new RegExp(this.getKeywords(keywords), 'gm'),   	css: 'keyword bold' }
	];
};

SyntaxHighlighter.brushes.Haskell.prototype	= new SyntaxHighlighter.Highlighter();
SyntaxHighlighter.brushes.Haskell.aliases	= ['haskell'];

/**
 * SyntaxHighlighter
 * http://alexgorbatchev.com/SyntaxHighlighter
 *
 * SyntaxHighlighter is donationware. If you are using it, please donate.
 * http://alexgorbatchev.com/SyntaxHighlighter/donate.html
 *
 * @version
 * 3.0.83 (July 02 2010)
 * 
 * @copyright
 * Copyright (C) 2004-2010 Alex Gorbatchev.
 *
 * @license
 * Dual licensed under the MIT and GPL licenses.
 */
;(function()
{
	// CommonJS
	typeof(require) != 'undefined' ? SyntaxHighlighter = require('shCore').SyntaxHighlighter : null;

	function Brush()
	{
		var keywords =	'break case catch continue ' +
						'default delete do else false  ' +
						'for function if in instanceof ' +
						'new null return super switch ' +
						'this throw true try typeof var while with'
						;

		var r = SyntaxHighlighter.regexLib;
		
		this.regexList = [
			{ regex: r.multiLineDoubleQuotedString,					css: 'string' },			// double quoted strings
			{ regex: r.multiLineSingleQuotedString,					css: 'string' },			// single quoted strings
			{ regex: r.singleLineCComments,							css: 'comments' },			// one line comments
			{ regex: r.multiLineCComments,							css: 'comments' },			// multiline comments
			{ regex: /\s*#.*/gm,									css: 'preprocessor' },		// preprocessor tags like #region and #endregion
			{ regex: new RegExp(this.getKeywords(keywords), 'gm'),	css: 'keyword' }			// keywords
			];
	
		this.forHtmlScript(r.scriptScriptTags);
	};

	Brush.prototype	= new SyntaxHighlighter.Highlighter();
	Brush.aliases	= ['js', 'jscript', 'javascript'];

	SyntaxHighlighter.brushes.JScript = Brush;

	// CommonJS
	typeof(exports) != 'undefined' ? exports.Brush = Brush : null;
})();
/**
 * SyntaxHighlighter
 * http://alexgorbatchev.com/SyntaxHighlighter
 *
 * SyntaxHighlighter is donationware. If you are using it, please donate.
 * http://alexgorbatchev.com/SyntaxHighlighter/donate.html
 *
 * @version
 * 3.0.83 (July 02 2010)
 * 
 * @copyright
 * Copyright (C) 2004-2010 Alex Gorbatchev.
 *
 * @license
 * Dual licensed under the MIT and GPL licenses.
 */
;(function()
{
	// CommonJS
	typeof(require) != 'undefined' ? SyntaxHighlighter = require('shCore').SyntaxHighlighter : null;

	function Brush()
	{
		var keywords =	'abstract assert boolean break byte case catch char class const ' +
						'continue default do double else enum extends ' +
						'false final finally float for goto if implements import ' +
						'instanceof int interface long native new null ' +
						'package private protected public return ' +
						'short static strictfp super switch synchronized this throw throws true ' +
						'transient try void volatile while';

		this.regexList = [
			{ regex: SyntaxHighlighter.regexLib.singleLineCComments,	css: 'comments' },		// one line comments
			{ regex: /\/\*([^\*][\s\S]*)?\*\//gm,						css: 'comments' },	 	// multiline comments
			{ regex: /\/\*(?!\*\/)\*[\s\S]*?\*\//gm,					css: 'preprocessor' },	// documentation comments
			{ regex: SyntaxHighlighter.regexLib.doubleQuotedString,		css: 'string' },		// strings
			{ regex: SyntaxHighlighter.regexLib.singleQuotedString,		css: 'string' },		// strings
			{ regex: /\b([\d]+(\.[\d]+)?|0x[a-f0-9]+)\b/gi,				css: 'value' },			// numbers
			{ regex: /(?!\@interface\b)\@[\$\w]+\b/g,					css: 'color1' },		// annotation @anno
			{ regex: /\@interface\b/g,									css: 'color2' },		// @interface keyword
			{ regex: new RegExp(this.getKeywords(keywords), 'gm'),		css: 'keyword' }		// java keyword
			];

		this.forHtmlScript({
			left	: /(&lt;|<)%[@!=]?/g, 
			right	: /%(&gt;|>)/g 
		});
	};

	Brush.prototype	= new SyntaxHighlighter.Highlighter();
	Brush.aliases	= ['java'];

	SyntaxHighlighter.brushes.Java = Brush;

	// CommonJS
	typeof(exports) != 'undefined' ? exports.Brush = Brush : null;
})();
/**
 * SyntaxHighlighter
 * http://alexgorbatchev.com/SyntaxHighlighter
 *
 * SyntaxHighlighter is donationware. If you are using it, please donate.
 * http://alexgorbatchev.com/SyntaxHighlighter/donate.html
 *
 * @version
 * 3.0.83 (July 02 2010)
 * 
 * @copyright
 * Copyright (C) 2004-2010 Alex Gorbatchev.
 *
 * @license
 * Dual licensed under the MIT and GPL licenses.
 */
;(function()
{
	// CommonJS
	typeof(require) != 'undefined' ? SyntaxHighlighter = require('shCore').SyntaxHighlighter : null;

	function Brush()
	{
		// Contributed by Patrick Webster
		// http://patrickwebster.blogspot.com/2009/04/javafx-brush-for-syntaxhighlighter.html
		var datatypes =	'Boolean Byte Character Double Duration '
						+ 'Float Integer Long Number Short String Void'
						;

		var keywords = 'abstract after and as assert at before bind bound break catch class '
						+ 'continue def delete else exclusive extends false finally first for from '
						+ 'function if import in indexof init insert instanceof into inverse last '
						+ 'lazy mixin mod nativearray new not null on or override package postinit '
						+ 'protected public public-init public-read replace return reverse sizeof '
						+ 'step super then this throw true try tween typeof var where while with '
						+ 'attribute let private readonly static trigger'
						;

		this.regexList = [
			{ regex: SyntaxHighlighter.regexLib.singleLineCComments,	css: 'comments' },
			{ regex: SyntaxHighlighter.regexLib.multiLineCComments,		css: 'comments' },
			{ regex: SyntaxHighlighter.regexLib.singleQuotedString,		css: 'string' },
			{ regex: SyntaxHighlighter.regexLib.doubleQuotedString,		css: 'string' },
			{ regex: /(-?\.?)(\b(\d*\.?\d+|\d+\.?\d*)(e[+-]?\d+)?|0x[a-f\d]+)\b\.?/gi, css: 'color2' },	// numbers
			{ regex: new RegExp(this.getKeywords(datatypes), 'gm'),		css: 'variable' },	// datatypes
			{ regex: new RegExp(this.getKeywords(keywords), 'gm'),		css: 'keyword' }
		];
		this.forHtmlScript(SyntaxHighlighter.regexLib.aspScriptTags);
	};

	Brush.prototype	= new SyntaxHighlighter.Highlighter();
	Brush.aliases	= ['jfx', 'javafx'];

	SyntaxHighlighter.brushes.JavaFX = Brush;

	// CommonJS
	typeof(exports) != 'undefined' ? exports.Brush = Brush : null;
})();
/**
 * SyntaxHighlighter
 * http://alexgorbatchev.com/
 *
 * SyntaxHighlighter is donationware. If you are using it, please donate.
 * http://alexgorbatchev.com/wiki/SyntaxHighlighter:Donate
 *
 * @version
 * 2.0.296 (March 01 2009)
 * 
 * @copyright
 * Copyright (C) 2004-2009 Alex Gorbatchev.
 *
 * @license
 * This file is part of SyntaxHighlighter.
 * 
 * SyntaxHighlighter is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * SyntaxHighlighter is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with SyntaxHighlighter.  If not, see <http://www.gnu.org/licenses/>.
 * 
 * 
 * Very simple Latex brush
 * http://www.jorgemarsal.com/blog/
 */



SyntaxHighlighter.brushes.Latex = function()
{
	var keywords =	'if fi then elif else for do done until while break continue case function return in eq ne ge le';
	//var commands =  'include usepackage begin end ref label includegraphics';
    
	this.regexList = [
		{ regex: new RegExp('%.*','gm'),		css: 'comments' },		// one line comments
		{ regex: SyntaxHighlighter.regexLib.doubleQuotedString,			css: 'string' },		// double quoted strings
		{ regex: new RegExp('\\\\\\w*','gm'),			css: 'keyword' },		// commands
		{ regex: new RegExp(this.getKeywords(keywords), 'gm'),			css: 'function' },		// keywords
		];
}

SyntaxHighlighter.brushes.Latex.prototype	= new SyntaxHighlighter.Highlighter();
SyntaxHighlighter.brushes.Latex.aliases		= ['latex', 'tex'];

SyntaxHighlighter.brushes.Lisp = function(){

    var funcs     = 'lambda list progn mapcar car cdr reverse member append format';
    var keywords  = 'let while unless cond if eq t nil defvar dotimes setf listp numberp not equal';
    var macros    = 'loop when dolist dotimes defun';
    var operators = '> < + - = * / %';

    this.regexList = [
     { regex: SyntaxHighlighter.regexLib.doubleQuotedString, css: 'string' },
     { regex: new RegExp('&\\w+;', 'g'), css: 'plain' },
     { regex: new RegExp(';.*', 'g'), css: 'comments' },
     { regex: new RegExp("'(\\w|-)+", 'g'), css: 'variable' },
     { regex: new RegExp(this.getKeywords(keywords), 'gm'), css: 'keyword' },
     { regex: new RegExp(this.getKeywords(macros), 'gm'), css: 'keyword' },
     { regex: new RegExp(this.getKeywords(funcs), 'gm'), css: 'functions' },
    ];
    
}

SyntaxHighlighter.brushes.Lisp.prototype = new SyntaxHighlighter.Highlighter();
SyntaxHighlighter.brushes.Lisp.aliases   = ['lisp'];

SyntaxHighlighter.brushes.Lua = function()
{
	var keywords = '\\b(?:and|break|do|else|elseif|end|false|for|function|if|in|local|nil|not|or|repeat|return|then|true|until|while)\\b';
	var functions = '\\b(?:_G|_VERSION|assert|collectgarbage|coroutine\\.create|coroutine\\.resume|coroutine\\.running|coroutine\\.status|coroutine\\.wrap|coroutine\\.yield|coroutine|debug\\.debug|debug\\.getfenv|debug\\.gethook|debug\\.getinfo|debug\\.getlocal|debug\\.getmetatable|debug\\.getregistry|debug\\.getupvalue|debug\\.setfenv|debug\\.sethook|debug\\.setlocal|debug\\.setmetatable|debug\\.setupvalue|debug\\.traceback|debug|dofile|error|getfenv|getmetatable|io\\.close|io\\.flush|io\\.input|io\\.lines|io\\.open|io\\.output|io\\.popen|io\\.read|io\\.stderr|io\\.stdin|io\\.stdout|io\\.tmpfile|io\\.type|io\\.write|io|ipairs|load|loadfile|loadstring|math\\.abs|math\\.acos|math\\.asin|math\\.atan|math\\.atan2|math\\.ceil|math\\.cos|math\\.cosh|math\\.deg|math\\.exp|math\\.floor|math\\.fmod|math\\.frexp|math\\.huge|math\\.ldexp|math\\.log|math\\.log10|math\\.max|math\\.min|math\\.modf|math\\.pi|math\\.pow|math\\.rad|math\\.random|math\\.randomseed|math\\.sin|math\\.sinh|math\\.sqrt|math\\.tan|math\\.tanh|math|module|next|os\\.clock|os\\.date|os\\.difftime|os\\.execute|os\\.exit|os\\.getenv|os\\.remove|os\\.rename|os\\.setlocale|os\\.time|os\\.tmpname|os|package\\.cpath|package\\.loaded|package\\.loaders|package\\.loadlib|package\\.path|package\\.preload|package\\.seeall|package|pairs|pcall|print|rawequal|rawget|rawset|require|select|setfenv|setmetatable|string\\.byte|string\\.char|string\\.dump|string\\.find|string\\.format|string\\.gmatch|string\\.gsub|string\\.len|string\\.lower|string\\.match|string\\.rep|string\\.reverse|string\\.sub|string\\.upper|string|table\\.concat|table\\.insert|table\\.maxn|table\\.remove|table\\.sort|table|tonumber|tostring|type|unpack|xpcall)\\b';
	var methords = ':\\b(?:close|flush|lines|read|seek|setvbuf|write|byte|find|format|gmatch|gsub|len|lower|match|rep|reverse|sub|upper)\\b';
	var deprecates = '\\b(?:_ALERT|_ERRORMESSAGE|_INPUT|_OUTPUT|_PROMPT|_STDERR|_STDIN|_STDOUT|abs|acos|appendto|asin|atan|atan2|call|ceil|clock|closefile|cos|date|deg|difftime|dostring|execute|exit|exp|floor|flush|foreach|foreachi|format|frexp|gcinfo|getenv|getn|globals|gsub|ldexp|loadlib|log|log10|math\\.mod|max|min|mod|newtype|openfile|rad|random|randomseed|rawegal|read|readfrom|remove|rename|seek|setlocale|sin|sort|sqrt|strbyte|strchar|strfind|string\\.gfind|strlen|strlower|strrep|strsub|strupper|table\\.foreach|table\\.foreachi|table\\.getn|table\\.setn|tan|time|tinsert|tmpfile|tmpname|tremove|write|writeto)\\b';

	this.regexList = [
		{ regex: /--\[(=*)\[[\s\S]*?\]\1\]/gm, css: 'comments' }, // block comments
		{ regex: /--(?:[^\[]?|[^\[]{2}.*)\n/g, css: 'comments' }, // single line comments
		{ regex: /(['"])[^'"]*?\1/g, css: 'string' }, // quotes string
		{ regex: /\[(=*)\[[\s\S]*?\]\1\]/gm, css: 'string' }, // block string
		{ regex: /(?:(?:\.\d+|\b\d+(?:\.\d*)?)(?:e[\+-]?\d+)?|\b0x[0-9a-f]+)\b/gi, css: 'value'},
		{ regex: new RegExp(keywords, 'g'), css: 'keyword bold' }, // keywords
		{ regex: new RegExp(functions, 'g'), css: 'functions bold' }, // lua 5.1 functions & names
		{ regex: new RegExp(methords, 'g'), css: 'functions bold' }, // methords for string & file
		{ regex: new RegExp(deprecates, 'g'), css: 'decorator'}, // deprecated names
		];
};
SyntaxHighlighter.brushes.Lua.prototype	= new SyntaxHighlighter.Highlighter();
SyntaxHighlighter.brushes.Lua.aliases	= ['lua'];
/*
2009-11-07 by tsuui: fixed deprecates & keywords, dec & hex number regexp, single line comments regexp
2009-11-09 by tsuui: fixed single line comments regexp
2009-11-12 by tsuui: fixed number regexp
*//**
 *  Author: James Rohal
 *  http://www.jamesrohal.com
 */
SyntaxHighlighter.brushes.Matlab = function()
{
	var functions =	'abs accumarray acos acosd acosh acot acotd acoth acsc acscd acsch actxcontrol actxcontrollist actxcontrolselect actxGetRunningServer actxserver addCause addevent addframe addlistener addOptional addParamValue addpath addpref addprop addproperty addRequired addsample addsampletocollection addtodate addts airy align alim all allchild alpha alphamap amd ancestor and angle annotation Annotation Arrow Properties Annotation Doublearrow Properties Annotation Ellipse Properties Annotation Line Properties Annotation Rectangle Properties Annotation Textarrow Properties Annotation Textbox Properties ans any area Areaseries Properties arrayfun ascii asec asecd asech asin asind asinh assert assignin atan atan2 atand atanh audioplayer audiorecorder aufinfo auread auwrite avifile aviinfo aviread axes Axes Properties axis balance bar barh bar3 bar3h Barseries Properties base2dec beep bench besselh besseli besselj besselk bessely beta betainc betaln bicg bicgstab bin2dec binary bitand bitcmp bitget bitmax bitor bitset bitshift bitxor blanks blkdiag box break brighten brush bsxfun builddocsearchdb builtin bvp4c bvp5c bvpget bvpinit bvpset bvpxtend calendar calllib callSoapService camdolly cameratoolbar camlight camlookat camorbit campan campos camproj camroll camtarget camup camva camzoom cart2pol cart2sph case cast cat catch caxis cd cd cdf2rdf cdfepoch cdfinfo cdfread cdfwrite ceil cell cell2mat cell2struct celldisp cellfun cellplot cellstr cgs char checkin checkout chol cholinc cholupdate circshift cla clabel class classdef clc clear clearvars clear clf clipboard clock close close close closereq cmopts colamd colorbar colordef colormap colormapeditor ColorSpec colperm comet comet3 commandhistory commandwindow compan compass complex computer cond condeig condest coneplot conj continue contour contour3 contourc contourf Contourgroup Properties contourslice contrast conv conv2 convhull convhulln convn copyfile copyobj corrcoef cos cosd cosh cot cotd coth cov cplxpair cputime create createClassFromWsdl createCopy createSoapMessage cross csc cscd csch csvread csvwrite ctranspose cumprod cumsum cumtrapz curl customverctrl cylinder daqread daspect datacursormode datatipinfo date datenum datestr datetick datevec dbclear dbcont dbdown dblquad dbmex dbquit dbstack dbstatus dbstep dbstop dbtype dbup dde23 ddeget ddesd ddeset deal deblank debug dec2base dec2bin dec2hex decic deconv del2 delaunay delaunay3 delaunayn delete delete delete delete delete delete deleteproperty delevent delsample delsamplefromcollection demo depdir depfun det detrend detrend deval diag dialog diary diff diffuse dir dir disp disp disp disp disp display divergence dlmread dlmwrite dmperm doc docopt docsearch dos dot double dragrect drawnow dsearch dsearchn dynamicprops echo echodemo edit eig eigs ellipj ellipke ellipsoid else elseif enableservice end eomday eps eq eq erf erfc erfcx erfinv erfcinv error errorbar Errorbarseries Properties errordlg etime etree etreeplot eval evalc evalin eventlisteners events events Execute exifread exist exit exp expint expm expm1 export2wsdlg eye ezcontour ezcontourf ezmesh ezmeshc ezplot ezplot3 ezpolar ezsurf ezsurfc factor factorial FALSE fclose fclose feather feof ferror feval Feval fft fft2 fftn fftshift fftw fgetl fgetl fgets fgets fieldnames figure Figure Properties figurepalette fileattrib filebrowser File Formats filemarker fileparts fileread filesep fill fill3 filter filter filter2 find findall findfigs findobj findobj findprop findstr finish fitsinfo fitsread fix flipdim fliplr flipud floor flow fminbnd fminsearch fopen fopen for format fplot fprintf fprintf frame2im fread fread freqspace frewind fscanf fscanf fseek ftell ftp full fullfile func2str function function_handle functions funm fwrite fwrite fzero gallery gamma gammainc gammaln gca gcbf gcbo gcd gcf gco ge genpath genvarname get get get get get get get get get getabstime getabstime getappdata GetCharArray getdatasamplesize getDefaultStream getdisp getenv getfield getframe GetFullMatrix getinterpmethod getpixelposition getpref getqualitydesc getReport getsampleusingtime getsampleusingtime gettimeseriesnames gettsafteratevent gettsafterevent gettsatevent gettsbeforeatevent gettsbeforeevent gettsbetweenevents GetVariable GetWorkspaceData ginput global gmres gplot grabcode gradient graymon grid griddata griddata3 griddatan gsvd gtext guidata guide guihandles gunzip gzip hadamard handle hankel hdf hdf5 hdf5info hdf5read hdf5write hdfinfo hdfread hdftool help helpbrowser helpdesk helpdlg helpwin hess hex2dec hex2num hgexport hggroup Hggroup Properties hgload hgsave hgsetget hgtransform Hgtransform Properties hidden hilb hist histc hold home horzcat horzcat hostid hsv2rgb hypot i idealfilter idivide if ifft ifft2 ifftn ifftshift ilu im2frame im2java imag image Image Properties imagesc imfinfo imformats import importdata imread imwrite ind2rgb ind2sub Inf inferiorto info inline inmem inpolygon input inputdlg inputname inputParser inspect instrcallback instrfind instrfindall int2str int8 int16 int32 int64 interfaces interp1 interp1q interp2 interp3 interpft interpn interpstreamspeed intersect intmax intmin intwarning inv invhilb invoke ipermute iqr is* isa isappdata iscell iscellstr ischar iscom isdir isempty isempty isempty isequal isequal isequalwithequalnans isevent isfield isfinite isfloat isglobal ishandle ishold isinf isinteger isinterface isjava isKey iskeyword isletter islogical ismac ismember ismethod isnan isnumeric isobject isocaps isocolors isonormals isosurface ispc ispref isprime isprop isreal isscalar issorted isspace issparse isstr isstrprop isstruct isstudent isunix isvalid isvalid isvalid isvarname isvector j javaaddpath javaArray javachk javaclasspath javaMethod javaObject javarmpath keyboard keys kron last lasterr lasterror lastwarn lcm ldl ldivide rdivide le legend legendre length length length length length libfunctions libfunctionsview libisloaded libpointer libstruct license light Light Properties lightangle lighting lin2mu line Line Properties Lineseries Properties LineSpec linkaxes linkdata linkprop linsolve linspace list listdlg listfonts load load load loadlibrary loadobj log log10 log1p log2 logical loglog logm logspace lookfor lower ls lscov lsqnonneg lsqr lu luinc magic makehgtform mat2cell mat2str material matlabcolon matlabrc matlabroot matlab matlab max max MaximizeCommandWindow maxNumCompThreads mean mean median median memmapfile memory menu mesh meshc meshz meshgrid metaclass methods methodsview mex MException mexext mfilename mget min min MinimizeCommandWindow minres mislocked mkdir mkdir mkpp mldivide mrdivide mlint mlintrpt mlock mmfileinfo mmreader mod mode more move movefile movegui movie movie2avi mput msgbox mtimes mu2lin multibandread multibandwrite munlock namelengthmax NaN nargchk nargin nargout nargoutchk native2unicode nchoosek ndgrid ndims ne ne netcdf newplot nextpow2 nnz noanimate nonzeros norm normest not notebook notify now nthroot null num2cell num2hex num2str numel nzmax ode15i ode23 ode45 ode113 ode15s ode23s ode23t ode23tb odefile odeget odeset odextend onCleanup ones open openfig opengl openvar optimget optimset or ordeig orderfields ordqz ordschur orient orth otherwise pack padecoef pagesetupdlg pan pareto parfor parse parseSoapResponse partialpath pascal patch Patch Properties path path2rc pathsep pathtool pause pbaspect pcg pchip pcode pcolor pdepe pdeval peaks perl perms permute persistent pi pie pie3 pinv planerot playshow plot plot plot3 plotbrowser plotedit plotmatrix plottools plotyy pol2cart polar poly polyarea polyder polyeig polyfit polyint polyval polyvalm pow2 power ppval prefdir preferences primes print printopt printdlg printpreview prod profile profsave propedit propedit properties propertyeditor psi publish PutCharArray PutFullMatrix PutWorkspaceData pwd qmr qr qrdelete qrinsert qrupdate quad quadgk quadl quadv questdlg quit Quit quiver quiver3 Quivergroup Properties qz rand rand randi randi randn randn randperm randperm RandStream RandStream rank rat rats rbbox rcond read readasync real reallog realmax realmin realpow realsqrt record rectangle Rectangle Properties rectint recycle reducepatch reducevolume refresh refreshdata regexp regexpi regexprep regexptranslate registerevent rehash release relationaloperators rem remove removets rename repmat resample resample reset reset reshape residue restoredefaultpath rethrow rethrow return rgb2hsv rgbplot ribbon rmappdata rmdir rmdir rmfield rmpath rmpref root object Root Properties roots rose rosser rot90 rotate rotate3d round rref rsf2csf run save save save saveas saveobj savepath scatter scatter3 Scattergroup Properties schur script sec secd sech selectmoveresize semilogx semilogy sendmail serial serialbreak set set set set set set set set setabstime setabstime setappdata setDefaultStream setdiff setdisp setenv setfield setinterpmethod setpixelposition setpref setstr settimeseriesnames setxor shading shg shiftdim showplottool shrinkfaces sign sin sind single sinh size size size size size slice smooth3 snapnow sort sortrows sound soundsc spalloc sparse spaugment spconvert spdiags specular speye spfun sph2cart sphere spinmap spline spones spparms sprand sprandn sprandsym sprank sprintf spy sqrt sqrtm squeeze ss2tf sscanf stairs Stairseries Properties start startat startup std std stem stem3 Stemseries Properties stop stopasync str2double str2func str2mat str2num strcat strcmp strcmpi stream2 stream3 streamline streamparticles streamribbon streamslice streamtube strfind strings strjust strmatch strncmp strncmpi strread strrep strtok strtrim struct struct2cell structfun strvcat sub2ind subplot subsasgn subsindex subspace subsref substruct subvolume sum sum superiorto support surf surfc surf2patch surface Surface Properties Surfaceplot Properties surfl surfnorm svd svds swapbytes switch symamd symbfact symmlq symrcm symvar synchronize syntax system tan tand tanh tar tempdir tempname tetramesh texlabel text Text Properties textread textscan textwrap throw throwAsCaller tic toc timer timerfind timerfindall timeseries title todatenum toeplitz toolboxdir trace transpose trapz treelayout treeplot tril trimesh triplequad triplot trisurf triu TRUE try tscollection tsearch tsearchn tsprops tstool type typecast uibuttongroup Uibuttongroup Properties uicontextmenu Uicontextmenu Properties uicontrol Uicontrol Properties uigetdir uigetfile uigetpref uiimport uimenu Uimenu Properties uint8 uint16 uint32 uint64 uiopen uipanel Uipanel Properties uipushtool Uipushtool Properties uiputfile uiresume uisave uisetcolor uisetfont uisetpref uistack uitable Uitable Properties uitoggletool Uitoggletool Properties uitoolbar Uitoolbar Properties uiwait undocheckout unicode2native union unique unix unloadlibrary unmkpp unregisterallevents unregisterevent untar unwrap unzip upper urlread urlwrite usejava userpath validateattributes validatestring values vander var var varargin varargout vectorize ver verctrl verLessThan version vertcat vertcat vertcat view viewmtx visdiff volumebounds voronoi voronoin wait waitbar waitfor waitforbuttonpress warndlg warning waterfall wavfinfo wavplay wavread wavrecord wavwrite web weekday what whatsnew which while whitebg who whos wilkinson winopen winqueryreg wk1finfo wk1read wk1write workspace xlabel ylabel zlabel xlim ylim zlim xlsfinfo xlsread xlswrite xmlread xmlwrite xor xslt zeros zip zoom';

	this.regexList = [
		{ regex: /%.*$/gm,	css: 'comments' },			// one line comments
		{ regex: /\{\%[\s\S]*?\%\}/gm,		css: 'comments' },			// multiline comments
		{ regex: SyntaxHighlighter.regexLib.singleQuotedString,		css: 'string' },			// strings
		{ regex: SyntaxHighlighter.regexLib.doubleQuotedString,		css: 'string' },			// strings
		{ regex: new RegExp(this.getKeywords(functions), 'gm'),		css: 'functions bold' }
		];
};
SyntaxHighlighter.brushes.Matlab.prototype	= new SyntaxHighlighter.Highlighter();
SyntaxHighlighter.brushes.Matlab.aliases	= ['matlab'];/**
 * SyntaxHighlighter
 * http://alexgorbatchev.com/
 *
 * This brush was originally created by UNique
 * homepage:   http://un-i.tistory.com/
 * brush page: <unknown>
 */
SyntaxHighlighter.brushes.Nasm8086 = function () {
var A = "MOV CMOVE CMOVZ CMOVNE CMOVNZ CMOVA CMOVNBE CMOVAE CMOVNB CMOVB CMOVNAE CMOVBE CMOVNA CMOVG CMOVNLE CMOVGE CMOVNL CMOVL CMOVNGE CMOVLE CMOVNG CMOVC CMOVNC CMOVO CMOVNO CMOVS CMOVNS CMOVP CMOVPE CMOVNP CMOVPO XCHG BSWAP XADD CMPXCHG CMPXCHG8B PUSH POP PUSHA PUSHAD POPA POPAD IN OUT CWD CDQ CBW CWDE MOVSX MOVZX ADD ADC SUB SBB IMUL MUL IDIV DIV INC DEC NEG CMP DAA DAS AAA AAS AAM AAD AND OR XOR NOT SAR SHR SAL SHL SHRD SHLD ROR ROL RCR RCL BT BTS BTR BTC BSF BSR SETE SETZ SETNE SETNZ SETA SETNBE SETAE SETNB SETNC SETB SETNAE SETC SETBE SETNA SETG SETNLE SETGE SETNL SETL SETNGE SETLE SETNG SETS SETNS SETO SETNO SETPE SETP SETPO SETNP TEST JMP JE JZ JNE JNZ JA JNBE JAE JNB JB JNAE JBE JNA JG JNLE JGE JNL JL JNGE JLE JNG JC JNC JO JNO JS JNS JPO JNP JPE JP JCXZ JECXZ LOOP LOOPZ LOOPE LOOPNZ LOOPNE CALL RET IRET INT INTO BOUND ENTER LEAVE MOVS MOVSB MOVS MOVSW MOVS MOVSD CMPS CMPSB CMPS CMPSW CMPS CMPSD SCAS SCASB SCAS SCASW SCAS SCASD LODS LODSB LODS LODSW LODS LODSD STOS STOSB STOS STOSW STOS STOSD REP REPE REPZ REPNE REPNZ INS INSB INS INSW INS INSD OUTS OUTSB OUTS OUTSW OUTS OUTSD STC CLC CMC CLD STD LAHF SAHF PUSHF PUSHFD POPF POPFD STI CLI LDS LES LFS LGS LSS LEA NOP UB2 XLAT XLATB CPUID  mov cmove cmovz cmovne cmovnz cmova cmovnbe cmovae cmovnb cmovb cmovnae cmovbe cmovna cmovg cmovnle cmovge cmovnl cmovl cmovnge cmovle cmovng cmovc cmovnc cmovo cmovno cmovs cmovns cmovp cmovpe cmovnp cmovpo xchg bswap xadd cmpxchg cmpxchg8b push pop pusha pushad popa popad in out cwd cdq cbw cwde movsx movzx add adc sub sbb imul mul idiv div inc dec neg cmp daa das aaa aas aam aad and or xor not sar shr sal shl shrd shld ror rol rcr rcl bt bts btr btc bsf bsr sete setz setne setnz seta setnbe setae setnb setnc setb setnae setc setbe setna setg setnle setge setnl setl setnge setle setng sets setns seto setno setpe setp setpo setnp test jmp je jz jne jnz ja jnbe jae jnb jb jnae jbe jna jg jnle jge jnl jl jnge jle jng jc jnc jo jno js jns jpo jnp jpe jp jcxz jecxz loop loopz loope loopnz loopne call ret iret int into bound enter leave movs movsb movs movsw movs movsd cmps cmpsb cmps cmpsw cmps cmpsd scas scasb scas scasw scas scasd lods lodsb lods lodsw lods lodsd stos stosb stos stosw stos stosd rep repe repz repne repnz ins insb ins insw ins insd outs outsb outs outsw outs outsd stc clc cmc cld std lahf sahf pushf pushfd popf popfd sti cli lds les lfs lgs lss lea nop ub2 xlat xlatb cpuid [ ]";
var B = "DB DW DD DQ DT EQU = EVEN PAGE TITLE db dw dd dq dt equ even page title SEGMENT PROC ASSUME END ENDP  segment proc assume end endp";
var C = "AX AH AL BX BH BL CX CH CL DX DH DL ax ah al bx bh bl cx ch cl dx dh dl SP BP SI DI sp dp si di IP FL ip fl CS DS SS ES cs ds ss es";
;this.regexList=[{regex:SyntaxHighlighter.regexLib.doubleQuotedString,css:"string"},{regex:SyntaxHighlighter.regexLib.singleQuotedString,css:"string"},{regex:/^ *;.*/gm,css:"comments"},{regex:new RegExp(this.getKeywords(C),"gm"),css:"color1 bold"},{regex:new RegExp(this.getKeywords(B),"gm"),css:"functions bold"},{regex:new RegExp(this.getKeywords(A),"gm"),css:"keyword bold"}];
};
SyntaxHighlighter.brushes.Nasm8086.prototype=new SyntaxHighlighter.Highlighter();
SyntaxHighlighter.brushes.Nasm8086.aliases=["nasm8086","8086","nasm","asm","masm"];/**
 * SyntaxHighlighter - Objective-C Brush
 * http://codepirate.seaandco.com/
 *
 * @version
 * 1.0.0 (February 22 2009)
 *
 * @author
 * Geoffrey Byers
 * 
 * @copyright
 * Copyright (C) 2009 Geoffrey Byers.
 *
 * Licensed under a GNU Lesser General Public License.
 * http://creativecommons.org/licenses/LGPL/2.1/
 *
 *  Updated From:
 *  Code Syntax Highlighter for Objective-C.
 *  Version 0.0.2
 *  Copyright (C) 2006 Shin, YoungJin.
 *  http://scottdensmore.typepad.com/blog/2008/12/objective-c-cocoa-syntax-highlighter.html
 */

SyntaxHighlighter.brushes.ObjC = function()
{
	var datatypes =	'char bool BOOL double float int long short id void';
	
	var keywords = 'IBAction IBOutlet SEL YES NO readwrite readonly nonatomic nil NULL ';
	keywords += 'super self copy ';
	keywords += 'break case catch class const copy __finally __exception __try ';
	keywords += 'const_cast continue private public protected __declspec ';
	keywords += 'default delete deprecated dllexport dllimport do dynamic_cast ';
	keywords += 'else enum explicit extern if for friend goto inline ';
	keywords += 'mutable naked namespace new noinline noreturn nothrow ';
	keywords += 'register reinterpret_cast return selectany ';
	keywords += 'sizeof static static_cast struct switch template this ';
	keywords += 'thread throw true false try typedef typeid typename union ';
	keywords += 'using uuid virtual volatile whcar_t while';
	// keywords += '@property @selector @interface @end @implementation @synthesize ';
	
		
	this.regexList = [
		{ regex: SyntaxHighlighter.regexLib.singleLineCComments,		css: 'comments' },		// one line comments
		{ regex: SyntaxHighlighter.regexLib.multiLineCComments,		css: 'comments' },		// multiline comments
		{ regex: SyntaxHighlighter.regexLib.doubleQuotedString,		css: 'string' },			// double quoted strings
		{ regex: SyntaxHighlighter.regexLib.singleQuotedString,		css: 'string' },			// single quoted strings
		{ regex: new RegExp('^ *#.*', 'gm'),						css: 'preprocessor' },		// preprocessor
		{ regex: new RegExp(this.getKeywords(datatypes), 'gm'),		css: 'datatypes' },		// datatypes
		{ regex: new RegExp(this.getKeywords(keywords), 'gm'),		css: 'keyword' },			// keyword
		{ regex: new RegExp('\\bNS\\w+\\b', 'g'),					css: 'keyword' },			// keyword
		{ regex: new RegExp('@\\w+\\b', 'g'),						css: 'keyword' },			// keyword
		];
	
}

SyntaxHighlighter.brushes.ObjC.prototype = new SyntaxHighlighter.Highlighter();
SyntaxHighlighter.brushes.ObjC.aliases = ['objc', 'obj-c'];/**
 * SyntaxHighlighter
 * http://alexgorbatchev.com/SyntaxHighlighter
 *
 * SyntaxHighlighter is donationware. If you are using it, please donate.
 * http://alexgorbatchev.com/SyntaxHighlighter/donate.html
 *
 * @version
 * 3.0.83 (July 02 2010)
 * 
 * @copyright
 * Copyright (C) 2004-2010 Alex Gorbatchev.
 *
 * @license
 * Dual licensed under the MIT and GPL licenses.
 */
;(function()
{
	// CommonJS
	typeof(require) != 'undefined' ? SyntaxHighlighter = require('shCore').SyntaxHighlighter : null;

	function Brush()
	{
		// Contributed by David Simmons-Duffin and Marty Kube
	
		var funcs = 
			'abs accept alarm atan2 bind binmode chdir chmod chomp chop chown chr ' + 
			'chroot close closedir connect cos crypt defined delete each endgrent ' + 
			'endhostent endnetent endprotoent endpwent endservent eof exec exists ' + 
			'exp fcntl fileno flock fork format formline getc getgrent getgrgid ' + 
			'getgrnam gethostbyaddr gethostbyname gethostent getlogin getnetbyaddr ' + 
			'getnetbyname getnetent getpeername getpgrp getppid getpriority ' + 
			'getprotobyname getprotobynumber getprotoent getpwent getpwnam getpwuid ' + 
			'getservbyname getservbyport getservent getsockname getsockopt glob ' + 
			'gmtime grep hex index int ioctl join keys kill lc lcfirst length link ' + 
			'listen localtime lock log lstat map mkdir msgctl msgget msgrcv msgsnd ' + 
			'oct open opendir ord pack pipe pop pos print printf prototype push ' + 
			'quotemeta rand read readdir readline readlink readpipe recv rename ' + 
			'reset reverse rewinddir rindex rmdir scalar seek seekdir select semctl ' + 
			'semget semop send setgrent sethostent setnetent setpgrp setpriority ' + 
			'setprotoent setpwent setservent setsockopt shift shmctl shmget shmread ' + 
			'shmwrite shutdown sin sleep socket socketpair sort splice split sprintf ' + 
			'sqrt srand stat study substr symlink syscall sysopen sysread sysseek ' + 
			'system syswrite tell telldir time times tr truncate uc ucfirst umask ' + 
			'undef unlink unpack unshift utime values vec wait waitpid warn write';
    
		var keywords =  
			'bless caller continue dbmclose dbmopen die do dump else elsif eval exit ' +
			'for foreach goto if import last local my next no our package redo ref ' + 
			'require return sub tie tied unless untie until use wantarray while';
    
		this.regexList = [
			{ regex: new RegExp('#[^!].*$', 'gm'),					css: 'comments' },
			{ regex: new RegExp('^\\s*#!.*$', 'gm'),				css: 'preprocessor' }, // shebang
			{ regex: SyntaxHighlighter.regexLib.doubleQuotedString,	css: 'string' },
			{ regex: SyntaxHighlighter.regexLib.singleQuotedString,	css: 'string' },
			{ regex: new RegExp('(\\$|@|%)\\w+', 'g'),				css: 'variable' },
			{ regex: new RegExp(this.getKeywords(funcs), 'gmi'),	css: 'functions' },
			{ regex: new RegExp(this.getKeywords(keywords), 'gm'),	css: 'keyword' }
		    ];

		this.forHtmlScript(SyntaxHighlighter.regexLib.phpScriptTags);
	}

	Brush.prototype	= new SyntaxHighlighter.Highlighter();
	Brush.aliases		= ['perl', 'Perl', 'pl'];

	SyntaxHighlighter.brushes.Perl = Brush;

	// CommonJS
	typeof(exports) != 'undefined' ? exports.Brush = Brush : null;
})();
/**
 * SyntaxHighlighter
 * http://alexgorbatchev.com/SyntaxHighlighter
 *
 * SyntaxHighlighter is donationware. If you are using it, please donate.
 * http://alexgorbatchev.com/SyntaxHighlighter/donate.html
 *
 * @version
 * 3.0.83 (July 02 2010)
 * 
 * @copyright
 * Copyright (C) 2004-2010 Alex Gorbatchev.
 *
 * @license
 * Dual licensed under the MIT and GPL licenses.
 */
;(function()
{
	// CommonJS
	typeof(require) != 'undefined' ? SyntaxHighlighter = require('shCore').SyntaxHighlighter : null;

	function Brush()
	{
		var funcs	=	'abs acos acosh addcslashes addslashes ' +
						'array_change_key_case array_chunk array_combine array_count_values array_diff '+
						'array_diff_assoc array_diff_key array_diff_uassoc array_diff_ukey array_fill '+
						'array_filter array_flip array_intersect array_intersect_assoc array_intersect_key '+
						'array_intersect_uassoc array_intersect_ukey array_key_exists array_keys array_map '+
						'array_merge array_merge_recursive array_multisort array_pad array_pop array_product '+
						'array_push array_rand array_reduce array_reverse array_search array_shift '+
						'array_slice array_splice array_sum array_udiff array_udiff_assoc '+
						'array_udiff_uassoc array_uintersect array_uintersect_assoc '+
						'array_uintersect_uassoc array_unique array_unshift array_values array_walk '+
						'array_walk_recursive atan atan2 atanh base64_decode base64_encode base_convert '+
						'basename bcadd bccomp bcdiv bcmod bcmul bindec bindtextdomain bzclose bzcompress '+
						'bzdecompress bzerrno bzerror bzerrstr bzflush bzopen bzread bzwrite ceil chdir '+
						'checkdate checkdnsrr chgrp chmod chop chown chr chroot chunk_split class_exists '+
						'closedir closelog copy cos cosh count count_chars date decbin dechex decoct '+
						'deg2rad delete ebcdic2ascii echo empty end ereg ereg_replace eregi eregi_replace error_log '+
						'error_reporting escapeshellarg escapeshellcmd eval exec exit exp explode extension_loaded '+
						'feof fflush fgetc fgetcsv fgets fgetss file_exists file_get_contents file_put_contents '+
						'fileatime filectime filegroup fileinode filemtime fileowner fileperms filesize filetype '+
						'floatval flock floor flush fmod fnmatch fopen fpassthru fprintf fputcsv fputs fread fscanf '+
						'fseek fsockopen fstat ftell ftok getallheaders getcwd getdate getenv gethostbyaddr gethostbyname '+
						'gethostbynamel getimagesize getlastmod getmxrr getmygid getmyinode getmypid getmyuid getopt '+
						'getprotobyname getprotobynumber getrandmax getrusage getservbyname getservbyport gettext '+
						'gettimeofday gettype glob gmdate gmmktime ini_alter ini_get ini_get_all ini_restore ini_set '+
						'interface_exists intval ip2long is_a is_array is_bool is_callable is_dir is_double '+
						'is_executable is_file is_finite is_float is_infinite is_int is_integer is_link is_long '+
						'is_nan is_null is_numeric is_object is_readable is_real is_resource is_scalar is_soap_fault '+
						'is_string is_subclass_of is_uploaded_file is_writable is_writeable mkdir mktime nl2br '+
						'parse_ini_file parse_str parse_url passthru pathinfo print readlink realpath rewind rewinddir rmdir '+
						'round str_ireplace str_pad str_repeat str_replace str_rot13 str_shuffle str_split '+
						'str_word_count strcasecmp strchr strcmp strcoll strcspn strftime strip_tags stripcslashes '+
						'stripos stripslashes stristr strlen strnatcasecmp strnatcmp strncasecmp strncmp strpbrk '+
						'strpos strptime strrchr strrev strripos strrpos strspn strstr strtok strtolower strtotime '+
						'strtoupper strtr strval substr substr_compare';

		var keywords =	'abstract and array as break case catch cfunction class clone const continue declare default die do ' +
						'else elseif enddeclare endfor endforeach endif endswitch endwhile extends final for foreach ' +
						'function include include_once global goto if implements interface instanceof namespace new ' +
						'old_function or private protected public return require require_once static switch ' +
						'throw try use var while xor ';
		
		var constants	= '__FILE__ __LINE__ __METHOD__ __FUNCTION__ __CLASS__';

		this.regexList = [
			{ regex: SyntaxHighlighter.regexLib.singleLineCComments,	css: 'comments' },			// one line comments
			{ regex: SyntaxHighlighter.regexLib.multiLineCComments,		css: 'comments' },			// multiline comments
			{ regex: SyntaxHighlighter.regexLib.doubleQuotedString,		css: 'string' },			// double quoted strings
			{ regex: SyntaxHighlighter.regexLib.singleQuotedString,		css: 'string' },			// single quoted strings
			{ regex: /\$\w+/g,											css: 'variable' },			// variables
			{ regex: new RegExp(this.getKeywords(funcs), 'gmi'),		css: 'functions' },			// common functions
			{ regex: new RegExp(this.getKeywords(constants), 'gmi'),	css: 'constants' },			// constants
			{ regex: new RegExp(this.getKeywords(keywords), 'gm'),		css: 'keyword' }			// keyword
			];

		this.forHtmlScript(SyntaxHighlighter.regexLib.phpScriptTags);
	};

	Brush.prototype	= new SyntaxHighlighter.Highlighter();
	Brush.aliases	= ['php'];

	SyntaxHighlighter.brushes.Php = Brush;

	// CommonJS
	typeof(exports) != 'undefined' ? exports.Brush = Brush : null;
})();
/**
 * SyntaxHighlighter
 * http://alexgorbatchev.com/SyntaxHighlighter
 *
 * SyntaxHighlighter is donationware. If you are using it, please donate.
 * http://alexgorbatchev.com/SyntaxHighlighter/donate.html
 *
 * @version
 * 3.0.83 (July 02 2010)
 * 
 * @copyright
 * Copyright (C) 2004-2010 Alex Gorbatchev.
 *
 * @license
 * Dual licensed under the MIT and GPL licenses.
 */
;(function()
{
	// CommonJS
	typeof(require) != 'undefined' ? SyntaxHighlighter = require('shCore').SyntaxHighlighter : null;

	function Brush()
	{
	};

	Brush.prototype	= new SyntaxHighlighter.Highlighter();
	Brush.aliases	= ['text', 'plain'];

	SyntaxHighlighter.brushes.Plain = Brush;

	// CommonJS
	typeof(exports) != 'undefined' ? exports.Brush = Brush : null;
})();
/**
 * SyntaxHighlighter
 * http://alexgorbatchev.com/SyntaxHighlighter
 *
 * SyntaxHighlighter is donationware. If you are using it, please donate.
 * http://alexgorbatchev.com/SyntaxHighlighter/donate.html
 *
 * @version
 * 3.0.83 (July 02 2010)
 * 
 * @copyright
 * Copyright (C) 2004-2010 Alex Gorbatchev.
 *
 * @license
 * Dual licensed under the MIT and GPL licenses.
 */
;(function()
{
	// CommonJS
	typeof(require) != 'undefined' ? SyntaxHighlighter = require('shCore').SyntaxHighlighter : null;

	function Brush()
	{
		// Contributes by B.v.Zanten, Getronics
		// http://confluence.atlassian.com/display/CONFEXT/New+Code+Macro

		var keywords = 'Add-Content Add-History Add-Member Add-PSSnapin Clear(-Content)? Clear-Item ' +
					'Clear-ItemProperty Clear-Variable Compare-Object ConvertFrom-SecureString Convert-Path ' +
					'ConvertTo-Html ConvertTo-SecureString Copy(-Item)? Copy-ItemProperty Export-Alias ' +
					'Export-Clixml Export-Console Export-Csv ForEach(-Object)? Format-Custom Format-List ' +
					'Format-Table Format-Wide Get-Acl Get-Alias Get-AuthenticodeSignature Get-ChildItem Get-Command ' +
					'Get-Content Get-Credential Get-Culture Get-Date Get-EventLog Get-ExecutionPolicy ' +
					'Get-Help Get-History Get-Host Get-Item Get-ItemProperty Get-Location Get-Member ' +
					'Get-PfxCertificate Get-Process Get-PSDrive Get-PSProvider Get-PSSnapin Get-Service ' +
					'Get-TraceSource Get-UICulture Get-Unique Get-Variable Get-WmiObject Group-Object ' +
					'Import-Alias Import-Clixml Import-Csv Invoke-Expression Invoke-History Invoke-Item ' +
					'Join-Path Measure-Command Measure-Object Move(-Item)? Move-ItemProperty New-Alias ' +
					'New-Item New-ItemProperty New-Object New-PSDrive New-Service New-TimeSpan ' +
					'New-Variable Out-Default Out-File Out-Host Out-Null Out-Printer Out-String Pop-Location ' +
					'Push-Location Read-Host Remove-Item Remove-ItemProperty Remove-PSDrive Remove-PSSnapin ' +
					'Remove-Variable Rename-Item Rename-ItemProperty Resolve-Path Restart-Service Resume-Service ' +
					'Select-Object Select-String Set-Acl Set-Alias Set-AuthenticodeSignature Set-Content ' +
					'Set-Date Set-ExecutionPolicy Set-Item Set-ItemProperty Set-Location Set-PSDebug ' +
					'Set-Service Set-TraceSource Set(-Variable)? Sort-Object Split-Path Start-Service ' +
					'Start-Sleep Start-Transcript Stop-Process Stop-Service Stop-Transcript Suspend-Service ' +
					'Tee-Object Test-Path Trace-Command Update-FormatData Update-TypeData Where(-Object)? ' +
					'Write-Debug Write-Error Write(-Host)? Write-Output Write-Progress Write-Verbose Write-Warning';
		var alias = 'ac asnp clc cli clp clv cpi cpp cvpa diff epal epcsv fc fl ' +
					'ft fw gal gc gci gcm gdr ghy gi gl gm gp gps group gsv ' +
					'gsnp gu gv gwmi iex ihy ii ipal ipcsv mi mp nal ndr ni nv oh rdr ' +
					'ri rni rnp rp rsnp rv rvpa sal sasv sc select si sl sleep sort sp ' +
					'spps spsv sv tee cat cd cp h history kill lp ls ' +
					'mount mv popd ps pushd pwd r rm rmdir echo cls chdir del dir ' +
					'erase rd ren type % \\?';

		this.regexList = [
			{ regex: /#.*$/gm,										css: 'comments' },  // one line comments
			{ regex: /\$[a-zA-Z0-9]+\b/g,							css: 'value'   },   // variables $Computer1
			{ regex: /\-[a-zA-Z]+\b/g,								css: 'keyword' },   // Operators    -not  -and  -eq
			{ regex: SyntaxHighlighter.regexLib.doubleQuotedString,	css: 'string' },    // strings
			{ regex: SyntaxHighlighter.regexLib.singleQuotedString,	css: 'string' },    // strings
			{ regex: new RegExp(this.getKeywords(keywords), 'gmi'),	css: 'keyword' },
			{ regex: new RegExp(this.getKeywords(alias), 'gmi'),	css: 'keyword' }
		];
	};

	Brush.prototype	= new SyntaxHighlighter.Highlighter();
	Brush.aliases	= ['powershell', 'ps'];

	SyntaxHighlighter.brushes.PowerShell = Brush;

	// CommonJS
	typeof(exports) != 'undefined' ? exports.Brush = Brush : null;
})();
/**
 * SyntaxHighlighter
 * http://alexgorbatchev.com/SyntaxHighlighter
 *
 * SyntaxHighlighter is donationware. If you are using it, please donate.
 * http://alexgorbatchev.com/SyntaxHighlighter/donate.html
 *
 * @version
 * 3.0.83 (July 02 2010)
 * 
 * @copyright
 * Copyright (C) 2004-2010 Alex Gorbatchev.
 *
 * @license
 * Dual licensed under the MIT and GPL licenses.
 */
;(function()
{
	// CommonJS
	typeof(require) != 'undefined' ? SyntaxHighlighter = require('shCore').SyntaxHighlighter : null;

	function Brush()
	{
		// Contributed by Gheorghe Milas and Ahmad Sherif
	
		var keywords =  'and assert break class continue def del elif else ' +
						'except exec finally for from global if import in is ' +
						'lambda not or pass print raise return try yield while';

		var funcs = '__import__ abs all any apply basestring bin bool buffer callable ' +
					'chr classmethod cmp coerce compile complex delattr dict dir ' +
					'divmod enumerate eval execfile file filter float format frozenset ' +
					'getattr globals hasattr hash help hex id input int intern ' +
					'isinstance issubclass iter len list locals long map max min next ' +
					'object oct open ord pow print property range raw_input reduce ' +
					'reload repr reversed round set setattr slice sorted staticmethod ' +
					'str sum super tuple type type unichr unicode vars xrange zip';

		var special =  'None True False self cls class_';

		this.regexList = [
				{ regex: SyntaxHighlighter.regexLib.singleLinePerlComments, css: 'comments' },
				{ regex: /^\s*@\w+/gm, 										css: 'decorator' },
				{ regex: /(['\"]{3})([^\1])*?\1/gm, 						css: 'comments' },
				{ regex: /"(?!")(?:\.|\\\"|[^\""\n])*"/gm, 					css: 'string' },
				{ regex: /'(?!')(?:\.|(\\\')|[^\''\n])*'/gm, 				css: 'string' },
				{ regex: /\+|\-|\*|\/|\%|=|==/gm, 							css: 'keyword' },
				{ regex: /\b\d+\.?\w*/g, 									css: 'value' },
				{ regex: new RegExp(this.getKeywords(funcs), 'gmi'),		css: 'functions' },
				{ regex: new RegExp(this.getKeywords(keywords), 'gm'), 		css: 'keyword' },
				{ regex: new RegExp(this.getKeywords(special), 'gm'), 		css: 'color1' }
				];
			
		this.forHtmlScript(SyntaxHighlighter.regexLib.aspScriptTags);
	};

	Brush.prototype	= new SyntaxHighlighter.Highlighter();
	Brush.aliases	= ['py', 'python'];

	SyntaxHighlighter.brushes.Python = Brush;

	// CommonJS
	typeof(exports) != 'undefined' ? exports.Brush = Brush : null;
})();
/**
 * SyntaxHighlighter
 * http://alexgorbatchev.com/SyntaxHighlighter
 *
 * SyntaxHighlighter is donationware. If you are using it, please donate.
 * http://alexgorbatchev.com/SyntaxHighlighter/donate.html
 *
 * @version
 * 3.0.83 (July 02 2010)
 * 
 * @copyright
 * Copyright (C) 2004-2010 Alex Gorbatchev.
 *
 * @license
 * Dual licensed under the MIT and GPL licenses.
 */
;(function()
{
	// CommonJS
	typeof(require) != 'undefined' ? SyntaxHighlighter = require('shCore').SyntaxHighlighter : null;

	function Brush()
	{
		// Contributed by Erik Peterson.
	
		var keywords =	'alias and BEGIN begin break case class def define_method defined do each else elsif ' +
						'END end ensure false for if in module new next nil not or raise redo rescue retry return ' +
						'self super then throw true undef unless until when while yield';

		var builtins =	'Array Bignum Binding Class Continuation Dir Exception FalseClass File::Stat File Fixnum Fload ' +
						'Hash Integer IO MatchData Method Module NilClass Numeric Object Proc Range Regexp String Struct::TMS Symbol ' +
						'ThreadGroup Thread Time TrueClass';

		this.regexList = [
			{ regex: SyntaxHighlighter.regexLib.singleLinePerlComments,	css: 'comments' },		// one line comments
			{ regex: SyntaxHighlighter.regexLib.doubleQuotedString,		css: 'string' },		// double quoted strings
			{ regex: SyntaxHighlighter.regexLib.singleQuotedString,		css: 'string' },		// single quoted strings
			{ regex: /\b[A-Z0-9_]+\b/g,									css: 'constants' },		// constants
			{ regex: /:[a-z][A-Za-z0-9_]*/g,							css: 'color2' },		// symbols
			{ regex: /(\$|@@|@)\w+/g,									css: 'variable bold' },	// $global, @instance, and @@class variables
			{ regex: new RegExp(this.getKeywords(keywords), 'gm'),		css: 'keyword' },		// keywords
			{ regex: new RegExp(this.getKeywords(builtins), 'gm'),		css: 'color1' }			// builtins
			];

		this.forHtmlScript(SyntaxHighlighter.regexLib.aspScriptTags);
	};

	Brush.prototype	= new SyntaxHighlighter.Highlighter();
	Brush.aliases	= ['ruby', 'rails', 'ror', 'rb'];

	SyntaxHighlighter.brushes.Ruby = Brush;

	// CommonJS
	typeof(exports) != 'undefined' ? exports.Brush = Brush : null;
})();
/**
 * SyntaxHighlighter
 * http://alexgorbatchev.com/SyntaxHighlighter
 *
 * SyntaxHighlighter is donationware. If you are using it, please donate.
 * http://alexgorbatchev.com/SyntaxHighlighter/donate.html
 *
 * @version
 * 3.0.83 (July 02 2010)
 * 
 * @copyright
 * Copyright (C) 2004-2010 Alex Gorbatchev.
 *
 * @license
 * Dual licensed under the MIT and GPL licenses.
 */
;(function()
{
	// CommonJS
	typeof(require) != 'undefined' ? SyntaxHighlighter = require('shCore').SyntaxHighlighter : null;

	function Brush()
	{
		function getKeywordsCSS(str)
		{
			return '\\b([a-z_]|)' + str.replace(/ /g, '(?=:)\\b|\\b([a-z_\\*]|\\*|)') + '(?=:)\\b';
		};
	
		function getValuesCSS(str)
		{
			return '\\b' + str.replace(/ /g, '(?!-)(?!:)\\b|\\b()') + '\:\\b';
		};

		var keywords =	'ascent azimuth background-attachment background-color background-image background-position ' +
						'background-repeat background baseline bbox border-collapse border-color border-spacing border-style border-top ' +
						'border-right border-bottom border-left border-top-color border-right-color border-bottom-color border-left-color ' +
						'border-top-style border-right-style border-bottom-style border-left-style border-top-width border-right-width ' +
						'border-bottom-width border-left-width border-width border bottom cap-height caption-side centerline clear clip color ' +
						'content counter-increment counter-reset cue-after cue-before cue cursor definition-src descent direction display ' +
						'elevation empty-cells float font-size-adjust font-family font-size font-stretch font-style font-variant font-weight font ' +
						'height left letter-spacing line-height list-style-image list-style-position list-style-type list-style margin-top ' +
						'margin-right margin-bottom margin-left margin marker-offset marks mathline max-height max-width min-height min-width orphans ' +
						'outline-color outline-style outline-width outline overflow padding-top padding-right padding-bottom padding-left padding page ' +
						'page-break-after page-break-before page-break-inside pause pause-after pause-before pitch pitch-range play-during position ' +
						'quotes right richness size slope src speak-header speak-numeral speak-punctuation speak speech-rate stemh stemv stress ' +
						'table-layout text-align top text-decoration text-indent text-shadow text-transform unicode-bidi unicode-range units-per-em ' +
						'vertical-align visibility voice-family volume white-space widows width widths word-spacing x-height z-index';
		
		var values =	'above absolute all always aqua armenian attr aural auto avoid baseline behind below bidi-override black blink block blue bold bolder '+
						'both bottom braille capitalize caption center center-left center-right circle close-quote code collapse compact condensed '+
						'continuous counter counters crop cross crosshair cursive dashed decimal decimal-leading-zero digits disc dotted double '+
						'embed embossed e-resize expanded extra-condensed extra-expanded fantasy far-left far-right fast faster fixed format fuchsia '+
						'gray green groove handheld hebrew help hidden hide high higher icon inline-table inline inset inside invert italic '+
						'justify landscape large larger left-side left leftwards level lighter lime line-through list-item local loud lower-alpha '+
						'lowercase lower-greek lower-latin lower-roman lower low ltr marker maroon medium message-box middle mix move narrower '+
						'navy ne-resize no-close-quote none no-open-quote no-repeat normal nowrap n-resize nw-resize oblique olive once open-quote outset '+
						'outside overline pointer portrait pre print projection purple red relative repeat repeat-x repeat-y rgb ridge right right-side '+
						'rightwards rtl run-in screen scroll semi-condensed semi-expanded separate se-resize show silent silver slower slow '+
						'small small-caps small-caption smaller soft solid speech spell-out square s-resize static status-bar sub super sw-resize '+
						'table-caption table-cell table-column table-column-group table-footer-group table-header-group table-row table-row-group teal '+
						'text-bottom text-top thick thin top transparent tty tv ultra-condensed ultra-expanded underline upper-alpha uppercase upper-latin '+
						'upper-roman url visible wait white wider w-resize x-fast x-high x-large x-loud x-low x-slow x-small x-soft xx-large xx-small yellow';
		
		var fonts =		'[mM]onospace [tT]ahoma [vV]erdana [aA]rial [hH]elvetica [sS]ans-serif [sS]erif [cC]ourier mono sans serif';
		
		var statements		= '!important !default';
		var preprocessor	= '@import @extend @debug @warn @if @for @while @mixin @include';
		
		var r = SyntaxHighlighter.regexLib;
		
		this.regexList = [
			{ regex: r.multiLineCComments,								css: 'comments' },		// multiline comments
			{ regex: r.singleLineCComments,								css: 'comments' },		// singleline comments
			{ regex: r.doubleQuotedString,								css: 'string' },		// double quoted strings
			{ regex: r.singleQuotedString,								css: 'string' },		// single quoted strings
			{ regex: /\#[a-fA-F0-9]{3,6}/g,								css: 'value' },			// html colors
			{ regex: /\b(-?\d+)(\.\d+)?(px|em|pt|\:|\%|)\b/g,			css: 'value' },			// sizes
			{ regex: /\$\w+/g,											css: 'variable' },		// variables
			{ regex: new RegExp(this.getKeywords(statements), 'g'),		css: 'color3' },		// statements
			{ regex: new RegExp(this.getKeywords(preprocessor), 'g'),	css: 'preprocessor' },	// preprocessor
			{ regex: new RegExp(getKeywordsCSS(keywords), 'gm'),		css: 'keyword' },		// keywords
			{ regex: new RegExp(getValuesCSS(values), 'g'),				css: 'value' },			// values
			{ regex: new RegExp(this.getKeywords(fonts), 'g'),			css: 'color1' }			// fonts
			];
	};

	Brush.prototype	= new SyntaxHighlighter.Highlighter();
	Brush.aliases	= ['sass', 'scss'];

	SyntaxHighlighter.brushes.Sass = Brush;

	// CommonJS
	typeof(exports) != 'undefined' ? exports.Brush = Brush : null;
})();
/**
 * SyntaxHighlighter
 * http://alexgorbatchev.com/SyntaxHighlighter
 *
 * SyntaxHighlighter is donationware. If you are using it, please donate.
 * http://alexgorbatchev.com/SyntaxHighlighter/donate.html
 *
 * @version
 * 3.0.83 (July 02 2010)
 * 
 * @copyright
 * Copyright (C) 2004-2010 Alex Gorbatchev.
 *
 * @license
 * Dual licensed under the MIT and GPL licenses.
 */
;(function()
{
	// CommonJS
	typeof(require) != 'undefined' ? SyntaxHighlighter = require('shCore').SyntaxHighlighter : null;

	function Brush()
	{
		// Contributed by Yegor Jbanov and David Bernard.
	
		var keywords =	'val sealed case def true trait implicit forSome import match object null finally super ' +
						'override try lazy for var catch throw type extends class while with new final yield abstract ' +
						'else do if return protected private this package false';

		var keyops =	'[_:=><%#@]+';

		this.regexList = [
			{ regex: SyntaxHighlighter.regexLib.singleLineCComments,			css: 'comments' },	// one line comments
			{ regex: SyntaxHighlighter.regexLib.multiLineCComments,				css: 'comments' },	// multiline comments
			{ regex: SyntaxHighlighter.regexLib.multiLineSingleQuotedString,	css: 'string' },	// multi-line strings
			{ regex: SyntaxHighlighter.regexLib.multiLineDoubleQuotedString,    css: 'string' },	// double-quoted string
			{ regex: SyntaxHighlighter.regexLib.singleQuotedString,				css: 'string' },	// strings
			{ regex: /0x[a-f0-9]+|\d+(\.\d+)?/gi,								css: 'value' },		// numbers
			{ regex: new RegExp(this.getKeywords(keywords), 'gm'),				css: 'keyword' },	// keywords
			{ regex: new RegExp(keyops, 'gm'),									css: 'keyword' }	// scala keyword
			];
	}

	Brush.prototype	= new SyntaxHighlighter.Highlighter();
	Brush.aliases	= ['scala'];

	SyntaxHighlighter.brushes.Scala = Brush;

	// CommonJS
	typeof(exports) != 'undefined' ? exports.Brush = Brush : null;
})();
/**
 * Scheme brush for SyntaxHighlighter
 *
 * @copyright
 * Copyright (C) 2010 Adam Foltzer.
 */
;(function()
{
 // CommonJS
 typeof(require) != 'undefined' ? SyntaxHighlighter = require('shCore').SyntaxHighlighter : null;
 
 function Brush()
 {
 
  var keywords = 'and begin begin0 c-declare c-lambda call-with-current-continuation ' +
                       'call-with-input-file call-with-output-file call/cc case case-lambda ' +
                       'class class* class*/names class100 class100* compound-unit/sig cond ' +
                       'cond-expand define define-macro define-module define-public ' +
                       'define-signature define-struct define-syntax define-syntax-set ' +
                       'define-values define-values/invoke-unit/sig define/contract ' +
                       'define/override define/private define/public delay do else exit-handler ' +
                       'field if import inherit inherit-field init init-field init-rest ' +
                       'instantiate interface lambda let let* let*-values let+ let-syntax ' +
                       'let-values let/ec letrec letrec-values letrec-syntax match match-lambda ' +
                       'match-lambda* match-let match-let* match-letrec match-define mixin module ' +
                       'opt-lambda or override override* namespace-variable-bind/invoke-unit/sig ' +
                       'parameterize private private* protect provide provide-signature-elements ' +
                       'provide/contract public public* quote receive rename require ' +
                       'require-for-syntax send send* set! set!-values signature-<symbols ' +
                       'super-instantiate syntax-case syntax-case* syntax-error syntax-rules ' +
                       'unit/sig unless when with-handlers with-method with-syntax';
 
  this.regexList = [
   { regex: new RegExp(';.*', 'g'),                              css: 'comments' },  // one line comments
   { regex: new RegExp('#\\|[\\s\\S]*?\\|#', 'gm'),         css: 'comments' },  // multiline comments
   { regex: new RegExp('\'[^\(\\]\\)\|\\s\)]+', 'g'),                  css: 'constants' },  // symbols
            { regex: /(\s|^)#(?!\|)[^(\]\)|\s)]+/g,                                 css: 'constants' },     // #-preceded constants
   { regex: SyntaxHighlighter.regexLib.doubleQuotedString,     css: 'string' },  // strings
   { regex: new RegExp('\\b([\\d]+(\\.[\\d]+)?|0x[a-f0-9]+)\\b', 'gi'), css: 'value' },   // numbers
   { regex: new RegExp(this.getKeywords(keywords), 'gm'),     css: 'keyword' }  // Scheme keyword
   ];
 
 }
 
 Brush.prototype = new SyntaxHighlighter.Highlighter();
 Brush.aliases = ['scheme'];
 
 SyntaxHighlighter.brushes.Scheme = Brush;
 
 // CommonJS
 typeof(exports) != 'undefined' ? exports.Brush = Brush : null;
})();

/**
 * SyntaxHighlighter
 * http://alexgorbatchev.com/SyntaxHighlighter
 *
 * SyntaxHighlighter is donationware. If you are using it, please donate.
 * http://alexgorbatchev.com/SyntaxHighlighter/donate.html
 *
 * @version
 * 3.0.83 (July 02 2010)
 * 
 * @copyright
 * Copyright (C) 2004-2010 Alex Gorbatchev.
 *
 * @license
 * Dual licensed under the MIT and GPL licenses.
 */
;(function()
{
	// CommonJS
	typeof(require) != 'undefined' ? SyntaxHighlighter = require('shCore').SyntaxHighlighter : null;

	function Brush()
	{
		var funcs	=	'abs avg case cast coalesce convert count current_timestamp ' +
						'current_user day isnull left lower month nullif replace right ' +
						'session_user space substring sum system_user upper user year';

		var keywords =	'absolute action add after alter as asc at authorization begin bigint ' +
						'binary bit by cascade char character check checkpoint close collate ' +
						'column commit committed connect connection constraint contains continue ' +
						'create cube current current_date current_time cursor database date ' +
						'deallocate dec decimal declare default delete desc distinct double drop ' +
						'dynamic else end end-exec escape except exec execute false fetch first ' +
						'float for force foreign forward free from full function global goto grant ' +
						'group grouping having hour ignore index inner insensitive insert instead ' +
						'int integer intersect into is isolation key last level load local max min ' +
						'minute modify move name national nchar next no numeric of off on only ' +
						'open option order out output partial password precision prepare primary ' +
						'prior privileges procedure public read real references relative repeatable ' +
						'restrict return returns revoke rollback rollup rows rule schema scroll ' +
						'second section select sequence serializable set size smallint static ' +
						'statistics table temp temporary then time timestamp to top transaction ' +
						'translation trigger true truncate uncommitted union unique update values ' +
						'varchar varying view when where with work';

		var operators =	'all and any between cross in join like not null or outer some';

		this.regexList = [
			{ regex: /--(.*)$/gm,												css: 'comments' },			// one line and multiline comments
			{ regex: SyntaxHighlighter.regexLib.multiLineDoubleQuotedString,	css: 'string' },			// double quoted strings
			{ regex: SyntaxHighlighter.regexLib.multiLineSingleQuotedString,	css: 'string' },			// single quoted strings
			{ regex: new RegExp(this.getKeywords(funcs), 'gmi'),				css: 'color2' },			// functions
			{ regex: new RegExp(this.getKeywords(operators), 'gmi'),			css: 'color1' },			// operators and such
			{ regex: new RegExp(this.getKeywords(keywords), 'gmi'),				css: 'keyword' }			// keyword
			];
	};

	Brush.prototype	= new SyntaxHighlighter.Highlighter();
	Brush.aliases	= ['sql'];

	SyntaxHighlighter.brushes.Sql = Brush;

	// CommonJS
	typeof(exports) != 'undefined' ? exports.Brush = Brush : null;
})();

/**
 * SyntaxHighlighter
 * http://alexgorbatchev.com/SyntaxHighlighter
 *
 * SyntaxHighlighter is donationware. If you are using it, please donate.
 * http://alexgorbatchev.com/SyntaxHighlighter/donate.html
 *
 * @version
 * 3.0.83 (July 02 2010)
 * 
 * @copyright
 * Copyright (C) 2004-2010 Alex Gorbatchev.
 *
 * @license
 * Dual licensed under the MIT and GPL licenses.
 */
;(function()
{
	// CommonJS
	typeof(require) != 'undefined' ? SyntaxHighlighter = require('shCore').SyntaxHighlighter : null;

	function Brush()
	{
		var keywords =	'AddHandler AddressOf AndAlso Alias And Ansi As Assembly Auto ' +
						'Boolean ByRef Byte ByVal Call Case Catch CBool CByte CChar CDate ' +
						'CDec CDbl Char CInt Class CLng CObj Const CShort CSng CStr CType ' +
						'Date Decimal Declare Default Delegate Dim DirectCast Do Double Each ' +
						'Else ElseIf End Enum Erase Error Event Exit False Finally For Friend ' +
						'Function Get GetType GoSub GoTo Handles If Implements Imports In ' +
						'Inherits Integer Interface Is Let Lib Like Long Loop Me Mod Module ' +
						'MustInherit MustOverride MyBase MyClass Namespace New Next Not Nothing ' +
						'NotInheritable NotOverridable Object On Option Optional Or OrElse ' +
						'Overloads Overridable Overrides ParamArray Preserve Private Property ' +
						'Protected Public RaiseEvent ReadOnly ReDim REM RemoveHandler Resume ' +
						'Return Select Set Shadows Shared Short Single Static Step Stop String ' +
						'Structure Sub SyncLock Then Throw To True Try TypeOf Unicode Until ' +
						'Variant When While With WithEvents WriteOnly Xor';

		this.regexList = [
			{ regex: /'.*$/gm,										css: 'comments' },			// one line comments
			{ regex: SyntaxHighlighter.regexLib.doubleQuotedString,	css: 'string' },			// strings
			{ regex: /^\s*#.*$/gm,									css: 'preprocessor' },		// preprocessor tags like #region and #endregion
			{ regex: new RegExp(this.getKeywords(keywords), 'gm'),	css: 'keyword' }			// vb keyword
			];

		this.forHtmlScript(SyntaxHighlighter.regexLib.aspScriptTags);
	};

	Brush.prototype	= new SyntaxHighlighter.Highlighter();
	Brush.aliases	= ['vb', 'vbnet'];

	SyntaxHighlighter.brushes.Vb = Brush;

	// CommonJS
	typeof(exports) != 'undefined' ? exports.Brush = Brush : null;
})();
/**
 * SyntaxHighlighter
 * http://alexgorbatchev.com/SyntaxHighlighter
 *
 * SyntaxHighlighter is donationware. If you are using it, please donate.
 * http://alexgorbatchev.com/SyntaxHighlighter/donate.html
 *
 * @version
 * 3.0.83 (July 02 2010)
 * 
 * @copyright
 * Copyright (C) 2004-2010 Alex Gorbatchev.
 *
 * @license
 * Dual licensed under the MIT and GPL licenses.
 */
;(function()
{
	// CommonJS
	typeof(require) != 'undefined' ? SyntaxHighlighter = require('shCore').SyntaxHighlighter : null;

	function Brush()
	{
		var keywords =	'abc abclear argdo argu argument bel belowright ' +
					'bN bNext breakd breakdel buffer caddb caddbuffer cb cbuffer ' +
					'cex cexpr cg cgetfile checkt checktime cnew cnewer col ' +
					'colder con continue cq cquit delc delcommand diffoff diffu ' +
					'diffupdate dr drop echom echomsg em emenu endt endtry ' +
					'exu exusage fin find foldc foldclose fu function ha ' +
					'hardcopy helpt helptags if is isearch ju jumps kee ' +
					'keepmarks lan language lc lcd lefta leftabove lgetb lgetbuffer ' +
					'lgrepa lgrepadd lla llast lmapc lmapclear lnf lnfile loc ' +
					'lockmarks lpf lpfile ltag mak make menut menutranslate ' +
					'mkvie mkview mzf mzfile next nu number opt options ' +
					'perld perldo pp ppop Print promptr promptrepl ptj ptjump ' +
					'ptp ptprevious pw pwd quit redi redir reg registers ' +
					'rew rewind rubyd rubydo sal sall sba sball sbn ' +
					'sbnext sb sbuffer setf setfiletype sfir sfirst sim simalt ' +
					'sm smap sn snext snor snoremap so source spellr ' +
					'spellrepall spr sprevious star startinsert stopi stopinsert sunmenu tabe ' +
					'tabedit tabm tabmove tabo tabonly ta tag tclf tclfile ' +
					'tj tjump tn tnext tr trewind tu tunmenu undol ' +
					'undolist verb verbose vim vimgrep vmapc vmapclear wh while ' +
					'win winsize wq wv wviminfo xm xmap XMLent xnoremenu ' +
					'abo aboveleft arge argedit as ascii bf bfirst bo ' +
					'botright breakl breaklist buffers cad caddexpr cc cf cfile ' +
					'change cla clast cn cnext colo colorscheme cope copen ' +
					'cr crewind delete diffpatch dig digraphs ds dsearch echon ' +
					'emenu endw endwhile file fini finish folddoc folddoclosed go ' +
					'goto help hid hide ij ijump isp isplit laddb ' +
					'laddbuffer la last lch lchdir lex lexpr lgete lgetexpr ' +
					'lh lhelpgrep lli llist lnew lnewer lNf lNfile lockv ' +
					'lockvar lp lprevious lv lvimgrep ma mark mk mkexrc ' +
					'mkv mkvimrc mz mzscheme Next omapc omapclear pc pclose ' +
					'po pop pre preserve profd profdel ps psearch ptl ' +
					'ptlast ptr ptrewind pyf pyfile quita quitall red redo ' +
					'res resize ri right rubyf rubyfile san sandbox sbf ' +
					'sbfirst sbN sbNext scripte scriptencoding setg setglobal sh shell ' +
					'sla slast smapc smapclear sN sNext snoreme spelld spelldump ' +
					'spellu spellundo sre srewind startr startreplace sts stselect sus ' +
					'suspend tab tabf tabfind tabnew tabp tabprevious tags te ' +
					'tearoff tl tlast tN tNext try una unabbreviate unh ' +
					'unhide ve version vimgrepa vimgrepadd vne vnew winc wincmd ' +
					'wn wnext wqa wqall xmapc xmapclear XMLns xunme al ' +
					'all argg argglobal bad badd bl blast bp bprevious ' +
					'br brewind bun bunload caddf caddfile ccl cclose cfir ' +
					'cfirst changes cl clist cN cNext comc comclear co ' +
					'copy cuna cunabbrev delf delfunction diffpu diffput di display ' +
					'dsp dsplit edit endfo endfor ene enew files fir ' +
					'first foldd folddoopen gr grep helpf helpfind his history ' +
					'il ilist iuna iunabbrev keepalt lad laddexpr later lcl ' +
					'lclose lf lfile lg lgetfile list lmak lmake lne ' +
					'lnext ln lnoremap lol lolder lr lrewind lvimgrepa lvimgrepadd ' +
					'marks mks mksession mod mode nbkey nmapc nmapclear on ' +
					'only ped pedit popu prev previous prof profile pta ' +
					'ptag ptn ptnext pts ptselect py python read redr ' +
					'redraw ret retab rightb rightbelow ru runtime sa sargument ' +
					'sbl sblast sbp sbprevious scrip scriptnames setl setlocal sign ' +
					'sl sleep sme sni sniff snoremenu spe spellgood spellw ' +
					'spellwrong sta stag stj stjump sun sunhide sv sview ' +
					'tabc tabclose tabfir tabfirst tabn tabnext tabr tabrewind tc ' +
					'tcl tf tfirst tm to topleft ts tselect undo ' +
					'unlo unlockvar vert vertical vi visual vs vsplit windo ' +
					'wN wNext write xa xall xme xn xnoremap xunmenu ' +
					'arga argadd argl arglocal ba ball bm bmodified brea ' +
					'break bro browse bw bwipeout cal call cd cgetb ' +
					'cgetbuffer chd chdir clo close cnf cnfile comp compiler ' +
					'cpf cpfile cw cwindow delm delmarks diffsplit dj djump ' +
					'earlier el else endf endfunction ex filetype fix fixdel ' +
					'foldo foldopen grepa grepadd helpg helpgrep iabc iabclear imapc ' +
					'imapclear join keepj keepjumps laddf laddfile lb lbuffer le ' +
					'left lfir lfirst lgr lgrep ll lm lmap lN ' +
					'lNext lo loadview lop lopen ls lw lwindow mat ' +
					'match maca macaction macm macmenu mksp mkspell move new ' +
					'noh nohlsearch open pe perl popu popup print promptf ' +
					'promptfind ptf ptfirst ptN ptNext pu put qa qall ' +
					'rec recover redraws redrawstatus retu return rub ruby rv ' +
					'rviminfo sav saveas sbm sbmodified sbr sbrewind se set ' +
					'sf sfind sil silent sm smagic smenu sno snomagic ' +
					'sor sort spelli spellinfo sp split startg startgreplace st ' +
					'stop sunme syncbind tabd tabdo tabl tablast tabN tabNext ' +
					'tabs tcld tcldo th throw tm tmenu tp tprevious ' +
					'tu undoj undojoin up update vie view viu viusage ' +
					'wa wall winp winpos wp wprevious ws wsverb xit ' +
					'xmenu xnoreme yank argd argdelete ar args bd bdelete ' +
					'bn bnext breaka breakadd bufdo cabc cabclear cat catch ' +
					'ce center cgete cgetexpr che checkpath cmapc cmapclear cNf ' +
					'cNfile conf confirm cp cprevious debugg debuggreedy diffg diffget ' +
					'diffthis dl dlist echoe echoerr elsei elseif en endif ' +
					'exi exit fina finally fo fold for ' +
					'echohl';

		var options = 'acd ambiwidth arabicshape autowriteall backupdir bdlay binary ' +
					'breakat bufhidden cdpath cin cinwords columns completeopt cpo cscopetagorder ' +
					'csverb deco dictionary directory ed encoding errorfile exrc fdls ' +
					'fencs fileformats fmr foldlevel foldtext fsync gfs gtl guioptions ' +
					'hf hk hlsearch imak ims indentexpr is isp keywordprg ' +
					'lazyredraw lispwords ls makeef maxmapdepth mfd mmd modified mousemodel ' +
					'msm numberwidth operatorfunc pastetoggle pexpr pmbfn printexpr pt readonly ' +
					'rightleft rtp sb scroll sect sessionoptions shellpipe shellxquote showbreak ' +
					'shq slm smd spc spf sr sta sts swapfile ' +
					'sxq tabpagemax tags tbis terse thesaurus titleold toolbariconsize tsr ' +
					'ttyfast tx ut verbosefile virtualedit wb wfw wildcharm winaltkeys ' +
					'winminwidth wmnu write ai ambw ari aw backupext beval ' +
					'biosk brk buflisted cedit cindent clipboard com confirm cpoptions ' +
					'cscopeverbose cuc def diff display edcompatible endofline errorformat fcl ' +
					'fdm fex filetype fo foldlevelstart formatexpr ft gfw gtt ' +
					'guipty hh hkmap ic imc imsearch indentkeys isf isprint ' +
					'km lbr list lsp makeprg maxmem mh mmp more ' +
					'mouses mzq nuw opfunc patchexpr pfn popt printfont pumheight ' +
					'redrawtime rightleftcmd ru sbo scrollbind sections sft shellquote shiftround ' +
					'showcmd si sm sn spell spl srr stal su ' +
					'swapsync syn tabstop tagstack tbs textauto tildeop titlestring top ' +
					'ttimeout ttym uc vb vfile visualbell wc wh wildignore ' +
					'window winwidth wmw writeany akm anti arshape awa backupskip ' +
					'bex bioskey browsedir buftype cf cink cmdheight comments consk ' +
					'cpt cspc cul define diffexpr dy ef eol esckeys ' +
					'fcs fdn ff fillchars foldclose foldmarker formatlistpat gcr ghr ' +
					'guicursor guitablabel hi hkmapp icon imcmdline inc indk isfname ' +
					'joinspaces kmp lcs listchars lw mat maxmempattern mis mmt ' +
					'mouse mouseshape mzquantum odev osfiletype patchmode ph preserveindent printheader ' +
					'pvh remap rl ruf sbr scrolljump secure sh shellredir ' +
					'shiftwidth showfulltag sidescroll smartcase so spellcapcheck splitbelow ss startofline ' +
					'sua swb synmaxcol tag tal tenc textmode timeout tl ' +
					'tpm ttimeoutlen ttymouse ul vbs vi vop wcm whichwrap ' +
					'wildmenu winfixheight wiv wop writebackup al antialias autochdir background ' +
					'balloondelay bexpr bk bs casemap cfu cinkeys cmdwinheight commentstring ' +
					'conskey cscopepathcomp csprg cursorcolumn delcombine diffopt ea efm ep ' +
					'et fdc fdo ffs fk foldcolumn foldmethod formatoptions gd ' +
					'go guifont guitabtooltip hid hkp iconstring imd include inex ' +
					'isi js kp linebreak lm lz matchpairs maxmemtot mkspellmem ' +
					'mod mousef mouset nf oft pa path pheader previewheight ' +
					'printmbcharset pvw report rlc ruler sc scrolloff sel shcf ' +
					'shellslash shm showmatch sidescrolloff smartindent softtabstop spellfile splitright ssl ' +
					'statusline suffixes swf syntax tagbsearch tb term textwidth timeoutlen ' +
					'tm tr ttm ttyscroll undolevels vdir viewdir wa wd ' +
					'wi wildmode winfixwidth wiw wrap writedelay aleph ar autoindent ' +
					'backspace ballooneval bg bkc bsdir cb ch cino cmp ' +
					'compatible copyindent cscopeprg csqf cursorline dex digraph ead ei ' +
					'equalalways eventignore fde fdt fileencoding fkmap foldenable foldminlines formatprg ' +
					'gdefault gp guifontset helpfile hidden hl ignorecase imdisable includeexpr ' +
					'inf isident key langmap lines lmap ma matchtime mco ' +
					'ml modeline mousefocus mousetime nrformats ofu para pdev pi ' +
					'previewwindow printmbfont qe restorescreen ro rulerformat scb scrollopt selection ' +
					'shell shelltemp shortmess showmode siso smarttab sol spelllang spr ' +
					'ssop stl suffixesadd switchbuf ta taglength tbi termbidi tf ' +
					'title to ts tty ttytype updatecount ve viewoptions wak ' +
					'weirdinvert wig wildoptions winheight wm wrapmargin ws allowrevins arab ' +
					'autoread backup balloonexpr bh bl bsk ccv charconvert cinoptions ' +
					'cms complete cot cscopequickfix cst cwh dg dip eadirection ' +
					'ek equalprg ex fdi fen fileencodings flp foldexpr foldnestmax ' +
					'fp gfm grepformat guifontwide helpheight highlight hlg im imi ' +
					'incsearch infercase isk keymap langmenu linespace loadplugins macatsui maxcombine ' +
					'mef mls modelines mousehide mp nu omnifunc paragraphs penc ' +
					'pm printdevice printoptions quoteescape revins rs runtimepath scr scs ' +
					'selectmode shellcmdflag shelltype shortname showtabline sj smc sp spellsuggest ' +
					'sps st stmp sw sws tabline tagrelative tbidi termencoding ' +
					'tgst titlelen toolbar tsl ttybuiltin tw updatetime verbose viminfo ' +
					'warn wfh wildchar wim winminheight wmh wrapscan ww altkeymap ' +
					'arabic autowrite backupcopy bdir bin bomb bt cd ci ' +
					'cinw co completefunc cp cscopetag csto debug dict dir ' +
					'eb enc errorbells expandtab noexpandtab fdl fenc fileformat fml foldignore ' +
					'foldopen fs gfn grepprg guiheadroom helplang history hls imactivatekey ' +
					'iminsert inde insertmode iskeyword keymodel laststatus lisp lpl magic ' +
					'maxfuncdepth menuitems mm modifiable mousem mps number opendevice paste ' +
					'pex pmbcs printencoding prompt rdt ri';

		var vimUserAttrbCmplt =	'augroup buffer command dir environment event expression ' +
					'file function help highlight mapping menu option something tag ' +
					'tag_listfiles var';

		var vimLet =	'let unl unlet ';

		var vimAutoCmd =	'au autocmd do doautocmd doautoa doautoall';
	
		var vimMap =	'map cm cmap cno cnoremap im imap ino ' +
					'inoremap ln lnoremap nm nmap nn nnoremap no noremap ' +
					'om omap ono onoremap snor snoremap vm vmap vn vnoremap xn xnoremap';
	
		var builtins =	'BufRead ModeMsg None BufAdd BufCreate BufDelete ' +
					'BufEnter BufFilePost BufFilePre BufHidden BufLeave BufNew ' +
					'BufNewFile BufRead BufReadCmd BufReadPost BufReadPre ' +
					'BufUnload BufWinEnter BufWinLeave BufWipeout BufWrite ' +
					'BufWriteCmd BufWritePost BufWritePre Cmd-event CmdwinEnter ' +
					'CmdwinLeave ColorScheme CursorHold CursorHoldI CursorMoved ' +
					'CursorMovedI EncodingChanged FileAppendCmd FileAppendPost ' +
					'FileAppendPre FileChangedRO FileChangedShell FileChangedShellPost ' +
					'FileEncoding FileReadCmd FileReadPost FileReadPre FileType ' +
					'FileWriteCmd FileWritePost FileWritePre FilterReadPost ' +
					'FilterReadPre FilterWritePost FilterWritePre FocusGained ' +
					'FocusLost FuncUndefined GUIEnter GUIFailed InsertChange ' +
					'InsertEnter InsertLeave MenuPopup QuickFixCmdPost QuickFixCmdPre ' +
					'RemoteReply SessionLoadPost ShellCmdPost ShellFilterPost SourceCmd ' +
					'SourcePre SpellFileMissing StdinReadPost StdinReadPre SwapExists ' +
					'Syntax TabEnter TabLeave TermChanged TermResponse User ' +
					'UserGettingBored VimEnter VimLeave VimLeavePre VimResized WinEnter WinLeave ';


		var r = SyntaxHighlighter.regexLib;

		r.singleLineVimscriptComments = /^\s*".*$/gm
		r.keyMappings = /(\<|&lt;)\w[-\w\[\]]+(\>|&gt;)/ig	
		
		this.regexList = [
		{ regex: r.singleLineVimscriptComments,	css: 'comments' },						// one line comments
		{ regex: r.keyMappings,	css: 'color3' },								// Vimscript key mappings (e.g. <CR> <C-S-[>)
		{ regex: r.doubleQuotedString,		css: 'string' },						// double quoted strings
		{ regex: r.singleQuotedString,		css: 'string' },						// single quoted strings
		{ regex: new RegExp(this.getKeywords(options), 'gm'),		css: 'keyword' },			// options
		{ regex: new RegExp(this.getKeywords(vimMap), 'gm'),		css: 'keyword' },			// options
		{ regex: new RegExp(this.getKeywords(vimUserAttrbCmplt), 'gm'),	css:  'keyword' },														// options
		{ regex: new RegExp(this.getKeywords(vimAutoCmd), 'gm'),	css: 'keyword' },			// options
		{ regex: new RegExp(this.getKeywords(keywords), 'gm'),		css: 'keyword' },			// keywords
		{ regex: new RegExp(this.getKeywords(vimLet), 'gm'),		css: 'keyword' },			// keywords
		{ regex: new RegExp(this.getKeywords(builtins), 'gm'),		css: 'color1' }				// keywords
		];
	
		this.forHtmlScript(r.scriptScriptTags);
	};

	Brush.prototype	= new SyntaxHighlighter.Highlighter();
	Brush.aliases	= ['vim', 'vimscript'];

	SyntaxHighlighter.brushes.Vimscript = Brush;

	// CommonJS
	typeof(exports) != 'undefined' ? exports.Brush = Brush : null;
})();
/**
 * SyntaxHighlighter
 * http://alexgorbatchev.com/SyntaxHighlighter
 *
 * SyntaxHighlighter is donationware. If you are using it, please donate.
 * http://alexgorbatchev.com/SyntaxHighlighter/donate.html
 *
 * @version
 * 3.0.83 (July 02 2010)
 * 
 * @copyright
 * Copyright (C) 2004-2010 Alex Gorbatchev.
 *
 * @license
 * Dual licensed under the MIT and GPL licenses.
 */
;(function()
{
	// CommonJS
	typeof(require) != 'undefined' ? SyntaxHighlighter = require('shCore').SyntaxHighlighter : null;

	function Brush()
	{
		function process(match, regexInfo)
		{
			var constructor = SyntaxHighlighter.Match,
				code = match[0],
				tag = new XRegExp('(&lt;|<)[\\s\\/\\?]*(?<name>[:\\w-\\.]+)', 'xg').exec(code),
				result = []
				;
		
			if (match.attributes != null) 
			{
				var attributes,
					regex = new XRegExp('(?<name> [\\w:\\-\\.]+)' +
										'\\s*=\\s*' +
										'(?<value> ".*?"|\'.*?\'|\\w+)',
										'xg');

				while ((attributes = regex.exec(code)) != null) 
				{
					result.push(new constructor(attributes.name, match.index + attributes.index, 'color1'));
					result.push(new constructor(attributes.value, match.index + attributes.index + attributes[0].indexOf(attributes.value), 'string'));
				}
			}

			if (tag != null)
				result.push(
					new constructor(tag.name, match.index + tag[0].indexOf(tag.name), 'keyword')
				);

			return result;
		}
	
		this.regexList = [
			{ regex: new XRegExp('(\\&lt;|<)\\!\\[[\\w\\s]*?\\[(.|\\s)*?\\]\\](\\&gt;|>)', 'gm'),			css: 'color2' },	// <![ ... [ ... ]]>
			{ regex: SyntaxHighlighter.regexLib.xmlComments,												css: 'comments' },	// <!-- ... -->
			{ regex: new XRegExp('(&lt;|<)[\\s\\/\\?]*(\\w+)(?<attributes>.*?)[\\s\\/\\?]*(&gt;|>)', 'sg'), func: process }
		];
	};

	Brush.prototype	= new SyntaxHighlighter.Highlighter();
	Brush.aliases	= ['xml', 'xhtml', 'xslt', 'html'];

	SyntaxHighlighter.brushes.Xml = Brush;

	// CommonJS
	typeof(exports) != 'undefined' ? exports.Brush = Brush : null;
})();
/**
 * SyntaxHighlighter
 * http://alexgorbatchev.com/
 *
 * SyntaxHighlighter is donationware. If you are using it, please donate.
 * http://alexgorbatchev.com/wiki/SyntaxHighlighter:Donate
 *
 * @version
 * 2.0.320 (July 26 2009)
 * 
 * @copyright
 * Copyright (C) 2004-2009 Alex Gorbatchev.
 * Copyright (C) 2009 Nicolas Perriault
 *
 * @license
 * This file is part of SyntaxHighlighter.
 * 
 * SyntaxHighlighter is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * SyntaxHighlighter is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with SyntaxHighlighter.  If not, see <http://www.gnu.org/copyleft/lesser.html>.
 */
SyntaxHighlighter.brushes.Yaml = function()
{
	// Contributed by Nicolas Perriault
	
	var constants	= '~ true false on off';

    this.regexList = [
        { regex: SyntaxHighlighter.regexLib.singleLinePerlComments, css: 'comments' },		// comment
		{ regex: SyntaxHighlighter.regexLib.doubleQuotedString,		css: 'string' },		// double quoted string
		{ regex: SyntaxHighlighter.regexLib.singleQuotedString,		css: 'string' },		// single quoted string
        { regex: /^\s*([a-z0-9\._-])+\s*:/gmi,						css: 'variable' },		// key
		{ regex: /\s?(\.)([a-z0-9\._-])+\s?:/gmi,					css: 'comments' },		// section
		{ regex: /\s(@|:)([a-z0-9\._-])+\s*$/gmi,					css: 'variable bold' },	// variable, reference
		{ regex: /\s+\d+\s?$/gm,									css: 'color2 bold' },	// integers
		{ regex: /(\{|\}|\[|\]|,|~|:)/gm,							css: 'constants' },		// inline hash and array, comma, null
		{ regex: /^\s+(-)+/gm,										css: 'string bold' },	// array list entry
		{ regex: /^---/gm,											css: 'string bold' },	// category
		{ regex: new RegExp(this.getKeywords(constants), 'gmi'),	css: 'constants' }		// constants
        ];
};

SyntaxHighlighter.brushes.Yaml.prototype  = new SyntaxHighlighter.Highlighter();
SyntaxHighlighter.brushes.Yaml.aliases    = ['yaml', 'yml'];
/*
 * Name: SyntaxHighlighter.brushes.Verilog 
 * Author: Yuphone Chang
 * Email: yuphone@qq.com/
 * Create Date: 5.18, 2010
 */

SyntaxHighlighter.brushes.Verilog = function()
{
  var datatypes = 'reg integar unsigned ' +
                  'wire tri wand triand tri0 tri1 supply0 supply1 trireg ' +
                  'parameter specparam defparam event ';

  var primitives = 'and nand or nor xor xnor ' +
                   'buf not ' +
                   'bufif0 bufif1 notif0 notif1 '
                   'pullup pulldown ' +
                   'pmos rpmos nmos rnmos ';

  var keywords  = 'module endmodule ' +
                  'input output inout ' +
                  'begin end ' +
                  'assign deassign always initial genvar ' +
                  'forever repeat disable wait ' +
                  'function endfunction' +
                  'task ' +
                  'endtask ' +
                  'generate endgenerate ' +
                  'specify endspecify ' +
                  'posedge negedge ' +
                  'if else for while ' +
                  'case casex casez endcase default ' +
                  'include timescale ' +
                  'ifdef endif ' +
                  'celldefine endcelldefine ' +
                  'attribute '
                  'fork join ';
                  
  var functions = 'display displayb displayo displayh ' +
                  'write writeb writeo writeh ' +
                  'strobe strobeb strobeh strobeo ' +
                  'monitor monitorb monitoro monitorh ' +
                  'fopen fclose ' +
                  'readmemb readmemh ' +
                  'finish stop ' +
                  'time stime realtime timeformat ' +
                  'printtimescale ' +
                  'setup hold setuphold skew recovery period width ';

  this.regexList = [
    // one line comments
    { regex: SyntaxHighlighter.regexLib.singleLineCComments,css: 'comments' },
    // multiline comments
    { regex: SyntaxHighlighter.regexLib.multiLineCComments, css: 'comments' },
    // double quoted strings
    { regex: SyntaxHighlighter.regexLib.doubleQuotedString, css: 'string' },
    // single quoted strings
    { regex: SyntaxHighlighter.regexLib.singleQuotedString, css: 'string' },
    // constants
    { regex: new RegExp("[0-9]+['][bBoOdDhHeEfFtT][0-9a-fA-FzZxX_]+", 'g'), css: 'constants' },
    // datatypes
    { regex: new RegExp(this.getKeywords(datatypes), 'gm'), css: 'color1 bold' },
    // primitives 
    { regex: new RegExp(this.getKeywords(primitives), 'gm'), css: 'color2 bold' },
    // keywords
    { regex: new RegExp(this.getKeywords(keywords), 'gm'), css: 'keyword bold' },
    // functions
    { regex: new RegExp(this.getKeywords(functions), 'gm'), css: 'functions bold' }
    ];
};

SyntaxHighlighter.brushes.Verilog.prototype = new SyntaxHighlighter.Highlighter();
SyntaxHighlighter.brushes.Verilog.aliases = ['verilog', 'v'];