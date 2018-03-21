" auto-install vim-plug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim')) 
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
  \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync
endif

call plug#begin('~/.config/nvim/plugged')

" Swift syntax highlighting
Plug 'https://github.com/keith/swift.vim.git'
" Nerdtree (file directory browser)
Plug 'https://github.com/scrooloose/nerdtree.git'
" Bracket and quote completion
Plug 'https://github.com/tpope/vim-surround.git'
" Completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Git integration
Plug 'https://github.com/tpope/vim-fugitive.git'
" GitHub integration w/ above
Plug 'https://github.com/tpope/vim-rhubarb.git'
" Git diff integration
Plug 'airblade/vim-gitgutter'
" Swift completion (not clear if it's working)
Plug 'mitsuse/autocomplete-swift'
" Python autocomplete
Plug 'zchee/deoplete-jedi'
" Go-lang completion (erroring out....)
Plug 'zchee/deoplete-go', { 'do': 'make'}
Plug 'nsf/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }
Plug 'fatih/vim-go' " May conflict w/ deoplete-go
" Better markdown support 
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
" FZF (through Homebrew)
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
" Airline status bar below
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" ALE Linting for Go, Swift, etc
Plug 'w0rp/ale'

" Themes
Plug 'whatyouhide/vim-gotham'
Plug 'https://github.com/rakr/vim-one.git'
Plug 'dracula/vim'
Plug 'iCyMind/NeoSolarized'
Plug 'nightsense/vimspectr'
Plug 'mhartington/oceanic-next'

call plug#end()

" ############ TMUX COLOR SUPPORT #################

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

if (has("termguicolors"))
  set termguicolors
endif

" ###### MARKDOWN SETTINGS #############

let g:vim_markdown_folding_disabled = 1
set conceallevel=2
autocmd FileType markdown setlocal indentexpr=
autocmd FileType markdown setlocal ts=4 sw=4 sts=0 expandtab " probably unneeded

" ############ THEMING #################

set background=dark " for the dark version
colorscheme one
let g:airline_theme='one'

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" ########## GENERAL SETTINGS ###########

" Line numbers
set number
" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Map NERDTreeToggle to ctrl n
map <C-n> :NERDTreeToggle<CR>
" Turn off GitGutter by default
" Enable w/ :GitGutterToggle
let g:gitgutter_enabled = 0
" Map C-s to FZF command (showing files in current working dir by default)
map <C-s> :FZF<CR>
" Enable CursorLine
set cursorline
" Default Colors for CursorLine
highlight  CursorLine ctermbg=White ctermfg=Black
" Change Color when entering Insert Mode
autocmd InsertEnter * highlight  CursorLine ctermbg=Black ctermfg=None
" Revert Color to default when leaving Insert Mode
autocmd InsertLeave * highlight  CursorLine ctermbg=White ctermfg=Black
" Turns off annoying behavior of auto-inserting comments
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" Show matching brackets
set showmatch
" Use macOS pasteboard
set clipboard=unnamed
" Fixes cursor 
set guicursor=

" ########### Proper tabs ###############
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent
set expandtab       " tabs are space
set autoindent
set copyindent      " copy indent from the previous line

" ########### ALE SETTINGS ###############
" Error and warning signs.
let g:ale_sign_error = '⤫'
"let g:ale_sign_warning = '-'

" ########## AIRLINE SETTINGS ###########

let g:airline#extensions#branch#enabled = 1
" Enables powerline for airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#whitespace#show_message = 0

" ############ Swift Settings ###############

" Makes sure Swift files are recognized as such
autocmd BufNewFile,BufRead *.swift set filetype=swift

" ############ Golang Settings ##############

let g:ale_linters = {'go': ['gofmt', 'gotype', 'govet']}

" ############ AUTOCOMPLETE #################

" Enable Deoplete
let g:deoplete#enable_at_startup = 1
" Use smartcase.
let g:deoplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:deoplete#sources#syntax#min_keyword_length = 2

" Golang deoplete settings
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode' " May be incorrect
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']

