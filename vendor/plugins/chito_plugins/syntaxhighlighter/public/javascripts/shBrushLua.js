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
*/