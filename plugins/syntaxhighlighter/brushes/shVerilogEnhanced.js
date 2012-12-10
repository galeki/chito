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