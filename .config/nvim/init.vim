"plugins
call plug#begin('~/.config/nvim/plugged')
  "editor
  Plug 'jacoborus/tender.vim'
  Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins' }
  Plug 'ervandew/supertab'
  Plug 'mileszs/ack.vim'
  Plug 'junegunn/fzf' 
  Plug 'junegunn/fzf.vim'
  Plug 'itchyny/lightline.vim'
  Plug 'mgee/lightline-bufferline'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'gioele/vim-autoswap'
  Plug 'w0rp/ale'
  Plug 'jiangmiao/auto-pairs'
  Plug 'scrooloose/nerdtree'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  "js
  Plug 'ternjs/tern_for_vim', { 'for': ['javascript'] }
  Plug 'carlitux/deoplete-ternjs', { 'for': ['javascript'] }
  Plug 'pangloss/vim-javascript'
  Plug 'heavenshell/vim-jsdoc'
  Plug 'posva/vim-vue'
  "git
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'
  "py
  Plug 'python-mode/python-mode', {'branch': 'develop'}
  "elixir
  Plug 'elixir-editors/vim-elixir'
  Plug 'ekalinin/Dockerfile.vim'

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
set wildignore=/home/kuzyn/code/**/node_modules/**
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

"gitgutter
set signcolumn=yes
let g:gitgutter_max_signs=9999

"deoplete
let g:deoplete#enable_at_startup = 1
set completeopt=longest,menuone,preview
let g:deoplete#sources = {}
let g:deoplete#sources['javascript.jsx'] = ['file', 'ternjs']

"tern
let g:tern#command = ['tern']
let g:tern#arguments = ['--persistent']
let g:tern_show_argument_hints='on_hold'
let g:tern_map_keys=1

"supertab
let g:SuperTabClosePreviewOnPopupClose = 1
autocmd FileType javascript let g:SuperTabDefaultCompletionType = '<c-x><c-o>'

"md files
"au BufRead,BufNewFile *.md setlocal textwidth=80 linebreak
au BufRead,BufNewFile *.md setlocal
let vim_markdown_preview_use_xdg_open=1
let vim_markdown_preview_toggle=1
let vim_markdown_preview_github=1

"yml files
au FileType yaml setlocal textwidth=80 tabstop=2 shiftwidth=2 linebreak

" pymode
let pymode_lint_cwindow = 0
let python_lint_async = 1

" Python
au FileType python set shiftwidth=4 tabstop=4 softtabstop=4 
let g:pymode_python = 'python3'

"Javascript
au BufNewFile,BufRead *.js,*.ts,*.json,*.vue set tabstop=2 shiftwidth=2 

"ale
let g:ale_fixers = {
      \  'javascript': ['eslint']
      \}

" lightline
let g:lightline = {}
let g:lightline.active = {} 
let g:lightline.active.left = [['mode', 'paste'], ['gitbranch', 'filename', 'modified']]
let g:lightline.active.right = [['lineinfo'], ['percent'], ['readonly']]
let g:lightline.component_type = { 'readonly': 'error', 'buffers': 'tabsel' }
let g:lightline.component_function = {'gitbranch': 'fugitive#head'}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.tabline          = {'left': [['buffers']], 'right': [['close']]}

" NERDtree
nmap <C-n> :NERDTreeToggle<CR>

" ack.vim
let g:ackprg = 'ag --vimgrep'

" fzf
set rtp+=/usr/bin/fzf

" sessions
nmap <F2> :mksession! ~/.config/nvim/vim_session<CR>
nmap <F3> :source ~/.config/nvim/vim_session<CR>

" keymaps
nmap <silent> <C-h> :set hlsearch!<CR>
nmap <silent> <C-s> :bnext<CR>
nmap <silent> <C-a> :bprevious<CR>
nmap <silent> <C-j> <Plug>(jsdoc)
nmap <silent> <C-z> <Plug>(ale_previous_wrap)
nmap <silent> <C-x> <Plug>(ale_next_wrap)
nmap <silent> + ddp
nmap <silent> _ ddkP
nmap <silent> <C-k> :Buffers<CR>
nmap <silent> <C-l> :Files<CR>
nmap <silent> <F5> ggg?G``

" disable arrows
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" printing / hardcopy
let &printexpr="(v:cmdarg=='' ? ".
    \"system('lpr' . (&printdevice == '' ? '' : ' -P' . &printdevice)".
    \". ' ' . v:fname_in) . delete(v:fname_in) + v:shell_error".
    \" : system('mv '.v:fname_in.' '.v:cmdarg) + v:shell_error)"
