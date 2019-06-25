"plugins
call plug#begin('~/.config/nvim/plugged')

  "editor
  Plug 'jacoborus/tender.vim'
  Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins' }
  Plug 'ervandew/supertab'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'itchyny/lightline.vim'
  Plug 'mgee/lightline-bufferline'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'gioele/vim-autoswap'
  Plug 'w0rp/ale'
  Plug 'jiangmiao/auto-pairs'
  Plug 'scrooloose/nerdtree'
  Plug 'sheerun/vim-polyglot'

  "js
  Plug 'ternjs/tern_for_vim', { 'for': ['javascript'], 'do': ['npm install']}
  Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
  Plug 'pangloss/vim-javascript'
  Plug 'posva/vim-vue'
  Plug 'maxmellon/vim-jsx-pretty'

  "git
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'

call plug#end()

"editor
set number
set relativenumber
set encoding=utf-8
set updatetime=250
call matchadd('ColorColumn', '\%>81v\+', 100)
set clipboard+=unnamedplus
set undolevels=300
set wildchar=<Tab> wildmenu wildmode=full
set splitbelow
set splitright
set wildignore=./**/node_modules/**
set hidden
set showtabline=2
set fileformat=unix
set expandtab 
set autoindent
set autochdir
filetype plugin indent on

"theme
syntax enable
colorscheme tender
highlight clear SignColumn

"auto-pairs
let g:AutoPairsFlyMode = 0

"gitgutter
set signcolumn=yes
let g:gitgutter_max_signs = 9999

"deoplete
let g:deoplete#enable_at_startup = 1
set completeopt=longest,menuone,preview
let g:deoplete#max_list = 200
let g:deoplete#on_insert_enter = 'true'
let g:deoplete#sources#ternjs#omit_object_prototype = 0
let g:deoplete#sources#ternjs#filetypes = [
                \ 'jsx',
                \ 'javascript.jsx',
                \ 'vue',
                \ ]


"tern
let g:tern#command = ['tern']
let g:tern#arguments = ['--persistent']
let g:tern_show_argument_hints = 'on_hold'
let g:tern_map_keys = 1

"supertab
let g:SuperTabClosePreviewOnPopupClose = 1
let g:SuperTabDefaultCompletionType = "<c-n>"

" yml 
au BufNewFile,BufRead *.yml,*.yaml setlocal textwidth=80 tabstop=2 shiftwidth=2 linebreak

" js
au BufNewFile,BufRead *.js,*.ts,*.json,*.vue,*.jsx set tabstop=2 shiftwidth=2 

" web
au BufNewFile,BufRead *.html,*.css set tabstop=2 shiftwidth=2 

"ale
let g:ale_fixers = {
      \  'javascript': ['eslint']
      \}

"lightline
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'filename': 'LightLineFilename'
      \ },
      \ }

function! LightLineFilename()
  return expand('%:p')
endfunction

" lightline-bufferline
let g:lightline.tabline          = {'left': [['buffers']], 'right': [['close']]}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type   = {'buffers': 'tabsel'}
let g:lightline#bufferline#shorten_path = 0

" NERDtree
nmap <C-n> :NERDTreeToggle<CR>

" keymaps
nmap <silent> <C-h> :set hlsearch!<CR>
nmap <silent> <C-s> :bnext<CR>
nmap <silent> <C-a> :bprevious<CR>
nmap <silent> <C-z> <Plug>(ale_previous_wrap)<CR>
nmap <silent> <C-x> <Plug>(ale_next_wrap)<CR>
nmap <silent> <C-k> :Buffers<CR>
nmap <silent> <C-f> :Files<CR>
nmap <silent> <C-l> :Lines<CR>
nmap <silent> <C-c> :Commits<CR>
nmap <silent> <F5> ggg?G``<CR>

" disable arrows
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
