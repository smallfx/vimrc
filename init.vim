" python support
let g:python2_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

" dein setup
set runtimepath^=~/.config/nvim/dein/repos/github.com/Shougo/dein.vim/
if dein#load_state(expand('~/.config/nvim/dein'))
  call dein#begin(expand('~/.config/nvim/dein/'))

  " 'feature' packages
  call dein#add('Shougo/dein.vim')
  call dein#add('haya14busa/dein-command.vim')
  call dein#add('Shougo/unite.vim')
  call dein#add('Shougo/vimproc', {'build' : 'make'})
  call dein#add('rstacruz/vim-fastunite')
  call dein#add('Shougo/neomru.vim')
  call dein#add('Shougo/defx.nvim')
  call dein#add('tpope/vim-fugitive')
  call dein#add('itchyny/lightline.vim')
  call dein#add('embear/vim-localvimrc')
  call dein#add('qpkorr/vim-bufkill')
  call dein#add('t9md/vim-choosewin')
  call dein#add('justinmk/vim-sneak')
  call dein#add('editorconfig/editorconfig-vim')
  call dein#add('tpope/vim-surround')
  call dein#add('w0rp/ale')

  " color schemes
  call dein#add('mhartington/oceanic-next')
  call dein#add('tyrannicaltoucan/vim-deep-space')
  call dein#add('notpratheek/vim-luna')
  call dein#add('vim-scripts/oceandeep')
  call dein#add('itchyny/landscape.vim')
  call dein#add('ayu-theme/ayu-vim')

  " filetype stuff
  call dein#add('elixir-lang/vim-elixir')
  call dein#add('reasonml-editor/vim-reason-plus')
  call dein#add('rust-lang/rust.vim')
  call dein#add('zah/nim.vim')
  call dein#add('toyamarinyon/vim-swift')
  call dein#add('neoclide/vim-jsx-improve')
  call dein#add('mxw/vim-jsx')
  call dein#add('sheerun/vim-json')
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
if (has("termguicolors"))
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif
syntax enable
set noshowmode
set hidden
set number
set backspace=indent,eol,start
set so=999 "center cursor
set nohlsearch
set smartcase
let g:BufKillVerbose = 0

" always show error gutter
let g:ale_sign_column_always = 1

" theme
set background="dark"
colorscheme luna

" whitespace
set tabstop=2
set shiftwidth=0
set softtabstop=-1
set shiftround
set expandtab
filetype plugin indent on
set listchars=tab:▸\ ,eol:¬,trail:·
set list

" ~~~~~ key remap ~~~~~
" space is leader
let mapleader = "\<Space>"

" unite fastsearch
map <C-p> [unite]p
map <C-g> [unite]g

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
map <silent> <C-n> :Defx<CR>

" copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" desensitize search case
nnoremap / /\c
nnoremap ? ?\c

" ~~~~~~~ plug config ~~~~~~~~
" ale
let g:ale_fixers = {
\   'javascript': ['eslint'],
\}
let g:ale_linters = {
\   'javascript': ['eslint'],
\}

" vimfiler
let g:vimfiler_as_default_explorer = 1

" lightline
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



" defx Config: start -----------------

autocmd FileType defx call s:defx_my_settings()
    function! s:defx_my_settings() abort
     " Define mappings
      nnoremap <silent><buffer><expr> <CR>
     \ defx#do_action('open')
      nnoremap <silent><buffer><expr> c
     \ defx#do_action('copy')
      nnoremap <silent><buffer><expr> m
     \ defx#do_action('move')
      nnoremap <silent><buffer><expr> p
     \ defx#do_action('paste')
      nnoremap <silent><buffer><expr> l
     \ defx#do_action('open')
      nnoremap <silent><buffer><expr> E
     \ defx#do_action('open', 'vsplit')
      nnoremap <silent><buffer><expr> P
     \ defx#do_action('open', 'pedit')
      nnoremap <silent><buffer><expr> K
     \ defx#do_action('new_directory')
      nnoremap <silent><buffer><expr> N
     \ defx#do_action('new_file')
      nnoremap <silent><buffer><expr> d
     \ defx#do_action('remove')
      nnoremap <silent><buffer><expr> r
     \ defx#do_action('rename')
      nnoremap <silent><buffer><expr> x
     \ defx#do_action('execute_system')
      nnoremap <silent><buffer><expr> yy
     \ defx#do_action('yank_path')
      nnoremap <silent><buffer><expr> .
     \ defx#do_action('toggle_ignored_files')
      nnoremap <silent><buffer><expr> h
     \ defx#do_action('cd', ['..'])
      nnoremap <silent><buffer><expr> <BS>
     \ defx#do_action('cd', ['..'])
      nnoremap <silent><buffer><expr> ~
     \ defx#do_action('cd')
      nnoremap <silent><buffer><expr> q
     \ defx#do_action('quit')
      nnoremap <silent><buffer><expr> <Space>
     \ defx#do_action('toggle_select') . 'j'
      nnoremap <silent><buffer><expr> *
     \ defx#do_action('toggle_select_all')
      nnoremap <silent><buffer><expr> j
     \ line('.') == line('$') ? 'gg' : 'j'
      nnoremap <silent><buffer><expr> k
     \ line('.') == 1 ? 'G' : 'k'
      nnoremap <silent><buffer><expr> <C-l>
     \ defx#do_action('redraw')
      nnoremap <silent><buffer><expr> <C-g>
     \ defx#do_action('print')
      nnoremap <silent><buffer><expr> cd
     \ defx#do_action('change_vim_cwd')
    endfunction

" defx Config: end -------------------
