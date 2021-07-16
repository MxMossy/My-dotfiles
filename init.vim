" mxmossy's init.vim

" Get recovery files out of the way
set backupdir=~\AppData\Local\nvim\backups\\ " backups
set dir=~\AppData\Local\nvim\swapfiles\\     " swapfiles
set undodir=~\AppData\Local\nvim\undofiles\\ " undofiles
     
" appearance and behavior
set tabstop=4                      " tabs are 4 spaces       
set shiftwidth=4                   " autoindent lines 4 spaces
set expandtab                      " for the sake of peace, I use spaces
set autoindent                     " indent on o/O and <CR>
set smartindent                    " autoindenting in C-like programs
set backspace=indent,eol,start     " make backspace behave like you should expect
set formatoptions=cqj              " only autowrap comments
set number relativenumber          " use hybrid line numbering
set scrolloff=20                   " keep 20 lines of context above/below cursor
set splitright                     " open new splits to the right
set splitbelow                     " open new splits on the bottom
set mouse=a                        " let me click and scroll if needed
set incsearch                      " show results as I search
set ignorecase                     " generally more useful
set smartcase                      " override ignorecase when capital letters
set gdefault                       " s///g by default

" resize splits automatically when opening new terminal window
autocmd VimResized * wincmd =

" quick window/tab switching
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-0> gt                  
nnoremap <C-9> gT

" leader shortcuts
let mapleader=' '
" quick-open neovim init.vim
nnoremap <leader>v :vsp ~/AppData/Local/nvim/init.vim<CR>
" copy/paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>y "+y
" quick file browsing
nnoremap <leader>e :E<CR>

" hide .meta files when browsing
let g:netrw_list_hide= '.*\.meta$'

" Vim-Plug
call plug#begin('~/AppData/Local/nvim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'flazz/vim-colorschemes'

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
" Plug 'dense-analysis/ale'

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

Plug 'hrsh7th/vim-vsnip'
Plug 'rafamadriz/friendly-snippets'
Plug 'Raimondi/delimitMate'

Plug 'preservim/nerdtree'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
call plug#end()

" fzf
nnoremap <leader>f :Files<CR>
nnoremap <leader>b :Buffers<CR>

" Airlines
set encoding=utf-8
let g:airline_theme='bubblegum'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#fnamemod = ':t'

" colorscheme
colorscheme gruvbox

" NERDTree
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
nnoremap <C-t> :NERDTreeToggle<CR>


" ALE config
" let g:ale_linters = {'cpp': ['clang']}
" let g:airline#extensions#ale#enabled = 1
" let g:ale_lint_on_enter = 0
" let g:ale_lint_on_insert_leave = 1

""" Vsnip """
" Expand
imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

" Expand or jump
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

" Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'


""" LSP Config """
nnoremap <leader>d :call v:lua.toggle_diagnostics()<CR>
" au CursorHold * lua vim.lsp.diagnostic.set_loclist()

lua << EOF
--- toggle diagnostics
function _G.toggle_diagnostics()
  if vim.g.diagnostics_active then
    vim.g.diagnostics_active = false
    vim.lsp.diagnostic.clear(0)
    vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end
  else
    vim.g.diagnostics_active = true
    --- hacky solution to reenable diagnostic 
    vim.cmd([[exe "normal ii\<Esc>x"]])
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
      }
    )
  end
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    signs = true,
    underline = true,
    update_in_insert = false,
  }
)

vim.api.nvim_set_keymap('n', '<leader>tt', ':call v:lua.toggle_diagnostics()<CR>',  {noremap = true, silent = true})

---pyright
require'lspconfig'.pyright.setup{}

---omnisharp
local pid = vim.fn.getpid()
local omnisharp_bin = "C:/Users/mxmoss/.vscode/extensions/ms-dotnettools.csharp-1.23.12/.omnisharp/1.37.10/OmniSharp.exe"
require'lspconfig'.omnisharp.setup{
    cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) };
}
vim.lsp.set_log_level("debug")

---clangd
require'lspconfig'.clangd.setup{}
EOF

" compe setup - https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion 
lua << EOF
-- Compe setup
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    nvim_lsp = true;
  };
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
EOF
