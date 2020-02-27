" Break backwards vi compatibility
set nocompatible

" Enable syntax highlighting
syntax on
set t_Co=256

" Sets displaying relative line numbers and current absolute line number
set nu rnu

" Set 7 lines to the cursor - when moving vertically using j/k
set so=5

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Tab-complete till prefix only and double-tap for cycling
set wildmode=list:longest,full

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Allows for mouse scrolls/click
set mouse=a

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

" Clear the search buffer  when hitting return
:nnoremap <CR> :nohlsearch<cr>

" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Multipurpose Tab Key
" Indent if we're at the beginning of a line. Else, do completion.
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>"

" Always show the status line
set laststatus=2

" " Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>
map <leader>rr :so $MYVIMRC<cr>

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" vim-plug setup

call plug#begin('~/.vim/plugged')

Plug 'flazz/vim-colorschemes'
Plug 'mileszs/ack.vim'
Plug 'Valloric/MatchTagAlways'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'editorconfig/editorconfig-vim'
Plug 'git://github.com/tpope/vim-abolish.git'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sbdchd/neoformat'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'leafgarland/typescript-vim'
Plug 'fatih/vim-go'
Plug 'elixir-lang/vim-elixir'
Plug 'prettier/vim-prettier'
Plug 'mustache/vim-mustache-handlebars'
Plug 'cespare/vim-toml'

call plug#end()

" Ack/The Silver Searcher
let g:ackprg = 'ag --nogroup --nocolor --column'

" NERDTree

" Bind CTRL+n to open files tree
map <C-n> <plug>NERDTreeTabsToggle<CR>

" Automatically open NerdTree when opening a directory
let g:nerdtree_tabs_open_on_console_startup = 2

" Don't close current tab if there is only one window in it and it's NERDTree
let g:nerdtree_tabs_autoclose = 0

" Show hidden files
let NERDTreeShowHidden = 1

" Remove 'Press ? for help' from the UI
let NERDTreeMinimalUI = 1

" This autocommand jumps to the last known position in a file just after opening it, if the '" mark is set: >
autocmd BufReadPost *
	\ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit'
	\ |   exe "normal! g`\""
	\ | endif

" CtrlP

" Ignore .gitignore files in CtrlP
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" Neoformat
autocmd BufWritePre *.{js,jsx,json,ts,ex,exs} Neoformat

" GoLangCi
" command GoLangCI :cexpr system('golangci-lint run')
" autocmd BufWritePre *.{go} GoLangCI

" let g:go_metalinter_autosave = 1
" let g:go_metalinter_autosave_enabled = ['vet', 'golint', 'gocyclo', 'errcheck', 'deadcode']
" let g:go_metalinter_enabled = ['vet', 'golint', 'gocyclo', 'errcheck', 'deadcode']
