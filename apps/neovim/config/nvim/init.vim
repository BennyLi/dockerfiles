" Plugins
call plug#begin('~/.local/share/nvim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Dev plugins
Plug 'editorconfig/editorconfig-vim'
Plug 'vim-syntastic/syntastic'
Plug 'airblade/vim-gitgutter'

" Syntax Plugins
Plug 'ekalinin/Dockerfile.vim'
Plug 'chrisbra/Colorizer'
Plug 'leafgarland/typescript-vim'

" Note-Taking Plugins
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

call plug#end()

source ~/.config/nvim/vim-nerdtree-config.vim
source ~/.config/nvim/vim-airline-config.vim
source ~/.config/nvim/vim-ctrlp-config.vim


" Editor settings
:set expandtab
:set tabstop=2
:set shiftwidth=2

:set number

" Enable mouse support
:set mouse=a
