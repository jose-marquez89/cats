" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2019 Jan 26
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings, bail
" out.

" Set splits
set splitbelow
set splitright

" Set encoding to utf8
set encoding=utf-8

"define BadWhitespace before using in a match
highlight BadWhitespace ctermbg=red guibg=red

" Flag unnecessary whitespace
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" Python pep8 standards
au BufNewFile,BufRead *.py
    \ set fileformat=unix |
    \ set encoding=utf-8 |
    \ set textwidth=79
" Web code settings
au BufNewFile,BufRead *.html,*.css
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2
" C-family settings
au BufNewFile,BufRead *.c,*.cpp
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4

" Code folding
set foldmethod=indent
set foldlevel=99
nnoremap <space> za

" Stuff for Vundle
set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)

" Add simply fold plugin
Plugin 'tmhedberg/SimpylFold'

" Add pep8
Plugin 'nvie/vim-flake8'

" Color schemes
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'
Plugin 'joshdick/onedark.vim'

" File tree plugin
Plugin 'scrooloose/nerdtree'

" Auto-Complete
Bundle 'Valloric/YouCompleteMe'
" ...

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Add completion for C-family languages
let g:ycm_clangd_binary_path = "/usr/bin/clangd-9"

" Add customizations for YouCompleteMe
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>



if has('gui_running')
  set background=dark
  colorscheme solarized
  set guifont=Ubuntu\ Mono\ Regular\ 13
else
  colorscheme zenburn
endif

" start with line numbers
set number


if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

" This was originally backing up files. I haven't figured out a good
" workaround and things get really cluttered this way. When I find a 
" good workaround I'll start using backups and maybe even persistent_undo
"if has("vms")
"  set nobackup		" do not keep a backup file, use versions instead
"else
"  set backup		" keep a backup file (restore to previous version)
"  if has('persistent_undo')
"    set undofile	" keep an undo file (undo changes after closing)
"  endif
"endif

" Set backup files to be written to backup dir
"set backupdir=./.backup,.,/tmp
"set directory=.,./.backup,/tmp

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
augroup END

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

"python with virtualenv support
" tried to get this to work but it failed
" py3 << EOF
" import os
" import subprocess
" if 'VIRTUAL_ENV' in os.environ:
"   project_base_dir = os.environ['VIRTUAL_ENV']
"   subprocess.Popen(["/bin/bash", #"source", #"bin/activate"], shell=True)
" EOF
