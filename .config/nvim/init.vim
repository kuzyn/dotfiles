"plugins
call plug#begin('~/.config/nvim/plugged')
  "editor
  Plug 'jacoborus/tender.vim'
  Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins' }
  Plug 'ervandew/supertab'
  Plug 'vim-airline/vim-airline'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'vim-syntastic/syntastic'
  Plug 'jiangmiao/auto-pairs'
  Plug 'scrooloose/nerdtree'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  "js
  Plug 'ternjs/tern_for_vim', { 'for': ['javascript'] }
  Plug 'carlitux/deoplete-ternjs', { 'for': ['javascript'] }
  Plug 'mtscout6/syntastic-local-eslint.vim'
  Plug 'pangloss/vim-javascript'
  Plug 'heavenshell/vim-jsdoc'
  "git
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'
  "md
  "Plug 'JamshedVesuna/vim-markdown-preview'
call plug#end()

"editor
set number
set relativenumber
set encoding=utf-8
set tabstop=2
set expandtab
set shiftwidth=2
set updatetime=250
"set colorcolumn=80
"highlight ColorColumn ctermbg=darkgray
match ErrorMsg '\%>80v.\+'
set clipboard=unnamed
set undolevels=100
set guifont=Hack

"theme
syntax enable
colorscheme tender

"airline
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline_powerline_fonts = 1 
let g:airline_theme = 'tender'

"gitgutter
set signcolumn=yes

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

" syntastic
let g:syntastic_javascript_checkers=['eslint']
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1

"md files
"au BufRead,BufNewFile *.md setlocal textwidth=80 linebreak
"let vim_markdown_preview_use_xdg_open=1
"let vim_markdown_preview_toggle=1
"let vim_markdown_preview_github=1

"NERDtree
"autocmd vimenter * NERDTree
map <C-n> :NERDTreeToggle<CR>

" pasting
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

" keymaps
nmap <silent> <C-l> <Plug>(jsdoc)
nmap <silent> <C-h> :set hlsearch! 
