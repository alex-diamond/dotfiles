set nocompatible

filetype on
filetype plugin on
filetype indent on
filetype plugin indent on

syntax enable

set nopaste
set clipboard=unnamed
set cryptmethod=blowfish
runtime macros/matchit.vim

set smarttab
set expandtab
set tabstop=4
set shiftround
set shiftwidth=4
set softtabstop=4
set autoindent
set copyindent
set smartindent
if has("patch-7.4.354")
    set breakindent
endif

set nojoinspaces

set nobackup
set noswapfile
set virtualedit=block

set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,cp1251,koi8-r
set fileformat=unix
set fileformats=unix,dos,mac

set pumheight=10
set backspace=indent,eol,start
set complete=.,b,d,i,k,s,t,U,u,w
set omnifunc=syntaxcomplete#Complete
set completeopt=longest,menu,menuone,preview
set cinwords=class,def,do,elif,else,except
set cinwords+=finally,for,if,switch,try,while,with
set sessionoptions=blank,buffers,curdir,folds,help
set sessionoptions+=options,slash,tabpages,unix,winsize

if (&filetype == "lisp")
    set lisp
endif

set autoread
set autochdir
set autowriteall

set cmdheight=1
set cmdwinheight=10
set textwidth=80

set foldenable
set foldclose=""
set foldcolumn=1
set foldlevel=10
set foldlevelstart=10
set foldmethod=indent
set foldopen=block,hor,mark,percent,quickfix,search,tag,undo

set hidden
set hlsearch
set incsearch
set smartcase
set infercase
set ignorecase
set iminsert=0
set imsearch=0
set helplang=en
set langmenu=en
language messages POSIX

set lazyredraw
set list
set listchars=tab:>~,trail:.
set showmatch
set matchpairs=<:>,(:),{:},[:]
set modeline
set modelines=1

set mouse=a
set mousehide
set mousemodel=extend

set noconfirm
set nocursorline
set nocursorcolumn
set magic
set nogdefault
set noruler
set nospell
set spelllang=en_us
set noerrorbells
set novisualbell

set number
set numberwidth=3
set relativenumber
set report=0
set scrolloff=10
set scrolljump=10
set shortmess=I
set showcmd
set showfulltag
set noshowmode
set splitbelow
set splitright
set equalalways

set laststatus=2
set statusline=%F%r%h%w
set statusline+=\ %m
set statusline+=\ %=%y
set statusline+=\ [%{&ff}]
set statusline+=\ Buffer:[%n]
set statusline+=\ Column:[%v]
set statusline+=\ Line:%l/%L[%p%%]
set statusline+=\ Mode:[%{ShowCurrentMode()}]

set switchbuf=newtab,split,useopen,usetab
set tabline=""
set showtabline=0
set timeout
set timeoutlen=3000
set ttimeoutlen=100
set title
set ttyfast
set history=1000
set undolevels=5000
set viewoptions=cursor,folds,options,slash,unix

set wildmenu
set wildmode=longest:full,full
set wildignore=*.bak,*.bin,*.class,*.exe,*.o,*.obj,*.pyc,*.pyo,*.swp
set wrap
set wrapscan
set nolinebreak
set whichwrap=<,>,[,]

set t_Co=256
set background=dark
if has("gui_running")
    winsize 120 40
    set linespace=0
    set guioptions=""
    set guitablabel=""
    colorscheme desert
endif

function! FormatFile()
    silent! normal ml
    if (&filetype != "python")
        silent! normal gg=G
    endif
    silent! %s/\s\+$//e
    silent! normal 'lzz
    silent! delmarks l
endfunction

function! ShowCurrentMode()
    let s:showMode = ""
    let s:currentMode = mode()
    if (s:currentMode ==# "i")
        let s:showMode = "Insert"
    elseif (s:currentMode ==# "R")
        let s:showMode = "Replace"
    elseif (s:currentMode ==# "n")
        let s:showMode = "Normal"
    else
        let s:showMode = "Visual"
    endif
    return s:showMode
endfunction

function! UseTemplates(type)
    let s:scriptLine = "#!/usr/bin/env "
    let s:scriptEncoding = "# -*- coding: utf-8 -*-"
    if (a:type == "sh")
        execute setline(1, s:scriptLine . "bash")
        execute setline(2, "")
    elseif (a:type == "perl")
        execute setline(1, s:scriptLine . "perl")
        execute setline(2, "")
        execute setline(3, "use strict;")
        execute setline(4, "use warnings;")
        execute setline(5, "")
    elseif (a:type == "python")
        execute setline(1, s:scriptLine . "python3")
        execute setline(2, s:scriptEncoding)
        execute setline(3, "")
    endif
    silent! normal Go
endfunction

function! Run()
    silent! write
    silent! execute "!clear"
    if (&filetype == "perl")
        execute "!perl %"
    elseif (&filetype == "python")
        execute "!python3 %"
    elseif ((&filetype == "sh") && (has("unix") || has("mac")))
        execute "!sh %"
    else
        return
    endif
endfunction

function! MakeExecutable()
    if ((getline(1) =~ "#!") && (getline(1) =~ "bin/"))
        silent! execute "!chmod a+x <afile>"
    endif
endfunction

if has("autocmd")
    augroup BeforeWritingFile
        autocmd!
        autocmd BufWritePre * retab
        autocmd BufWritePre * call FormatFile()
    augroup END
    augroup AfterWritingFile
        autocmd!
        autocmd BufWritePost $MYVIMRC source $MYVIMRC
        if (has("unix") || has("mac"))
            autocmd BufWritePost * call MakeExecutable()
        endif
    augroup END
    augroup CreateNewFile
        autocmd!
        autocmd BufNewFile *.sh call UseTemplates("sh")
        autocmd BufNewFile *.pl,*.pm call UseTemplates("perl")
        autocmd BufNewFile *.py,*.pyw call UseTemplates("python")
    augroup END
    autocmd BufRead,BufNewFile *.py let python_highlight_all = 1
endif

let mapleader=","
nnoremap j gj
nnoremap k gk
nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l
nnoremap <silent>n nzz
nnoremap <silent>N Nzz
nnoremap <silent>* *zz
nnoremap <silent># #zz
nnoremap // :nohlsearch<Return>
nnoremap <leader><leader> :call Run()<Return>
vnoremap < <gv
vnoremap > >gv
cnoreabbrev q q!
cnoreabbrev Q q!
cnoreabbrev w w!
cnoreabbrev W w!
nmap <F3> :TagbarToggle<Return>
nmap <F4> :NERDTreeToggle<Return>
for prefix in ['i', 'n', 'v']
    for key in ['<Up>', '<Down>', '<Left>', '<Right>']
        execute prefix . "noremap " . key . " <Nop>"
    endfor
endfor
