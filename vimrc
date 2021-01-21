" = = = = = = = = = = = = = = = =
"
"  Global Configuration
"
" = = = = = = = = = = = = = = = =

" Break backwards vi compatibility
set nocompatible

" Set TrueTone 256 colors everywhere
set t_Co=256
set term=xterm-256color
set termguicolors

" Always show file tabs
set showtabline=2

" Sets displaying relative line numbers and current absolute line number
set nu rnu

" Set 7 lines to the cursor - when moving vertically using j/k
set so=5

" Ignore case when searching
set ignorecase

" When searching and uppercase is used, ignore ignorecase setting
set smartcase

" Highlight search results
set hlsearch

" For regular expressions turn magic on
set magic

" Use spaces instead of tabs
set expandtab

" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2

" Linebreak on 500 characters
set lbr
set tw=500

" set smartindent
set wrap

" Allows for mouse scrolls/click
set mouse=a

" TODO: Remove if unused till March 1st
"
" Use Unix as the standard file type
" set ffs=unix,dos,mac

" Turn backup off, since most stuff is in SVN, git et.c anyway...
" set nobackup
" set nowb
" set noswapfile


" = = = = = = = = = = = = = = = =
"
"  Custom Key Bindings
"
" = = = = = = = = = = = = = = = =

" Clear the search buffer  when hitting return
:nnoremap <CR> :nohlsearch<cr>

" Treat long lines as break lines (wrapped lines will be 'virtually' split into separate lines for navigation)
map j gj
map k gk

" Multipurpose Tab Key - indent if we're at the beginning of a line, else, do completion.
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

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" TODO: Remove if unused till March 1st
"
" " Toggle paste mode on and off
" map <leader>pp :setlocal paste!<cr>
" map <leader>rr :so $MYVIMRC<cr>

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
" vnoremap <silent> * :call VisualSelection('f')<CR>
" vnoremap <silent> # :call VisualSelection('b')<CR>


" This autocommand jumps to the last known position in a file just after opening it, if the '" mark is set: >
" autocmd BufReadPost *
"       \ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit'
"       \ |   exe "normal! g`\""
"       \ | endif

" = = = = = = = = = = = = = = = =
"
"  Plugins
"
" = = = = = = = = = = = = = = = =

" vim-plug setup

call plug#begin('~/.vim/plugged')

" theme plugins
Plug 'ayu-theme/ayu-vim'

" common plugins
Plug 'tpope/vim-sensible'
Plug 'vim-airline/vim-airline'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mileszs/ack.vim'
Plug 'Valloric/MatchTagAlways'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'git://github.com/tpope/vim-abolish.git'
Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Clojure
Plug 'luochen1990/rainbow'

" Go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

call plug#end()

" = = = = = = = = = = = = = = = =
"
"  Plugins Configuration
"
" = = = = = = = = = = = = = = = =

let ayucolor="mirage"
colorscheme ayu

""" Ack/The Silver Searcher

let g:ackprg = 'ag --nogroup --nocolor --column'
let g:ack_autoclose = 1
cnoreabbrev Ack Ack!

""" NERDTree

" Show hidden files
let NERDTreeShowHidden = 1
" Remove 'Press ? for help' from the UI
let NERDTreeMinimalUI = 1

""" NERDTree Tabs

" Bind CTRL+n to open files tree
map <C-n> <plug>NERDTreeTabsToggle<CR>
" Automatically open NerdTree when opening a directory
let g:nerdtree_tabs_open_on_console_startup = 2
" Don't close current tab if there is only one window in it and it's NERDTree
let g:nerdtree_tabs_autoclose = 0

""" CtrlP

" CtrlP will now root itself within that directory rather than continuing up the stack to find your .git directory.
let g:ctrlp_root_markers = ['deps.edn']
" Ignore .gitignore files in CtrlP
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

""" luochen1990/rainbow

" Activate plugin
let g:rainbow_active = 1

""" Asynchronous Lint Engine

" Configure appropriate languages support
let g:ale_linters = {
\  'clojure': ['clj-kondo', 'joker']
\}
let g:ale_fixers = {
\  'javascript': ['prettier', 'eslint'],
\}
" Auto-fix on save
let g:ale_fix_on_save = 1

