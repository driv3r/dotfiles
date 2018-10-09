set nocompatible              " be iMproved, required

" Install vim-plug first
"
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"

" Specify a directory for plugins
" " - For Neovim: ~/.local/share/nvim/plugged
" " - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'altercation/vim-colors-solarized'

Plug 'sheerun/vim-polyglot'
" Plug 'tpope/vim-rails'

Plug 'mhinz/vim-mix-format'

Plug 'w0rp/ale'
Plug 'airblade/vim-gitgutter'
Plug 'ervandew/supertab'
Plug 'vim-scripts/ShowTrailingWhitespace'
Plug 'vim-scripts/DeleteTrailingWhitespace'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'itchyny/lightline.vim'

call plug#end()            " required

" bump up colors number
" ------------------------------------------------------------------------------------------------
set t_Co=256

" Solarized theme config
" ------------------------------------------------------------------------------------------------
let g:solarized_termcolors=256
let g:solarized_termtrans=1

syntax enable
set background=light
colorscheme solarized


" Tab == 2 soft spaces
" ------------------------------------------------------------------------------------------------
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2


" Set Buckup directory
set backupdir=$HOME/.vim/backup
set directory=$HOME/.vim/backup

" DeleteTrailingWhitespace
" ------------------------------------------------------------------------------------------------
" nnoremap <silent> <F5> :DeleteTrailingWhitespace<CR> " Remove all trailing whitespace by pressing F5
let g:DeleteTrailingWhitespace=1
let g:DeleteTrailingWhitespace_Action='delete'
let g:ShowTrailingWhitespace=1

" mix-elixir-format
" ------------------------------------------------------------------------------------------------
" let g:mix_format_on_save = 1

" FzF
" ------------------------------------------------------------------------------------------------
nmap ; :Buffers<CR>
nmap <Leader>p :Files<CR>
nmap <Leader>r :Tags<CR>

" ALE
" let g:ale_lint_on_text_changed = 'never'
let g:ale_enabled = 1
let g:ale_sign_warning = '▲'
let g:ale_sign_error = '✗'
highlight link ALEWarningSign String
highlight link ALEErrorSign Title

" Lightline
let g:lightline = {
\ 'colorscheme': 'solarized',
\ 'active': {
\   'left': [['mode', 'paste'], ['filename', 'modified']],
\   'right': [['lineinfo'], ['percent'], ['readonly', 'linter_warnings', 'linter_errors', 'linter_ok']]
\ },
\ 'component_expand': {
\   'linter_warnings': 'LightlineLinterWarnings',
\   'linter_errors': 'LightlineLinterErrors',
\   'linter_ok': 'LightlineLinterOK'
\ },
\ 'component_type': {
\   'readonly': 'error',
\   'linter_warnings': 'warning',
\   'linter_errors': 'error'
\ },
\ }

function! LightlineLinterWarnings() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ◆', all_non_errors)
endfunction

function! LightlineLinterErrors() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ✗', all_errors)
endfunction

function! LightlineLinterOK() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '✓ ' : ''
endfunction

autocmd User ALELint call s:MaybeUpdateLightline()

" Update and show lightline but only if it's visible (e.g., not in Goyo)
function! s:MaybeUpdateLightline()
  if exists('#lightline')
    call lightline#update()
  end
endfunction

" Nerd Tree
" ------------------------------------------------------------------------------------------------
map <C-n> :NERDTreeToggle<CR>

" GitGutter
let g:gitgutter_sign_added = '∙'
let g:gitgutter_sign_modified = '∙'
let g:gitgutter_sign_removed = '∙'
let g:gitgutter_sign_modified_removed = '∙'

" TAB NAVIGATION
" ------------------------------------------------------------------------------------------------
noremap <silent> <A-H> :execute 'sileqt! tabmove ' . (tabpagenr()-2)<CR>
noremap <silent> <A-L> :execute 'silent! tabmove ' . tabpagenr()<CR>

map <A-S-Left> gT
map <A-S-Right> gt


" Search
" ------------------------------------------------------------------------------------------------
set showmatch
set hlsearch            " highlight all search matches
set smartcase           " pay attention to case when caps are used
set incsearch           " show search results as I type

let $FZF_DEFAULT_COMMAND = 'ag -g ""'

" Enable pasting from external applications like a web browser
" ------------------------------------------------------------------------------------------------
set pastetoggle=<F3>


" Others
" ------------------------------------------------------------------------------------------------
set ruler               " show row and column in footer
set scrolloff=2         " minimum lines above/below cursor
set laststatus=2        " always show status bar

set clipboard=unnamed   " use the system clipboard
set number              " Show line numbers
syntax on               " Turn on syntax highlighting
set autoindent          " Indentation settings

set wildmenu

" Remap annoying crap
" ------------------------------------------------------------------------------------------------
ca WQ wq
ca Wq wq
ca W w
ca Q q
ca Tabe tabe

" let g:elm_format_autosave = 1
