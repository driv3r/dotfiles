set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'altercation/vim-colors-solarized'

Plugin 'tpope/vim-rails'
Plugin 'kchmck/vim-coffee-script'
Plugin 'elixir-lang/vim-elixir'
Plugin 'wting/rust.vim'

Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/syntastic'
Plugin 'ervandew/supertab'
Plugin 'ShowTrailingWhitespace'
Plugin 'DeleteTrailingWhitespace'
Plugin 'scrooloose/nerdtree'

Plugin 'bling/vim-airline'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this

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
set backupdir=~/.vimbackup,~/tmp

" DeleteTrailingWhitespace
" ------------------------------------------------------------------------------------------------
nnoremap <silent> <F5> :DeleteTrailingWhitespace<CR> " Remove all trailing whitespace by pressing F5
let g:DeleteTrailingWhitespace=1
let g:DeleteTrailingWhitespace_Action='delete'
let g:ShowTrailingWhitespace=1


" CTRL-P
" ------------------------------------------------------------------------------------------------
let g:ctrlp_map = '<c-t>'
let g:ctrlp_custom_ignore = {
  \ 'dir': '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\.pyc$\|\.pyo$\|\.rbc$|\.rbo$\|\.class$\|\.o$\|\~$\|\.beam$\',
  \ }


" Syntastic
" ------------------------------------------------------------------------------------------------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_auto_loc_list=1


" Syntastic
" ------------------------------------------------------------------------------------------------
map <C-n> :NERDTreeToggle<CR>


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


" Enable pasting from external applications like a web browser
" ------------------------------------------------------------------------------------------------
set pastetoggle=<F3>


" Others
" ------------------------------------------------------------------------------------------------
set ruler               " show row and column in footer
set scrolloff=2         " minimum lines above/below cursor
set laststatus=2        " always show status bar

set clipboard=unnamed   " use the system clipboard
set number                " Show line numbers
syntax on                 " Turn on syntax highlighting
set autoindent            " Indentation settings

set wildmenu
