" Main Vim Config

" Setup
set nocompatible

source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

"Options
filetype plugin indent on
syntax on

"enable mouse scolling
set mouse=a

" keep undo history when switching buffers
set hidden

"set leader to '
nnoremap ' <Nop>
let mapleader = "'"
nnoremap \ '

" indent settings
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent
set backspace=indent,eol,start

"buffer access
nnoremap <leader>b :ls<CR>:b<Space>
nnoremap <leader>s :ls<CR>:sbuffer<Space>
nnoremap <leader>v :ls<CR>:vert sbuffer<Space>

" tab movement
nnoremap <C-.> gt<CR>
nnoremap <C-,> gT<CR>
nnoremap <C-<> :tabm -1<CR>
nnoremap <C->> :tabm +1<CR>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" My custom settings
 set encoding=utf-8
set nobackup
set noswapfile
set noundofile
set scrolloff=999
set wrap!

"hybrid line numbers
set number relativenumber

augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

set wrap
let textwidth=80

" Ctags shortcut
nnoremap <leader>t <C-]>

"Turn off comment continuation
autocmd BufNewFile,BufRead * setlocal formatoptions-=cro

"Autosave on loss of focus
" au FocusLost * silent! wa

" Gets rid of highlight after search
nnoremap <esc><esc> <esc>:noh<cr>

" set clipboard=unnamed 

"automatically remember folds
augroup remember_folds
    autocmd!
    autocmd BufWinLeave ?* mkview
    autocmd BufWinEnter ?* silent! loadview
augroup END


" Remaps

"add white space without entering insert mode
nmap <S-Enter> O<Esc>j
nmap <CR> o<Esc>k

"easier movement
nnoremap H _
nnoremap L g_
nnoremap ci[ cib
nnoremap [[ ][%
nnoremap ]] ][

"folds
set foldlevelstart=0
nnoremap <Space> za
vnoremap <Space> za
nnoremap z0 zCz0
nnoremap <S-Space> zMzv

"use comma for marks
" nmap , '


" Plugin Settings

" NERDTree
nnoremap <leader>n :NERDTreeTabsToggle<CR>

" commentary
set runtimepath^=~/vimfiles/pack/tpope/start/commentary

"vim-sneak
" map f <Plug>Sneak_s
" map F <Plug>Sneak_S

"easymotion
" set runtimepath^=~/.vim/pack/easymotion/start/vim-easymotion
nmap <Leader>w <Plug>(easymotion-bd-w)
hi EasyMotionTarget ctermbg=none ctermfg=green
hi EasyMotionShade  ctermbg=none ctermfg=darkgrey

hi EasyMotionTarget2First ctermbg=none ctermfg=red
hi EasyMotionTarget2Second ctermbg=none ctermfg=lightred

hi EasyMotionMoveHL ctermbg=green ctermfg=black
hi EasyMotionIncSearch ctermbg=green ctermfg=black

"airline themes
let g:airline_theme='simple'
let g:airline_powerline_fonts = 1
"Enable list of buffers
let g:airline#extensions#tabline#enabled = 1
"Show just the file name
let g:airline#extensions#tabline#fnamemod = ':t'


"vim fugitive
" set runtimepath^=~/.vim/pack/tpope/start/vim-fugitive

" smooth scroll
" set runtimepath^=~/.vim/pack/terryma/start/vim-smooth-scroll
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>

" ale
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1

" python pep8
" set runtimepath^=~/.vim/pack/Vimjas/start/vim-python-pep8-indent

"Vim Syntastic
" set runtimepath^=~/.vim/pack/vim-syntastic/start/syntastic

" VimCompletesMe
" set runtimepath^=~/.vim/pack/ajh17/start/VimCompletesMe
let g:vcm_direction = 'p'

