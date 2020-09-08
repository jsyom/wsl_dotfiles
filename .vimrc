set nocompatible

" Vundle Settings/Plugins
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'morhetz/gruvbox'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-commentary'
Plugin 'jiangmiao/auto-pairs'
Plugin 'tpope/vim-fugitive'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'junegunn/fzf', { 'do': './install --all' }
Plugin 'junegunn/fzf.vim'
Plugin 'vim-scripts/SQLUtilities'
Plugin 'vim-scripts/Align'
call vundle#end()
filetype plugin indent on

augroup vimrc
  autocmd!
augroup END

syntax on
" Display Settings
if has('termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
set bg=dark
silent! colo gruvbox
let g:gruvbox_contrast_dark = 'soft'
set ttyfast

" Editor Settings
set encoding=utf-8
set rnu
set title
set showmode
set showmatch
set modeline
set ruler
set autoindent
set smartindent
set lazyredraw
set laststatus=2
set showcmd
set novisualbell
set backspace=indent,eol,start
set noswapfile
set timeoutlen=500
set ttimeoutlen=50
set hlsearch " CTRL-L / CTRL-R W
set incsearch
set hidden
set ignorecase
set smartcase
set wildmenu
set wildmode=full
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab
set smarttab
set list
set scrolloff=5
set listchars=tab:.\ ,trail:·,extends:#,nbsp:·
set autoread
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif
set nocursorline
set nofixeol

" Status Line
function! s:statusline_expr()
  let mod = "%{&modified ? '[+] ' : !&modifiable ? '[x] ' : ''}"
  let ro  = "%{&readonly ? '[RO] ' : ''}"
  let ft  = "%{len(&filetype) ? '['.&filetype.'] ' : ''}"
  let fug = "%{exists('g:loaded_fugitive') ? fugitive#statusline() : ''}"
  let sep = ' %= '
  let pos = ' %-12(%l : %c%V%) '
  let pct = ' %P'

  return '[%n] %F %<'.mod.ro.ft.fug.sep.pos.'%*'.pct
endfunction
let &statusline = s:statusline_expr()

" Local Mappings
let mapleader      = ' '
let maplocalleader = ' '
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"
inoremap jk <esc>`^
nnoremap ; :
map H g^
map L g$
" Make Y behave like other capitals
nnoremap Y y$
" qq to record, Q to replay
nnoremap Q @q
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
map <leader>e :e! ~/.vimrc<cr>
nmap <leader>w :w!<cr>
map <silent> <leader><cr> :nohl<cr>
" Open new line below and above current line
nnoremap <leader>o o<esc>
nnoremap <leader>O O<esc>
nnoremap / /\v
vnoremap / /\v
noremap > >>
noremap < <<
vnoremap > >gv
vnoremap < <gv
map <leader>r :e<cr>
nnoremap gV `[v`]
nnoremap <Tab> %
vnoremap <Tab> %
nnoremap <leader><leader> <C-^>
"Quick file reload
map <leader>r :e<cr>
" Write current file with sudo perms
command! W w

" Plugin Settings

" NERDTREE
augroup nerd_loader
  autocmd!
  autocmd VimEnter * silent! autocmd! FileExplorer
  autocmd BufEnter,BufNew *
        \  if isdirectory(expand('<amatch>'))
        \|   call plug#load('nerdtree')
        \|   execute 'autocmd! nerd_loader'
        \| endif
augroup END
let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 0
let NERDTreeQuitOnOpen = 1
let NERDTreeShowHidden=1
let NERDTreeAutoDeleteBuffer = 0
noremap <C-e> :NERDTreeToggle<cr>
" noremap <leader>' :%s/^\(.*\)$/"\1",/<CR>ddggyG <bar> :nohl<cr> Gg$dw
noremap <leader>' :%s/^\(.*\)$/"\1",/<CR> <bar> :nohl<cr> Gddg$dwggyG

" FZF {{{
let g:fzf_layout = { 'down': '40%' }
" Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" Search project files, respecting git ignore
nnoremap <silent> <C-f> :FZF<CR>
" Search all files, e.g. node_modules/
nnoremap <silent> <leader>af :call fzf#vim#files('',
      \ {'source': 'ag --hidden --ignore .git -f -g "" -u', 'down': '40%'})<CR>
" Search MRU buffers
nnoremap <silent> <leader>f :Buffers<CR>
nnoremap <silent> <leader>` :Marks<CR>
nnoremap <space>g :GitFiles<CR>
nnoremap <space>c :Commits<CR>
" [Tags] Command to generate tags file
" let g:fzf_tags_command = 'ctags -R --exclude=.git --exclude=node_modules --exclude=test'
nnoremap <silent> <leader>l :Lines<CR>
nnoremap <silent> <leader>t :Tags<CR>
nnoremap <silent> <leader>b :BTags<CR>

function! s:fzf_statusline()
  " Override statusline as you like
  highlight fzf1 ctermfg=161 ctermbg=251
  highlight fzf2 ctermfg=23 ctermbg=251
  highlight fzf3 ctermfg=237 ctermbg=251
  setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction

autocmd! User FzfStatusLine call <SID>fzf_statusline()
" }}}

vmap <silent>sf        <Plug>SQLU_Formatter<CR>
nmap <silent>scl       <Plug>SQLU_CreateColumnList<CR>
nmap <silent>scd       <Plug>SQLU_GetColumnDef<CR>
nmap <silent>scdt      <Plug>SQLU_GetColumnDataType<CR>
nmap <silent>scp       <Plug>SQLU_CreateProcedure<CR>
" Vim-Commentary
map  gc  <Plug>Commentary
nmap gcc <Plug>CommentaryLine

if system('uname -r') =~ "Microsoft"
  augroup Yank
    autocmd!
    autocmd TextYankPost * :call system('clip.exe ', @")
  augroup END
endif

runtime macros/matchit.vim
