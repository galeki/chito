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

