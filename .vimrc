set hls
"编码模式，避免乱码
set fileencodings =utf-8,cp936,big5,latin1
set encoding      =utf-8
filetype on
filetype indent on
filetype plugin on
syntax on
set autoread
set paste
set confirm
set tabstop     =4
set softtabstop =4
set shiftwidth  =4
set expandtab
set autoindent
set history =100
set completeopt=menu,menuone,noselect
"搜索字符跳转时不循环，要么到底，要么到顶
set nowrapscan
"不自动换行
set nowrap
set noautochdir
set shortmess =aIt
"不要自动生成各种备份文件
set noswapfile
set nobackup
"一直显示底部状态栏,tab栏
set laststatus =2
set showtabline =0
set statusline=%t%m%r%h%w%=\ [%l\/%L:%v]
set scrolloff =1
set splitright
set splitbelow
set timeoutlen=150
"不同模式光标形状
" INSERT mode
let &t_SI = "\<Esc>[5 q" . "\<Esc>]12;green\x7"
" REPLACE mode
let &t_SR = "\<Esc>[3 q" . "\<Esc>]12;green\x7"
" NORMAL mode
let &t_EI = "\<Esc>[1 q" . "\<Esc>]12;green\x7"
if (has("termguicolors"))
 set termguicolors
endif
set linespace=0
set guifont=Fira\ Code:h12
execute pathogen#infect()
"----------------------------------netrw
let g:netrw_browse_split = 4  " 打开文件在一个新的窗口
let g:netrw_altv = 1          " 打开文件时使用竖向分割
let g:netrw_winsize = 25      " 设置窗口大小
let g:netrw_liststyle = 3     " 设置显示风格
let g:netrw_banner = 0        " 不显示顶部提示信息

"----------------------------------------colorscheme
set background =dark
colorscheme moonlight
let g:moonlight_terminal_italics=1
"----------------------------------------undotree
if has("persistent_undo")
  let target_path = expand('~/.undodir')
  if !isdirectory(target_path)
    call mkdir(target_path, "p", 0700)
  endif
  let &undodir=target_path
  set undofile
endif
let g:undotree_WindowLayout = 2
"----------------------------------------which-key
let g:mapleader = "\<Space>"
let g:maplocalleader = ','

nnoremap <silent> <Esc> :nohlsearch<cr>

let g:which_key_map = {}
let g:which_key_map = {
      \ 'e' : [':Lexplore'                     , 'netrw-toggle'],
      \ 'u' : [':UndotreeToggle'               , 'undotree-toggle'],
      \ 'j' : ['<C-W>j'                        , 'focus-down'],
      \ 'k' : ['<C-W>k'                        , 'focus-up'],
      \ 'h' : ['<C-W>h'                        , 'focus-left'],
      \ 'l' : ['<C-W>l'                        , 'focus-right'],
      \ 'J' : [':resize +5'                    , 'hight(+5)'],
      \ 'K' : [':resize -5'                    , 'hight(-5)'],
      \ 'H' : [':vertical resize -5'           , 'width(-5)'],
      \ 'L' : [':vertical resize +5'           , 'width(+5)'],
      \ }
call which_key#register('<Space>', "g:which_key_map")
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>

nnoremap <leader>1 :e ~/.vimrc<CR>
nnoremap <leader>2 :e ~/.config/wezterm/font.lua<CR>
nnoremap <leader>3 :e ~/.config/i3/config<CR>
let g:which_key_map.1 = 'which_key_ignore'
let g:which_key_map.2 = 'which_key_ignore'
let g:which_key_map.3 = 'which_key_ignore'

 
augroup MyAutoCmdGroup
  autocmd!
  "光标保持不动超过一段时间时，自动保存所有修改的文件。
  autocmd CursorHold,CursorHoldI * silent! wall
  "当重新聚焦 Vim 或切换到该缓冲区时，自动检查文件是否被外部更改，如果是，则重新加载文件。
  autocmd FocusGained,BufEnter * checktime
augroup END

