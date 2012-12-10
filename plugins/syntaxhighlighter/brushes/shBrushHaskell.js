/*

Copyright (C) 2011 by ArieShout

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

*/

SyntaxHighlighter.brushes.Haskell = function() {
    var keywords = 'module import as qualified hiding ' +
                   'infix infixl infixr ' +
                   'class data deriving instance default where ' +
                   'type newtype ' +
                   'do return case of let in ' +
                   'if then else ' +
                   'foreign family '
    var types = 'Bool Maybe Either Ordering ' +
                'Char String Int Integer Float Double Rational IO ' +
                'ReadS ShowS ' +
                'FilePath IOError ' +
                'Eq Ord Enum Bounded Num Read Integral Fractional Floating RealFrac RealFloat Monad Functor ' +
                'Show Read';
    var values = 'True False Nothing Just Left Right LT GT EQ';
    var funcs = 'compare max min ' +
                'succ pred toEnum fromEnum enumFrom enumFromThen enumFromTo enumFromThenTo ' +
                'minBound maxBound ' +
                'negate abs signum fromInteger ' +
                'toRational ' +
                'quot rem div mod quotRem divMod toInteger ' +
                'recip fromRational ' +
                'pi exp log sqrt logBase sin cos tan asin acos atan sinh cosh tanh asinh acosh atanh ' +
                'properFraction truncate round ceiling floor ' +
                'floatRadix floatDigits floatRange decodeFloat encodeFloat ' +
                'exponent significand scaleFloat isNaN isInfinite isDenormalized isIEEE isNegativeZero atan2 ' +
                'return fail ' +
                'fmap ' +
                'mapM mapM_ sequence sequence_ ' +
                'maybe either ' +
                'not otherwise ' +
                'subtract even odd gcd lcm ' +
                'fromIntegral realToFrac ' +
                'fst snd curry uncurry id const flip until ' +
                'asTypeOf error undefined ' +
                'seq ' +
                'map filter concat concatMap ' +
                'head last tail init null length ' +
                'foldl foldl1 scanl scanl1 foldr foldr1 scanr scanr1 ' +
                'iterate repeat replicate cycle ' +
                'take drop splitAt takeWhile dropWhile span break ' +
                'lines words unlines unwords reverse and or ' +
                'any all elem notElem lookup ' +
                'sum product maximum minimum ' +
                'zip zip3 zipWith zipWith3 unzip unzip3 ' +
                'readsPrec readList ' +
                'showsPrec show showList ' +
                'reads shows read lex ' +
                'showChar showString readParen showParen ' +
                'ioError userError catch ' +
                'putChar putStr putStrLn print ' +
                'getChar getLine getContents interact ' +
                'readFile writeFile appendFile readIO readLn';
    // plain comments string keyword preprocessor variable value functions constants script color1(a) color2 color3
    this.regexList = [
        { regex: SyntaxHighlighter.regexLib.doubleQuotedString, css: 'string' },
        { regex: SyntaxHighlighter.regexLib.singleQuotedString, css: 'string' },
        { regex: /^ *--.*/gm, css: 'comments' },
        { regex: /\{-#[\s\S]*?#-\}/gm, css: 'preprocessor' },
        { regex: /\{-[\s\S]*?-\}/gm, css: 'comments' },
        { regex: new RegExp(this.getKeywords(keywords), 'gm'), css: 'keyword bold' },
        { regex: new RegExp(this.getKeywords(values), 'gm'), css: 'value bold' },
        { regex: new RegExp(this.getKeywords(types), 'gm'), css: 'color1 bold' },
        { regex: new RegExp(this.getKeywords(funcs), 'gm'), css: 'functions' },
        { regex: /\b[0-9]+|0[xX][0-9a-fA-F]+|0[oO][0-7]+\b/gm, css: 'value' },     // number
        { regex: /\b[0-9]+\.[0-9]+(?:[eE][-+]?[0-9]+)?\b/gm, css: 'value' },       // float
    ];
}

SyntaxHighlighter.brushes.Haskell.prototype = new SyntaxHighlighter.Highlighter();
SyntaxHighlighter.brushes.Haskell.aliases  = ['hs', 'hask', 'haskell'];
