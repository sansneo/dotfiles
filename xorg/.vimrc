set autoread 
set backspace=indent,eol,start 
set clipboard=unnamedplus 
set encoding=utf-8 
set expandtab smarttab tabstop=4 shiftwidth=4
set guicursor=n-v-c-i:block 
set ignorecase hlsearch incsearch
set mouse=a
set nobackup nowritebackup noswapfile 
set noerrorbells novisualbell 
set nofoldenable 
set notimeout updatetime=100
set nowrap
set number scrolloff=10
set splitbelow splitright 

" Undo
set undodir=~/.undo 
let undo_dir = '~/.undo' 
if !isdirectory(undo_dir) 
    call mkdir(expand(undo_dir), 'p') 
endif 
set undofile

" Swap
set directory=~/.vim/swap//
if !isdirectory(expand('~/.vim/swap'))
  silent! call mkdir(expand('~/.vim/swap'), 'p', 0700)
endif
set swapfile
set shortmess+=s

" Netrw
let g:netrw_banner = 0 
let g:netrw_keepdir = 0 
let g:netrw_browser_split = 4
let g:netrw_liststyle = 3
let g:netrw_winsize = 21

" Filetype
filetype plugin indent on

" Make <C-c> act like <Esc>
inoremap <C-c> <Esc>

" Repeating commands in visual mode
vnoremap . :normal .<CR>

" Clear selections
nnoremap <C-l> :nohlsearch<CR>

" Behave like C$ and V$
nnoremap Y y$

" Command mode navigation
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>

" Really fucking saving
cnoremap <C-w> w !sudo tee % >/dev/null

" Behave like tmux
nnoremap <C-w>c :enew<CR>
nnoremap <C-w>x :close<CR>

" Explore
nnoremap <C-e> :Lex<CR>

" Plugins
let data_dir = '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'airblade/vim-matchquote'
Plug 'wellle/targets.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'machakann/vim-sandwich'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-obsession'
Plug 'vim-airline/vim-airline'
Plug 'vimwiki/vimwiki'
" Languages
Plug 'fatih/vim-go'
" Themes override default
Plug 'sainnhe/gruvbox-material'
Plug 'embark-theme/vim'
Plug 'sainnhe/everforest'
Plug 'tomasiser/vim-code-dark'
call plug#end()

let g:ctrlp_show_hidden = 1
let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)

" Showing opened buffers in airline
function! AirlineBuffersList()
  let all_buffers = filter(range(1, bufnr('$')), 'buflisted(v:val)')
  let current_buf = bufnr('%')
  let other_buffers = filter(copy(all_buffers), 'v:val != current_buf')
  let current_name = bufname(current_buf)
  if empty(current_name)
    let current_name = '[missing]'
  else
    let current_name = fnamemodify(current_name, ':t')
  endif
  let buffer_list = [current_name]
  for buf in other_buffers
    let name = bufname(buf)
    if empty(name)
      let name = '[missing]'
    else
      let name = fnamemodify(name, ':t')
    endif
    call add(buffer_list, name)
  endfor
  return join(buffer_list, ' | ')
endfunction
let g:airline_powerline_fonts = 0
let g:airline_symbols_ascii = 1
let g:airline_section_c = '%<%m %{AirlineBuffersList()}'  " Shows: "filename [+] current | buf2 | buf3..."
let g:airline_section_z = '%p%% ln:%l/%L col:%v'
let g:airline_extensions = ['ctrlp', 'obsession']

" Wiki
nnoremap <C-w>i :VimwikiIndex<CR>
nnoremap <C-w>I :VimwikiIndex<CR>
nnoremap <C-w><C-i> :VimwikiIndex<CR>

" CtrlP
nnoremap <C-n> :CtrlPBuffer<CR>

" Colorscheme
syntax on
set termguicolors
set background=dark
colorscheme gruvbox-material
hi Normal guibg=NONE ctermbg=NONE

" Colored Vimwiki headers
augroup VimwikiHeaders
  autocmd!
  autocmd ColorScheme * hi VimwikiHeader1 guifg=#ea6962 gui=bold cterm=bold
  autocmd ColorScheme * hi VimwikiHeader2 guifg=#7daea3 gui=bold cterm=bold
  autocmd ColorScheme * hi VimwikiHeader3 guifg=#d3869b gui=bold cterm=bold
  autocmd ColorScheme * hi VimwikiHeader4 guifg=#89b482 gui=bold cterm=bold
  autocmd ColorScheme * hi VimwikiHeader5 guifg=#e78a4e gui=bold cterm=bold
  autocmd ColorScheme * hi VimwikiHeader6 guifg=#ffffff gui=bold cterm=bold
augroup END

" Colored Markdown headers
augroup MarkdownHeaders
  autocmd!
  autocmd ColorScheme * hi markdownH1 guifg=#ea6962 gui=bold cterm=bold
  autocmd ColorScheme * hi markdownH1 guifg=#ea6962 gui=bold cterm=bold
  autocmd ColorScheme * hi markdownH2 guifg=#7daea3 gui=bold cterm=bold
  autocmd ColorScheme * hi markdownH3 guifg=#d3869b gui=bold cterm=bold
  autocmd ColorScheme * hi markdownH4 guifg=#89b482 gui=bold cterm=bold
  autocmd ColorScheme * hi markdownH5 guifg=#e78a4e gui=bold cterm=bold
  autocmd ColorScheme * hi markdownH6 guifg=#ffffff gui=bold cterm=bold
augroup END

if system('uname -r') =~ "Microsoft"
  augroup Yank
    autocmd!
    autocmd TextYankPost * :call system('/mnt/c/windows/system32/clip.exe ',@")
  augroup END
endif
