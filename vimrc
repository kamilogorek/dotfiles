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

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

" Enable smart indenting and line wrapping
set smartindent
set wrap

" Enable backspace key to work in any mode
set backspace=indent,eol,start

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

" This autocommand jumps to the last known position in a file just after opening it, if the '" mark is set: >
autocmd BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit'
      \ |   exe "normal! g`\""
      \ | endif

" = = = = = = = = = = = = = = = =
"
"  Plugins
"
" = = = = = = = = = = = = = = = =

call plug#begin('~/.vim/plugged')

Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mileszs/ack.vim'
Plug 'scrooloose/nerdtree'

call plug#end()

" = = = = = = = = = = = = = = = =
"
"  Plugins Configuration
"
" = = = = = = = = = = = = = = = =

try
    colorscheme tokyonight-storm
catch /^Vim\%((\a\+)\)\=:E185/
endtry

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

""" CtrlP

" CtrlP will now root itself within that directory rather than continuing up the stack to find your .git directory.
let g:ctrlp_root_markers = ['deps.edn']
" Ignore .gitignore files in CtrlP
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
