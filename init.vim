" for all that funny new stuff - plugins etc.
lua require('config')

" --- everlasting important things
" basics
>>>>>>> Stashed changes
syntax enable
set noshowmode
set hidden
set number
set backspace=indent,eol,start
set so=999 " center cursor
set nohlsearch
set smartcase
set signcolumn=number
" look
colorscheme landscape
set background=dark
" whitespace
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
filetype plugin indent on
set listchars=tab:▸\ ,eol:¬,trail:·
set list
hi NonText ctermfg=grey guifg=grey40
" keys
" space is leader
let mapleader = "\<Space>"
" move faster
nnoremap <c-j> 4j
nnoremap <c-k> 4k
" move between buffers
nnoremap <c-a> :bp<cr>
nnoremap <c-s> :bn<cr>
" copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+w
nnoremap  <leader>yy  "+yy
" paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P
" desensitize search case (allows easy case-sensitive search with 2 backspace)
nnoremap / /\c
nnoremap ? ?\c
" lightline
function! LspStatus()
	return luaeval('require("lsp-progress").progress()')
endfunction
let g:lightline = {
    \'colorscheme': 'landscape',
    \'active': {
    \'left': [ [ 'mode', 'paste'],
    \   [ 'fugitive', 'lspstatus', 'readonly', 'filename', 'modified' ] ]
    \},
    \'component_function': {
    \   'fugitive': 'FugitiveHead',
    \   'lspstatus': 'LspStatus'
    \}
    \}

" --- experimental maybe-non-permanent
" get rid of that tacky post-0.12 neovim intro logo
set shortmess+=I
" lsp-related
nnoremap gd :lua vim.lsp.buf.definition()<CR>
nnoremap gr :lua vim.lsp.buf.references()<CR>
nnoremap gt :lua vim.lsp.buf.type_definition()<CR>
nnoremap <leader>rn :lua vim.lsp.buf.rename()<CR>
" show error under cursor on space-e
map <leader>e :lua vim.diagnostic.open_float(0, {scope="line"})<CR>
" filer
" todo: replace netrw with vim-molder
map <C-n> :Ex<CR>
" grep
set grepprg=rg\ --vimgrep\ --glob\ !.git
function! Grep(...)
	return system(join([&grepprg] + [expandcmd(join(a:000, ' '))], ' '))
endfunction
map <C-g> :Grep<Space>
" quick-fix window (grep results) auto-open and auto-close (and just normal close on q)
augroup quickfix
	autocmd!
	autocmd QuickFixCmdPost cgetexpr cwindow
	autocmd QuickFixCmdPost lgetexpr lwindow
	autocmd FileType qf call s:quickfix_buf_config()
augroup END
function! s:quickfix_buf_config()
	nnoremap <buffer> q :cclose<CR>
	nnoremap <buffer> <CR> <CR>:cclose<CR>
endfunction
" file finder
set findfunc=Find
function! Find(arg, _)
	if empty(s:filescache)
	let s:filescache = globpath('.', '**', 1, 1)
	call filter(s:filescache, '!isdirectory(v:val)')
	call map(s:filescache, "fnamemodify(v:val, ':.')")
	endif
	return a:arg == '' ? s:filescache : matchfuzzy(s:filescache, a:arg)
endfunc
let s:filescache = []
autocmd CmdlineEnter : let s:filescache = []
map <silent> <C-p> :find<Space>
" auto-pum for file finder completions
autocmd CmdlineChanged : if getcmdline() =~ '^find ' | call wildtrigger() | endif
set wildmode=noselect:lastused,full
set wildoptions=pum
