" .gvimrc
" See: http://vimdoc.sourceforge.net/htmldoc/options.html for details

" =============================================================================
" Plugins
" =============================================================================
"
" Load plugins
silent! if plug#begin('~/.vim/plugged')

" vim-plug - https://github.com/junegunn/vim-plug
" Reload .vimrc and call :PlugInstall to install plugins

" lean & mean status/tabline for vim that's light as air
Plug 'bling/vim-airline'

" Adds additional syntax highlighting and fixes for Ansible's dialect of YAML
Plug 'chase/vim-ansible-yaml'

" Fuzzy file, buffer, mru, tag, etc finder
Plug 'ctrlpvim/ctrlp.vim'

" A collection of vimscripts for Haskell development
Plug 'dag/vim2hs'

" A completion plugin for Haskell, using ghc-mod
Plug 'eagletmt/neco-ghc'

" Happy Haskell programming on Vim, powered by ghc-mod
Plug 'eagletmt/ghcmod-vim'

" Go development plugin for Vim
Plug 'fatih/vim-go', {'for': 'go'}

" one colorscheme pack to rule them all!
Plug 'flazz/vim-colorschemes'

" A Vim alignment plugin
Plug 'junegunn/vim-easy-align', {'on': ['<Plug>(EasyAlign)', 'EasyAlign']}

" Low-contrast Vim color scheme based on Seoul Colors
Plug 'junegunn/seoul256.vim'

" Text object for indented blocks of lines
"Plug 'kana/vim-textobj-indent'

" Vim python-mode.  PyLint, Rope, Pydoc, breakpoints from box
Plug 'klen/python-mode', {'for': 'python'}

" Show a diff via Vim sign column
Plug 'mhinz/vim-signify'

" A Vim plugin for visually displaying indent levels in code
Plug 'nathanaelkane/vim-indent-guides'
autocmd! User vim-indent-guides call indent_guides#enable()

" Vastly improved Javascript indentation and syntax support in Vim
Plug 'pangloss/vim-javascript', {'for': 'javascript'}

" A collection of vim syntax files for working in the shakespeare templating
" languages used by Yesod
Plug 'pbrisbin/vim-syntax-shakespeare'

" A tree explorer plugin for vim
Plug 'scrooloose/nerdtree'

" A tree explorer plugin for vim
Plug 'scrooloose/syntastic'

" True Sublime Text style multiple selections for Vim
Plug 'terryma/vim-multiple-cursors'

" Helpers for UNIX
Plug 'tpope/vim-eunuch'

" A Git wrapper so awesome, it should be illegal
Plug 'tpope/vim-fugitive'

" Enable repeating supporting plugin maps with "."
" example: silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)
Plug 'tpope/vim-repeat'

" Defaults everyone can agree on
Plug 'tpope/vim-sensible'

" Quoting/parenthesizing made simple
Plug 'tpope/vim-surround'

" Pairs of handy bracket mappings
Plug 'tpope/vim-unimpaired'

" Combine with netrw to create a delicious salad dressing
Plug 'tpope/vim-vinegar'

" surround.vim: quoting/parenthesizing made simple
Plug 'tpope/vim-surround'

" kickstart.vim provides syntax highligting for RedHat Linux kickstart files
Plug 'tangledhelix/vim-kickstart'

Plug 'Valloric/YouCompleteMe', {'do': '.install.sh'}
autocmd! User YouCompleteMe call youcompleteme#Enable()

" Create aliases for Vim commands
Plug 'vim-scripts/cmdalias.vim'

" C/C++ IDE
Plug 'vim-scripts/c.vim'

" jQuery IDE
Plug 'vim-scripts/jQuery'

Plug 'vim-scripts/LaTeX-Box'

" Perform an interactive diff on two blocks of text
Plug 'vim-scripts/linediff.vim'

" Perl IDE
Plug 'vim-scripts/perl-support.vim'

" Edit files using sudo or su or any other tool
" No longer needed, since it's also in eunuch.vim
"Plug 'vim-scripts/SudoEdit.vim'

" Script to save the current file and convert it to PDF using txt2pdf
Plug 'vim-scripts/txt2pdf.vim'

" A completion function for unicode glyphs
Plug 'vim-scripts/unicode.vim'

" Vim filetype detection by the she-bang line at file
Plug 'vitalk/vim-shebang'

" Miscellaneous auto-load Vim scripts
Plug 'xolox/vim-misc'

" Easy note taking in Vim
Plug 'xolox/vim-notes'

" End vim-plug block
call plug#end()
endif "/silent

" Use .vimrc.custom if available {
    if filereadable(expand("~/.vimrc.custom"))
        source ~/.vimrc.custom
    endif
