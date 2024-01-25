" filetype detection + plugins + indents
filetype on
filetype plugin on
filetype indent plugin on

" syntax highlighting
syntax on

" hybrid line numbers
set number
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

" tab = 2 spaces
set shiftwidth=4
set tabstop=4
set softtabstop=2
set smarttab
" set expandtab

" ignore case when searching unless specifically capital
set ignorecase
set smartcase
set incsearch

" qol stuff
set showcmd
set showmode
set showmatch
set hlsearch

" autocompletion
set wildmenu
set wildmode=list:longest
