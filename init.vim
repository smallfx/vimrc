" python support
let g:python_host_prog = system('echo -n $(which python2)')
let g:python3_host_prog = system('echo -n $(which python3)')

" ~~~~~ key remap ~~~~~
" space is leader
let mapleader = "\<Space>"

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
map <silent> <C-n> :Defx `expand('%:p:h')` -search=`expand('%:p')`<CR>

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

" lightline
let g:lightline = {
    \'colorscheme': 'landscape',
    \'active': {
    \'left': [ [ 'mode', 'paste'],
    \   [ 'fugitive', 'cocstatus', 'readonly', 'filename', 'modified' ] ]
    \},
    \'component_function': {
    \   'fugitive': 'FugitiveHead',
    \   'cocstatus': 'coc#status'
    \}
    \}

lua <<EOF
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    {
      "vhyrro/luarocks.nvim",
      priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
      config = true,
    },
    {
      "saghen/blink.cmp",
      -- Use latest release tag pre-built binaries.
      version = "v1.*",
      -- `opts` is optional.
      opts = {
        completion = {
          documentation = {
            -- Automatically show the documentation window when selecting a completion item.
            auto_show = true,
          },
        }
      }
    },
    {
      "neovim/nvim-lspconfig",
      dependencies = {
        "saghen/blink.cmp",
      },
    },
    {
      "pmizio/typescript-tools.nvim",
      dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
      config = function()
        require("typescript-tools").setup({})
      end
    },
    {
      "folke/snacks.nvim",
      keys = {
        { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto definition." },
        { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
        { "gt", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto Type Definition" },
      },
    },
    {
      "nvim-treesitter/nvim-treesitter",
      -- Specify for lazy the main module to use for config() and opts().
      -- Required as lazy can not figure this out for treesitter automatically.
      main = "nvim-treesitter.configs",
      opts = {
        highlight = {
          -- Enable the sytax highlighting module. All modules are disabled by default.
          enable = true,
        },
        indent = {
          enable = true,
        },
        ensure_installed = {
          "css",
          "html",
          "javascript",
          "scss",
          "tsx",
          "typescript",
          "lua"
        },
        -- Automatically install missing parsers when entering buffer.
        auto_install = true,
        ignore_install = {"phpdoc"}
      },
      -- Lazy will execute this on install or update of the plugin.
      -- This updates parsers when the plugin is updated or installed.
      build = ":TSUpdate"
    },
    -- 'feature' packages
    "Shougo/denite.nvim",
    "Shougo/defx.nvim",
    "tpope/vim-fugitive",
    "itchyny/lightline.vim",
    "embear/vim-localvimrc",
    "qpkorr/vim-bufkill",
    "t9md/vim-choosewin",
    "tpope/vim-surround",
    -- color schemes
    "mhartington/oceanic-next",
    "tyrannicaltoucan/vim-deep-space",
    "notpratheek/vim-luna",
    "vim-scripts/oceandeep",
    "itchyny/landscape.vim",
    "ayu-theme/ayu-vim",
    "NLKNguyen/papercolor-theme",
    "rakr/vim-one",
    "ajmwagar/vim-deus",
    "olimorris/onedarkpro.nvim"
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "landscape" } },
  -- automatically check for plugin updates
  checker = { enabled = false }
})
EOF

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
set signcolumn=number

" theme
colorscheme landscape
set background=dark

" whitespace
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround
filetype plugin indent on
set listchars=tab:▸\ ,eol:¬,trail:·
set list
hi NonText ctermfg=grey guifg=grey40

" map <space>e :lua vim.diagnostic.open_float(0, {scope="line"})<CR>

" ~~~~ defx stuff ~~~~
autocmd BufEnter,VimEnter,BufNew,BufWinEnter,BufRead,BufCreate
        \ * if isdirectory(expand('<amatch>'))
        \   | call s:browse_check(expand('<amatch>')) | endif

  function! s:browse_check(path) abort
    if bufnr('%') != expand('<abuf>')
      return
    endif

    " Disable netrw.
    augroup FileExplorer
      autocmd!
    augroup END

    execute 'Defx' a:path
  endfunction

" ~~~~~ denite stuff ~~~~~
try
" Use ripgrep for searching current directory for files
" By default, ripgrep will respect rules in .gitignore
"   --files: Print each file that would be searched (but don't search)
"   --glob:  Include or exclues files for searching that match the given glob
"            (aka ignore .git files)
"
call denite#custom#var('file/rec', 'command', ['rg', '--files', '--glob', '!.git'])

" Use ripgrep in place of "grep"
call denite#custom#var('grep', 'command', ['rg'])

" Custom options for ripgrep
"   --vimgrep:  Show results with every match on it's own line
"   --hidden:   Search hidden directories and files
"   --heading:  Show the file name above clusters of matches from each file
"   --S:        Search case insensitively if the pattern is all lowercase
call denite#custom#var('grep', 'default_opts', ['--hidden', '--vimgrep', '--heading', '-S'])

" Recommended defaults for ripgrep via Denite docs
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

" Remove date from buffer list
call denite#custom#var('buffer', 'date_format', '')

let s:denite_options = {'default' : {
\ 'split': 'floating',
\ 'start_filter': 1,
\ 'auto_resize': 1,
\ 'source_names': 'short',
\ 'prompt': 'λ ',
\ 'highlight_matched_char': 'QuickFixLine',
\ 'highlight_matched_range': 'Visual',
\ 'highlight_window_background': 'Visual',
\ 'highlight_filter_background': 'DiffAdd',
\ 'winrow': 1,
\ 'vertical_preview': 1
\ }}

" Loop through denite options and enable them
function! s:profile(opts) abort
  for l:fname in keys(a:opts)
    for l:dopt in keys(a:opts[l:fname])
      call denite#custom#option(l:fname, l:dopt, a:opts[l:fname][l:dopt])
    endfor
  endfor
endfunction

call s:profile(s:denite_options)
catch
  echo 'Denite not installed. It should work after running :PlugInstall'
endtry


" denite
map <C-p> :DeniteProjectDir file/rec<CR>
map <C-g> :<C-u>Denite grep:. -no-empty<CR>
nnoremap <leader>j :<C-u>DeniteCursorWord grep:.<CR>
nnoremap <silent> <leader>b :Denite buffer<CR>
nnoremap <silent> <leader>l :Denite line<CR>
nnoremap <silent> <leader>c :Denite -auto-action=preview colorscheme<CR>

autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> <C-v>
  \ denite#do_map('do_action', 'vsplit')
  nnoremap <silent><buffer><expr> <C-h>
  \ denite#do_map('do_action', 'split')
  nnoremap <silent><buffer><expr> d
  \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space>
  \ denite#do_map('toggle_select').'j'
endfunction

" defx
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

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  "autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
