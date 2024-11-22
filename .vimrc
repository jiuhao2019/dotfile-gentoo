let mapleader = " "
let maplocalleader = ","
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
set timeoutlen=1000
set showcmd
"不同模式光标形状,颜色
let &t_SI = "\<Esc>[2 q" . "\<Esc>]12;green\x7"    " insert mode
let &t_SR = "\<Esc>[2 q" . "\<Esc>]12;red\x7"    " replace mode
let &t_EI = "\<Esc>[2 q" . "\<Esc>]12;c0caf5\x7"    " normal mode
autocmd VimLeave * silent !echo -ne "\033[0 q\033]12;white\x7"  " 退出vim恢复默认光标颜色样式

if (has("termguicolors"))
 set termguicolors
endif
set linespace=0
"set guifont=Fira\ Code:h12
execute pathogen#infect()
"----------------------------------netrw
let g:netrw_browse_split = 4  " 打开文件在一个新的窗口
let g:netrw_altv = 1          " 打开文件时使用竖向分割
let g:netrw_winsize = 25      " 设置窗口大小
let g:netrw_liststyle = 0     " 设置显示风格
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
"-------------------------------------------------------
augroup MyAutoCmdGroup
  autocmd!
  autocmd CursorHold,CursorHoldI * silent! wall   "光标保持不动超过一段时间时，自动保存所有修改的文件。
  autocmd FocusGained,BufEnter * checktime        "当重新聚焦 Vim 或切换到该缓冲区时，自动检查文件是否被外部更改，如果是，则重新加载文件。
augroup END
"-----------------------------------------------diff enhanced
if has("patch-8.1.0360")
    set diffopt+=internal,algorithm:patience
endif
"How can I enable the patience diff algorithm when starting as vimdiff / git difftool / ... ?
"In that case, add this snippet to your .vimrc:
" started In Diff-Mode set diffexpr (plugin not loaded yet)
if &diff
    let &diffexpr='EnhancedDiff#Diff("git diff", "--diff-algorithm=patience")'
endif

function! CmdDirDiffTree()
    " 提示分别输入2个文件夹()
    let one_folder = input('Enter one folder: ')
    let another_folder = input('Enter another folder: ')
    execute 'DirDiffTree ' . one_folder ' '. another_folder
endfunction

"---------------------------------------------------keybinding
nnoremap <silent> <Esc> :nohlsearch<CR>
nnoremap <Leader>e :Lexplore<CR> 
nnoremap <Leader>u :UndotreeToggle<CR> 
vnoremap <Leader>l :Linediff<CR> 
nnoremap <Leader>L :LinediffReset<CR> 
nnoremap <Leader>1 :e ~/.vimrc<CR>
nnoremap <Leader>2 :e ~/.config/wezterm/font.lua<CR>
nnoremap <Leader>3 :e ~/.config/i3/config<CR>
nnoremap <Leader>4 :e ~/.emacs.d/init.el<CR>
" used by DirDiffTree
nmap <buffer> <silent> <Down> <C-N>o
nmap <buffer> <silent> <Up>   <C-P>o
nnoremap <Leader>d :call CmdDirDiffTree<CR> 
