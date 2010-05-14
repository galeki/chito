// WTFPL licensed
SyntaxHighlighter.brushes.Erlang = function() {
    var keywords = 'after begin case catch cond end fun if let of query receive when '+
        'define record export import include include_lib ifdef ifndef else endif undef '+
        'apply attribute call do in letrec module primop try';
  
    this.values = new Object();
    this.values.regex = new RegExp('[^\\w"\'](_?[A-Z]\\w*)', 'g');
    this.values.exec = function(value) { m = this.regex.exec(value);  if (m && m.length) {m[0] = m[0].substring(1, m[0].length); ++m.index;} return m;}

    this.regexList = [
       { regex: new RegExp('%.*$', 'gm'),    css: 'comments' },   // one line comments  
       { regex: SyntaxHighlighter.regexLib.doubleQuotedString,     css: 'string' },   // strings  
       { regex: SyntaxHighlighter.regexLib.singleQuotedString,     css: 'plain' },   // strings  
       { regex: new RegExp(this.getKeywords(keywords), 'gm'),  css: 'keyword' },  // Erlang keyword  
       { regex: new RegExp('\\?\\w*', 'gm'), css: 'erlmacros'},    
       { regex: this.values, css: 'erlvalues'},  
       { regex: new RegExp('\\w+/\\d+', 'gm'), css: 'functions'}
      ];
}

SyntaxHighlighter.brushes.Erlang.prototype = new SyntaxHighlighter.Highlighter();
SyntaxHighlighter.brushes.Erlang.aliases = ['erlang', 'erl'];