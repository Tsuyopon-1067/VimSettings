"文字コードをUFT-8に設定
set fenc=utf-8
" バックアップファイルを作らない
set nobackup
" スワップファイルを作らない
set noswapfile
" 編集中のファイルが変更されたら自動で読み直す
set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden
" 入力中のコマンドをステータスに表示する
set showcmd

" 行番号を表示
set number
" 現在の行を強調表示
set cursorline
" 現在の行を強調表示（縦）
set cursorcolumn
" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore
" インデントはスマートインデント
set smartindent
" 括弧入力時の対応する括弧を表示
set showmatch
" ステータスラインを常に表示
set laststatus=2
" コマンドラインの補完
set wildmode=list:longest
" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk
" シンタックスハイライトの有効化
syntax enable


" Tab系
" 不可視文字を可視化(タブが「▸-」と表示される)
set list listchars=tab:\▸\-
" 行頭以外のTab文字の表示幅（スペースいくつ分）
set tabstop=4
" 行頭でのTab文字の表示幅
set shiftwidth=4

" 検索系
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライト表示
set hlsearch
" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>
inoremap jk <ESC>
" 折りたたみ
"set foldmethod=indent
"--------------------------------------------------------------------------
" カラースキーム
colorscheme molokaiCG
set t_Co=256
set background=light
colorscheme solarized " solarizedPublic/vim-colors

highlight Normal ctermbg=NONE guibg=NONE
highlight NonText ctermbg=NONE guibg=NONE
highlight LineNr ctermbg=NONE guibg=NONE
highlight Folded ctermbg=NONE guibg=NONE
highlight EndOfBuffer ctermbg=NONE guibg=NONE

hi TabLineSel guifg=NONE guibg=NONE guisp=NONE gui=bold ctermfg=10 ctermbg=NONE cterm=bold
hi TabLine guifg=NONE guibg=NONE guisp=NONE gui=bold ctermfg=8 ctermbg=14 cterm=bold


"--------------------------------------------------------------------------
" クリップボード
"set clipboard=unnamedplus
set clipboard=unnamed,unnamedplus
set clipboard+=unnamedplus
" sudo apt-get install xsel

"--------------------------------------------------------------------------
" 全コピー
nmap cy :%y<Enter>

"--------------------------------------------------------------------------
" 囲む
nmap cq dwi"<ESC>p

"--------------------------------------------------------------------------
" Tab
set expandtab
set tabstop=4
set shiftwidth=4



augroup fileTypeIndent
    autocmd!
    autocmd BufNewFile,BufRead *.py setlocal tabstop=4 softtabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.py set noexpandtab 
    autocmd BufNewFile,BufRead *.rb setlocal tabstop=2 softtabstop=2 shiftwidth=2noexpandtab
    autocmd BufNewFile,BufRead *.rb set noexpandtab 
augroup END



"--------------------------------------------------------------------------
" 言語
autocmd BufReadPost *.kt setlocal filetype=kotlin
