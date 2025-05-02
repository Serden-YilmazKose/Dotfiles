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
"* Set Colorscheme
" ************************
" Color scheme
colorscheme dracula
" colorscheme tokyonight