" }
"
" For multi-byte character support (CJK support, for example):
"set fileencodings=ucs-bom,utf-8,cp936,big5,euc-jp,euc-kr,gb18030,latin1
"
" For UTF-8 support
if has("multi_byte")
    if &termencoding == ""
        let &termencoding = &encoding
    endif
    set encoding=utf-8
    setglobal fileencoding=utf-8
    "setglobal bomb
    set fileencodings=ucs-bom,utf-8,latin1
endif

" Meant to deal with errors related to Xterm's key configuration
set t_kb= t_kD=[3~

" =============================================================================
" General settings
" =============================================================================

" Meant to deal with errors related to strong Vi compatibility
" TODO Unnecessary with tpope/vim-sensible?
"set nocompatible

" Allows using the same window for multiple files, and switching from and
" unsaved buffer without having to save it first. Also allows keeping an 'undo'
" history for multiple files when reusing the same window in this way.
set hidden

" =============================================================================
" Indentation settings
" =============================================================================

" Copy indent from current line when starting a new line (typing <CR> in Insert
" mode or when using the "o" or "O" command).
set autoindent

" Number of spaces to use for each step of (auto)indent.
set shiftwidth=4

" Number of spaces that a <Tab> in the file counts for.
set tabstop=4

" Use the appropriate number of spaces to insert a <Tab>. Spaces are used in
" indents with the '>' and '<' commands and when 'autoindent' is on. To insert
" a real tab when 'expandtab' is on, use CTRL-V <Tab>.
set expandtab

" When on, a <Tab> in front of a line inserts blanks according to 'shiftwidth'.
" 'tabstop' is used in other places. A <BS> will delete a 'shiftwidth' worth of
" space at the start of the line.
set smarttab

" =============================================================================
" Splits
" =============================================================================

" New vsplit starts below
set splitbelow

" New split starts below
set splitright

" =============================================================================
" Search settings
" =============================================================================

" While typing a search command, show immediately where the so far typed
" pattern matches.
set incsearch

" Highlight search matches
set hlsearch

" Ignore case in search patterns.
set ignorecase

" Override the 'ignorecase' option if the search pattern contains upper case
" characters.
set smartcase

" Maximum width of text that is being inserted. A longer line will be broken
" after white space to get this width.
set textwidth=79

" Colorize the column just after 'textwidth'
set colorcolumn=+1

" =============================================================================
" Visual settings
" =============================================================================

" Show the current line
"set cursorline

" Show partial commands in the last line of the screen.
set showcmd

" Show line numbers.
set number

" Set the number of characters the line numbers column displays
set nuw=4

" When a bracket is inserted, briefly jump to the matching one. The jump is
" only done if the match can be seen on the screen. The time to show the match
" can be set with 'matchtime'.
set showmatch

" Always the tab bar
"set showtabline=2

" Show the line and column number of the cursor position, separated by a comma.
set ruler

" When set to "dark", Vim will try to use colors that look good on a dark
" background. When set to "light", Vim will try to use colors that look good on
" a light background. Any other value is illegal.
set background=dark

" Always show status line, even if there's only one window
set laststatus=2

" Use visual bell instead of beeping when error occurs
set visualbell

" Set the command height window to 2 lines
set cmdheight=2

" Limit all lines to 79 characters
set tw=79

" Wraps text as close as possible to 79 characters without splitting words
set formatoptions+=t

" Don't automatically fold
set foldmethod=manual

" Stop it with the automatic folding
set foldlevelstart=20

" Don't show the current mode because airline.vim does this already
"set noshowmode

" This is a sequence of letters which describes how automatic formatting is to
" be done.
"
" letter    meaning when present in 'formatoptions'
" ------    ---------------------------------------
" c         Auto-wrap comments using textwidth, inserting the current comment
"           leader automatically.
" q         Allow formatting of comments with "gq".
" r         Automatically insert the current comment leader after hitting
"           <Enter> in Insert mode.
" t         Auto-wrap text using textwidth (does not apply to comments)
set formatoptions=c,q,r,t

" =============================================================================
" Input settings
" =============================================================================

" Enable the use of the mouse.
set mouse=a

" Hide cursor while typing
set mousehide

" Use F11 to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>

" Stop certain movements from always going to the start of the line.
set nostartofline

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save
set confirm

" Quickly time out on keycodes; never time out on mappings.
set notimeout ttimeout ttimeoutlen=200

" =============================================================================
" Syntax- and filetype-related settings
" =============================================================================

"Attempt to determine the type of file based on its name and possibly its
"contents.  Use this to allow intelligent auto-indenting for each filetype, and
"for plugins that are filetype-specific.
filetype plugin indent on

" Enable syntax highlighting
syntax on

" =============================================================================
" Wildmenu
" =============================================================================
" Better command-line completion
set wildmenu
set wildmode=list:longest,full

" =============================================================================
" Miscellaneous
" =============================================================================
" Change working directory to directory of current file
autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif

" Restore cursor position
function! ResCur()
    if line("'\"") <= line("$")
        normal! g`"
        return 1
    endif
endfunction

augroup resCur
    autocmd!
    autocmd BufWinEnter * call ResCur()
augroup END

" =============================================================================
" Command-related settings
" =============================================================================

" Set options for the :grep command
set grepprg=grep\ -nH\ $*

" Remove any trailing whitespace that is in the file
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif


" Maybe fixes BundleSearch errors?
set shell=/bin/bash

" =============================================================================
" Filetype mappings and related settings
" =============================================================================

" Automatically detect filetype upon :w
autocmd BufRead,BufWrite,BufWritePost * :filetype detect

" Set Rexfiles to use Perl syntax
autocmd BufRead,BufWrite,BufWritePost,BufNewFile Rexfile set filetype=perl

" Set Vimperator configuration file to use Vim syntax
autocmd BufRead,BufNewFile *.vimperatorrc set filetype=vim

" =============================================================================
" Key mappings
" =============================================================================

let mapleader=','

" Map Y to work like D and C, i.e. to yank until EOL, rather than to act as yy,
" which is the default.
map Y y$

" Tab handling mappings
nnoremap th :tabfirst<CR>
nnoremap tj :tabnext<CR>
nnoremap tk :tabprev<CR>
nnoremap tl :tablast<CR>
nnoremap tt :tabedit<Space>
nnoremap tn :tabnext<Space>
nnoremap tm :tabm<Space>
nnoremap td :tabclose<CR>
nnoremap H :tabfirst<CR>
nnoremap J :tabnext<CR>
nnoremap K :tabprev<CR>
nnoremap L :tablast<CR>

" Enter normal mode
inoremap jjj <Esc>
" Causes trouble with mapping of J to :tabnext
"nnoremap JJJJ <Nop>

" Enter and exit 'hex mode' (streaming buffer through xxd)
noremap <F7> :%!xxd <CR>
noremap <F8> :%!xxd -r <CR>

" Map Y to work like D and C, i.e. to yank until EOL,
" rather than to act as yy, which is the default.
map Y y$

" Map <C-L> (redraw screen) to also turn off
" search highlighting until the next search.
nnoremap <C-L> :nohl<CR><C-L>

" Undo the mapping of <C-a>, since that's what I use for my tmux prefix and
" it's causing mischief with numbers
nnoremap <A-a> <C-a>
nnoremap <A-x> <C-x>

" Change Working Directory to that of the current file
cmap cwd lcd %:p:h
cmap cd. lcd %:p:h

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Allow using the repeat operator with a visual selection (!)
" http://stackoverflow.com/a/8064607/127816
vnoremap . :normal .<CR>

" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null

" =============================================================================
" Functions/Commands
" =============================================================================

" Syntax: [:Etabs | :Ewindows | :Evwindows] file1 [, file2, ... , fileN]
" Opens a list of files in different tabs/windows/vertical windows
command! -complete=file -nargs=+ Etabs call s:ETW('tabnew', <f-args>)
command! -complete=file -nargs=+ Ewindows call s:ETW('new', <f-args>)
command! -complete=file -nargs=+ Evwindows call s:ETW('vnew', <f-args>)

function! s:ETW(what, ...)
  for f1 in a:000
    let files = glob(fnamemodify(f1, ":p"))
    if files == ''
      execute a:what . ' ' . fnameescape(f1)
    else
      for f2 in split(files, "\n")
        execute a:what . ' ' . fnameescape(f2)
      endfor
    endif
  endfor
endfunction

command! -nargs=+ Tabposition call s:Tabposition(<f-args>)
command! -nargs=? Tabfirst call s:Tabposition(0, <f-args>)

function! s:Tabposition(posi, ...)
    let file = fnameescape(a:1)
    if file == '0'
        execute "tabnew"
    else
        execute "tabnew " . file
    endif
    execute a:posi . "tabmove"
endfunction

" Return indent (all whitespace at start of a line), converted from
" tabs to spaces if what = 1, or from spaces to tabs otherwise.
" When converting to tabs, result has no redundant spaces.
function! Indenting(indent, what, cols)
  let spccol = repeat(' ', a:cols)
  let result = substitute(a:indent, spccol, '\t', 'g')
  let result = substitute(result, ' \+\ze\t', '', 'g')
  if a:what == 1
    let result = substitute(result, '\t', spccol, 'g')
  endif
  return result
endfunction

" Convert whitespace used for indenting (before first non-whitespace).
" what = 0 (convert spaces to tabs), or 1 (convert tabs to spaces).
" cols = string with number of columns per tab, or empty to use 'tabstop'.
" The cursor position is restored, but the cursor will be in a different
" column when the number of characters in the indent of the line is changed.
function! IndentConvert(line1, line2, what, cols)
  let savepos = getpos('.')
  let cols = empty(a:cols) ? &tabstop : a:cols
  execute a:line1 . ',' . a:line2 . 's/^\s\+/\=Indenting(submatch(0), a:what, cols)/e'
  call histdel('search', -1)
  call setpos('.', savepos)
endfunction
command! -nargs=? -range=% Space2Tab call IndentConvert(<line1>,<line2>,0,<q-args>)
command! -nargs=? -range=% Tab2Space call IndentConvert(<line1>,<line2>,1,<q-args>)
command! -nargs=? -range=% RetabIndent call IndentConvert(<line1>,<line2>,&et,<q-args>)

function! CommandCabbrev(abbreviation, expansion)
  execute 'cabbr ' . a:abbreviation . ' <c-r>=getcmdpos() == 1 && getcmdtype() == ":" ? "' . a:expansion . '" : "' . a:abbreviation . '"<CR>'
endfunction
command! -nargs=+ CommandCabbrev call CommandCabbrev(<f-args>)

command! -range=% -nargs=* PerlTidy if &filetype ==? 'perl' | <line1>,<line2> !perltidy -q -nst -b <args> <NL>| endif

" Source all vimrc files
command! SourceAll if filereadable($MYVIMRC) | source $MYVIMRC | endif | if has('gui_running') && filereadable($MYGVIMRC) |  source $MYGVIMRC | endif

augroup myvimrc
    au!
    au BufWritePost .vimrc*,_vimrc*,vimrc*,vimrc*,.gvimrc*,_gvimrc*,gvimrc* SourceAll
augroup END

" =============================================================================
" Abbreviations
" =============================================================================
" Abbreviate CommandCabbrev to a lowercase abbreviation
CommandCabbrev ccab CommandCabbrev
CommandCabbrev sw SudoWrite
CommandCabbrev sr SudoRead
CommandCabbrev src SourceAll
CommandCabbrev chk SyntasticCheck

" =============================================================================
" Plugin-specific settings
" =============================================================================
" haskellmode-vim
let g:haddock_browser = 'dwb'

" Try to stop autoclose from closing  comment characters in Vim files
let g:autoclose_vim_commentmode = 1

" Set file extensions that use C syntax highlighting
let g:C_SourceCodeExtensions = 'c cc cp cxx cpp CPP c++ C i ii hxx h'

" Remap perl MapLeader
"let g:Perl_MapLeader = ';'
let perl_include_pod = 1
let perl_extended_vars = 1

" Deals with temporary hang when saving python files
let g:pymode_rope_lookup_project = 0

" vim-indent-guides
let g:indent_guides_start_level = 2
let g:indent_guides_guid_size = 1

" vim-easy-align
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" =============================================================================
" Syntastic settings
" =============================================================================
" Options that apply to all filetypes
let g:syntastic_check_on_open = 1

" Aggregate errors/warnings from all enabled checkers
let g:syntastic_aggregate_errors = 1

let g:syntastic_perl_checkers = ['perl', 'perlcritic']
" Could be dangerous to use this when checking third-party files...
let g:syntastic_enable_perl_checker = 1

" =============================================================================
" perlcritic.vim settings
" =============================================================================

" perlcritic.vim has a slight but important bug/flaw: it doesn't pass any
" '-12345'/'--brutal'/etc. flags to the perlcritic executable, so only
" registers policy violations of level 5, perlcritic's default severity level.
" We fix this here by manually setting the '--brutal' flag, which catches all
" severity levels.
let g:syntastic_perl_perlcritic_args = '--brutal --exclude=HardTabs'

" All perlcritic messages above 3 are highlighted as errors, the rest are shown
" as warnings
let g:syntastic_perl_perlcritic_thres = 3

" =============================================================================
" Post-plugin configuration
" =============================================================================

colorscheme solarized

" =============================================================================
" Sourcing further vim configurations
" =============================================================================

" Use per-host local vimrc if available {
    if filereadable(expand("~/.vimrc.local"))
        source ~/.vimrc.local.custom
    endif
" }
