" ************************
"* General Usability
" ************************
" TESTING SOFT LINK
syntax on
filetype plugin indent on
set number
set smartindent
set nowrap
set termguicolors
set splitright


" ************************
"* Plugins
" ************************
call plug#begin("~/.vim/plugged")
Plug 'tpope/vim-commentary'
Plug 'vim-airline/vim-airline'
Plug 'dense-analysis/ale'
Plug 'tpope/vim-sleuth'
Plug 'Yggdroot/indentLine'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'folke/tokyonight.nvim', { 'as': 'tokyo' }
call plug#end()


" ************************
"* Customizing Plugins
" ************************

" Enable ALE linting
let g:ale_enable_linting = 1

" Enable ALE completion
let g:ale_completion_enabled = 1

" Enable ALE fixing (fix on save)
let g:ale_fix_on_save = 1
let g:ale_fixers = {'*': ['remove_trailing_lines', 'trim_whitespace'], 'javascript': ['eslint'], 'python': ['ruff', 'autopep8', 'autoflake'], 'cpp':['astyle', 'clang-format', 'clangtidy', 'uncrustify'], 'java':['clang-format']}

" Enable indentLine
let g:indentLine_enabled = 1

" Use a vertical bar character for the indent guide (default is '|')
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

" Disable in terminal where colors don't render well (optional)
let g:indentLine_setColors = 0

" Turn off indentLine in certain file types (optional)
autocmd FileType markdown,help let b:indentLine_enabled=0

" Don’t show indent guides on blank lines (optional)
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_fileTypeExclude = ['text', 'markdown', 'help', 'terminal']

" For better compatibility with colorschemes (optional)
let g:indentLine_color_gui = '#528491'
let g:indentLine_color_term = 239

" Keep indentLine showing on blank lines (Vim workaround)
let g:indentLine_concealcursor = 'nc'
let g:indentLine_conceallevel = 2
let g:indentLine_showTrailingBlanklineIndent = 1


" ************************
"* Keyboard Bindings
" ************************
let mapleader = " "

" Always center the screen when using j and k
nnoremap j jzz
nnoremap k kzz

" Map leader q to quit
nnoremap <Leader>q :q<CR>

" Map leader w to save
nnoremap <Leader>w :w<CR>

" Map leader x to save quit
nnoremap <Leader>x :wq<CR>

" Map leader c to copy
vnoremap <Leader>c "+y<CR>

" Map leader C to copy and paste
nnoremap <Leader>C "+yyP<CR>

" Map leader Q to @ for macros
nnoremap Q @
vnoremap Q @

" Map leader spacebar to clear search highlights
nnoremap <Leader><space> :noh<CR>

" Map leader sh to horiz split
nnoremap <Leader>sh :split<CR>

" Map leader sv to horiz split
nnoremap <Leader>sv :vsplit<CR>

" Map Ctrl-h to move to left split
nnoremap <C-h> <C-w>h

" Map Ctrl-j to move to below split
nnoremap <C-j> <C-w>j

" Map Ctrl-k to move to above split
nnoremap <C-k> <C-w>k

" Map Ctrl-l to move to right split
nnoremap <C-l> <C-w>l

" Map leader tn to open new tab
nnoremap <Leader>tn :tabnew<CR>

" Prompt for filename and split it horizontally
nnoremap <Leader>fs :split <C-R>=input("File to open (horiz): ")<CR><CR>

" Prompt for filename and split it vertically
nnoremap <Leader>fv :vsplit <C-R>=input("File to open (vert): ")<CR><CR>

" Prompt for a file to open in a new tab
nnoremap <Leader>tn :tabnew <C-R>=input("File to open in new tab: ")<CR><CR>

" Map leader tk to go to next tab
nnoremap <Leader>tk :tabnext<CR>

" Map leader tj to go to previous tab
nnoremap <Leader>tj :tabprevious<CR>

" Map leader tf to go to first tab
nnoremap <Leader>tf :tabfirst<CR>

" Map leader tl to go to last tab
nnoremap <Leader>tl :tablast<CR>

" Map Control alt h to previous tab
nnoremap <C-M-h> :tabprevious<CR>

" Map Control alt l to next tab
nnoremap <C-M-l> :tabnext<CR>


" ************************
"* Set Colorscheme
" ************************
" Color scheme
colorscheme dracula
" colorscheme tokyonight
