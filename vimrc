" = = = = = = = = = = = = = = = =
"
"  Global Configuration
"
" = = = = = = = = = = = = = = = =

" Break backwards vi compatibility
set nocompatible

" Set TrueTone 256 colors everywhere
set t_Co=256
set termguicolors

" Always show file tabs
set showtabline=2
" Sets displaying relative line numbers and current absolute line number
set nu rnu
" Set 7 lines to the cursor - when moving vertically using j/k
set so=5

" Open new split panes to right and bottom
set splitbelow
set splitright

" Ignore case when searching
set ignorecase
" When searching and uppercase is used, ignore ignorecase setting
set smartcase
" Highlight search results
set hlsearch
" For regular expressions turn magic on
set magic

" Use 2 spaces instead of tabs
set expandtab
set shiftwidth=2
set softtabstop=2

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

" set smartindent
" set wrap


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

" generic plugins
Plug 'ayu-theme/ayu-vim'
Plug 'tpope/vim-sensible'
Plug 'vim-airline/vim-airline'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mileszs/ack.vim'
Plug 'scrooloose/nerdtree'
" Plug 'jistr/vim-nerdtree-tabs' - remove if unused (22.01)
Plug 'git://github.com/tpope/vim-abolish.git'

" coding plugins
Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" language-specific plugins
"" Go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
"" Clojure
" Plug 'Olical/conjure'
Plug 'tpope/vim-fireplace'
Plug 'guns/vim-clojure-static'
Plug 'guns/vim-clojure-highlight'
Plug 'luochen1990/rainbow'
Plug 'venantius/vim-cljfmt'
Plug 'clojure-vim/async-clj-omni'
"" MDX
Plug 'jxnblk/vim-mdx-js'

call plug#end()

" = = = = = = = = = = = = = = = =
"
"  Plugins Configuration
"
" = = = = = = = = = = = = = = = =

let ayucolor="mirage"
colorscheme ayu

""" Ack/The Silver Searcher

" let g:ackprg = 'ag --vimgrep' has the same effect but will report every match on the line.
let g:ackprg = 'ag --nogroup --nocolor --column'
" Auto close the Quickfix list after pressing '<enter>' on a list item
let g:ack_autoclose = 1
" Any empty ack search will search for the work the cursor is on
let g:ack_use_cword_for_empty_search = 1
" Don't jump directly to the first search result
cnoreabbrev Ack Ack!
" Maps <leader>/ so we're ready to type the search keyword
nnoremap <Leader>/ :Ack!<Space>
" Navigate quickfix list with ease
nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> ]q :cnext<CR>

""" NERDTree

" Show hidden files
let NERDTreeShowHidden = 1
" Remove 'Press ? for help' from the UI
let NERDTreeMinimalUI = 1
" Bind CTRL+n to open files tree
map <C-n> :NERDTreeToggle<CR>

""" NERDTree Tabs

" Bind CTRL+n to open files tree
" map <C-n> <plug>NERDTreeTabsToggle<CR>
" Automatically open NerdTree when opening a directory
" let g:nerdtree_tabs_open_on_console_startup = 2
" Don't close current tab if there is only one window in it and it's NERDTree
" let g:nerdtree_tabs_autoclose = 0

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


""" vim-cljfmt

" Auto-format on save
let g:clj_fmt_autosave = 1


