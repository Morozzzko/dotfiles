
" # Plugins

call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}} " VSCode & LSP
Plug 'w0rp/ale'
Plug 'brooth/far.vim' " Search & replace

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb' " gh support for vim-fugitive

Plug 'scrooloose/nerdtree' " Project tree

Plug 'ntpeters/vim-better-whitespace' " Highlight extra whitespace

" Plug 'Shougo/echodoc.vim' " Display signatures from completion

Plug 'tpope/vim-commentary' " Comment lines using gc
Plug 'nanotech/jellybeans.vim'

Plug 'airblade/vim-gitgutter' " Add git changes to the sign column

Plug 'vim-airline/vim-airline' " Cool status bar below
Plug 'zivyangll/git-blame.vim' " Git blame below airline

Plug 'jiangmiao/auto-pairs' " Automatically insert pairs for quotes

Plug 'lxhillwind/leader-clipboard' " Access system clipboard

Plug 'Asheq/close-buffers.vim' " Close all buffers except current
Plug 'hjanuschka/vim-danger'

" ## Language support

Plug 'Yggdroot/indentLine' " Indentation line

Plug 'udalov/kotlin-vim'

Plug 'othree/html5.vim'
" Plug 'tpope/vim-ragtag' " Adds tags for php, django, etc.
" Plug 'digitaltoad/vim-pug', { 'for': 'pug' }
Plug 'slim-template/vim-slim', { 'for': ['slim', 'slime'] }
Plug 'jparise/vim-graphql'

Plug 'pangloss/vim-javascript'
Plug 'chemzqm/vim-jsx-improve', { 'for': 'javascript' }

Plug 'aklt/plantuml-syntax'
Plug 'tyru/open-browser.vim'
Plug 'weirongxu/plantuml-previewer.vim'

Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'tpope/vim-rails', { 'for': 'ruby' }

" Running test

Plug 'janko-m/vim-test'


" Fuzzy search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'ekalinin/Dockerfile.vim', { 'for': 'Dockerfile' }

call plug#end()

" # Fancy editor config
set autoread " Automatically refresh buffers if changed on disk
set nofoldenable " Do not fold blocks (?)
set wrap " Wrap lines
set linebreak " Wrap lines the smart way (by words)
set number " Line numbers
set relativenumber " Set lines relative to current
set hlsearch " Highliight matches for prev search
set ignorecase " Simplify search by ignoring case
set smartcase

set expandtab " Replace <Tab> with spaces
set softtabstop=2
set shiftwidth=2

set splitbelow " Split window below instead of above
set cmdheight=2
set signcolumn=no " Add sign column next to line number
set scrolloff=3 " Add extra 3 lines around current line while scrolling


" Turn backup off, since most stuff is in SVN, git etc anyway...
set nobackup
set nowritebackup
set nowb
set noswapfile


set showcmd       " display incomplete commands
set autowrite     " Automatically :write before running commands

set hidden " Do not display warning for unsaved buffer


silent! colorscheme jellybeans " Set color scheme / editor theme


" # Key bindings

set pastetoggle=<F2> " Use F2 to enter Paste mode

let mapleader = "\<Space>"

" Enable (some) hotkeys with Russian layout
set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz

if has('mouse') " Enable mouse
  set mouse=a
endif


" Turn off linewise keys. Normally, the `j' and `k' keys move the cursor down one entire line. with line wrapping on, this can cause the cursor to actually skip a few lines on the screen because it's moving from line N to line N+1 in the file. I want this to act more visually -- I want `down' to mean the next line on the screen
nmap j gj
nmap k gk
nmap <Down> gj
nmap <Up> gk

" Map ctrl-movement keys to window switching
map <C-k> <C-w><Up>
map <C-j> <C-w><Down>
map <C-l> <C-w><Right>
map <C-h> <C-w><Left>


" format the entire file
nnoremap ff :normal! gg=G``<CR>



" # Plugin-specific config

let g:strip_whitespace_confirm=0

" ## Nerd tree

nmap <C-m> :NERDTreeFind<CR>
nmap <silent> <leader><leader> :NERDTreeToggle<CR>

let NERDTreeIgnore = ['\.pyc$', '\.retry$']
let NERDTreeShowHidden=1

" ## Better whitespace

let g:strip_whitespace_on_save=1


" Open buffers
nnoremap <leader>b :Buffers<CR>

" Searching using fuzzy
nnoremap <Leader>w :w<CR>
nnoremap <Leader>o :GFiles .<CR>
nnoremap <leader>fc :Commits<CR>
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fa :Ag<CR>

let g:fzf_layout = { 'down': '~40%' }

let g:fzf_layout = { 'window': 'enew' }
let g:fzf_layout = { 'window': '-tabnew' }
let g:fzf_layout = { 'window': '10split enew' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
      \ { 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }



command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always --fixed-strings --smart-case --hidden --follow --glob "!.git/*" '.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview('up:60%')
      \           : fzf#vim#with_preview('right:50%:hidden', '?'),
      \   <bang>0)
" }}}



" ## ALE

" \ 'scss': ['stylelint'],
" \ 'css': ['stylelint'],
" \ 'python': ['autopep8'],
" \ 'slim': ['trim_whitespace'],
" \ 'elixir': ['mix_format'],
let g:ale_fixers = {
      \ 'ruby': ['rubocop'],
      \ 'javascript': ['prettier', 'eslint'],
      \ 'reason': ['refmt'],
      \ '*': []
      \}

let g:ale_linters = {
      \ 'ruby': ['rubocop'],
      \ 'javascript': ['eslint'],
      \ '*': []
      \}

let g:ale_ruby_rubocop_executable = 'rubocop-daemon-wrapper'
let g:ale_linters_explicit = 0 " Do not run linters not listed in the file

let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1
let g:airline#extensions#ale#enabled = 1 " Show on status line

" ## Persistent Undo
" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif

" ## Misc
"
" Open new split for C+hjkl, if split doesnt exist
map <silent> <C-h> :call WinMove('h')<CR>
map <silent> <C-j> :call WinMove('j')<CR>
map <silent> <C-k> :call WinMove('k')<CR>
map <silent> <C-l> :call WinMove('l')<CR>
function! WinMove(key)
  let t:curwin = winnr()
  exec "wincmd ".a:key
  if (t:curwin == winnr())
    if (match(a:key,'[jk]'))
      wincmd v
    else
      wincmd s
    endif
    exec "wincmd ".a:key
  endif
endfunction

" ## git-blame

nnoremap <Leader>gb :<C-u>call gitblame#echo()<CR>

" ## indent lines

let g:indentLine_setColors = 1
let g:indentLine_enabled = 1

" ## close buffers

nnoremap <silent> Q :Bdelete menu<CR>

" # COC

" Code navigation
nmap <silent> gd <Plug>(coc-definition)

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" vim-test

" these "Ctrl mappings" work well when Caps Lock is mapped to Ctrl
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

let test#strategy = "neovim"
