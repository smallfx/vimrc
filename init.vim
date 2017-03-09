" python support
let g:python2_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

" dein setup
set runtimepath^=~/.config/nvim/dein/repos/github.com/Shougo/dein.vim/
if dein#load_state(expand('~/.cache/dein'))
	call dein#begin(expand('~/.cache/dein/'))

	" 'feature' packages
	call dein#add('Shougo/dein.vim')
	call dein#add('Shougo/unite.vim')
	call dein#add('Shougo/vimfiler.vim')
	call dein#add('Shougo/deoplete.nvim')
	call dein#add('neomake/neomake')
	call dein#add('tpope/vim-fugitive')
	call dein#add('itchyny/lightline.vim')
	call dein#add('bling/vim-bufferline')
	call dein#add('mileszs/ack.vim')
	call dein#add('embear/vim-localvimrc')
	call dein#add('qpkorr/vim-bufkill')
	call dein#add('t9md/vim-choosewin')
	call dein#add('justinmk/vim-sneak')
	call dein#add('editorconfig/editorconfig-vim')
	call dein#add('floobits/floobits-neovim')

	" color schemes
	call dein#add('mhartington/oceanic-next')
	call dein#add('tyrannicaltoucan/vim-deep-space')
	call dein#add('notpratheek/vim-luna')
	call dein#add('vim-scripts/oceandeep')
	call dein#add('itchyny/landscape.vim')

	" filetype stuff
	call dein#add('rust-lang/rust.vim')
	call dein#add('zah/nim.vim')
	call dein#add('toyamarinyon/vim-swift')
	call dein#add('mxw/vim-jsx')
	call dein#add('sheerun/vim-json')
	call dein#add('sheerun/yajs.vim')
	call dein#add('othree/html5.vim')
	call dein#add('jdonaldson/vaxe')
	call dein#add('tpope/vim-git')
	call dein#add('sudar/vim-arduino-syntax')
	call dein#add('neovimhaskell/haskell-vim')
	call dein#add('robotvert/vim-nginx')
	call dein#add('tpope/vim-markdown')
	call dein#add('groenewege/vim-less')
	call dein#add('vim-ruby/vim-ruby')
	call dein#add('leafgarland/typescript-vim')
	call dein#add('mitsuhiko/vim-python-combined')
	call dein#add('vim-perl/vim-perl')
	call dein#add('jrk/vim-ocaml')

	call dein#add('heavenshell/vim-jsdoc')

	call dein#end()
	call dein#save_state()
endif

" ~~~~~~~ basics ~~~~~~~
set noshowmode
set hidden
syntax on
set number
set backspace=indent,eol,start
set so=999 "center cursor
set nohlsearch
set smartcase
let g:BufKillVerbose = 0

" theme
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
colorscheme landscape
set background=dark

" whitespace
set tabstop=4
set shiftwidth=4
set softtabstop=4
filetype plugin indent on
set listchars=tab:▸\ ,eol:¬
set list

" ~~~~~ key remap ~~~~~
" space is leader
let mapleader = "\<Space>"
"
" chaelin clears last search highlight
"nnoremap <C-L> :noh<CR><C-L>:<backspace>

" move faster
nnoremap <c-j> 4j
nnoremap <c-k> 4k

" move between buffers
nnoremap <c-a> :bp<cr>
nnoremap <c-s> :bn<cr>

" bufkill
nnoremap <Leader>q :BD<CR>

" choosewin
nmap  -  <Plug>(choosewin)

" file tree view
map <silent> <C-n> :VimFiler<CR>

" " Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" " Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" ~~~~~~~ plug config ~~~~~~~~
"vimfiler
let g:vimfiler_as_default_explorer = 1

" deoplete on
let g:deoplete#enable_at_startup = 1

" neomake
autocmd! BufWritePost,BufEnter * Neomake
"let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_verbose = 0

"bufline
let g:bufferline_echo = 1
let g:bufferline_rotate = 2

"lightline
let g:lightline = {
    \'colorscheme': 'landscape',
    \'active': {
    \'left': [ [ 'mode', 'paste'],
    \   [ 'fugitive', 'filename' ] ]
    \},
    \'component_function': {
    \   'fugitive': 'LL_fugitive',
    \   'filename': 'LL_filename'
    \}
    \}

" ~~~~~~~~~ my funcs ~~~~~~~~
function! LL_fugitive()
  return exists('*fugitive#head') ? fugitive#head() : ''
endfunction

function! LL_filename()
    return fnamemodify(expand("%"), ":~:.")
endfunction
