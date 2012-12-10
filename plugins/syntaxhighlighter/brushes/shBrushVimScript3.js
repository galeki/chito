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
