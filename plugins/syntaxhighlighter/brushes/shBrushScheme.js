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

