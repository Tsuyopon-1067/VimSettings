"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/home/tsuyopon/.config/nvim/dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin('/home/tsuyopon/.config/nvim/dein')

" Let dein manage dein
" Required:
call dein#add('/home/tsuyopon/.config/nvim/dein/repos/github.com/Shougo/dein.vim')

" Add or remove your plugins here like this:
"call dein#add('Shougo/neosnippet.vim')
"call dein#add('Shougo/neosnippet-snippets')

" Required:
call dein#end()

" Required:
filetype plugin indent on
syntax enable

"End dein Scripts-------------------------


"NeoBundle から dein.vim に乗り換えたら爆速だった話
" vimrc に以下のように追記

" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.config/nvim/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " プラグインリストを収めた TOML ファイル
  " 予め TOML ファイル（後述）を用意しておく
  let g:rc_dir    = expand('~/.config/nvim')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " 設定終了
  call dein#end()
  call dein#save_state()
endif

" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif

"--------------------------------------------------------------------------
" 始めにやるsetting
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


" 見た目系
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

"--------------------------------------------------------------------------
" カラースキーム
colorscheme molokaiCG
set t_Co=256


"--------------------------------------------------------------------------
" クリップボード
set clipboard=unnamedplus


"--------------------------------------------------------------------------
" ビルド
nmap <C-i> :call ExcuteMain()<CR>

function! ExcuteMain()
	:w
	if expand("%:e") == 'c'
		:!gcc % -o %:r.out
		:!./%:r.out
	elseif expand("%:e") == 'cpp'
		!g++ % -o %:r.out
		!./%:r.out
	elseif expand("%:e") == 'java'
		:!javac %
		:!java %:r
	elseif expand("%:e") == 'py'
		:!python3 %
	elseif expand("%:e") == 'rb'
		:!ruby %
	endif
endfunction

command! Getsh :!cp ~/.config/nvim/excute.sh excute.sh
"--------------------------------------------------------------------------
" 全コピー
nmap cy :%y<Enter>

"--------------------------------------------------------------------------
" 囲む
nmap cq dwi"<ESC>p

"--------------------------------------------------------------------------
"補完
" 補完表示時のEnterで改行をしない
inoremap <expr><CR>  pumvisible() ? "<C-y>" : "<CR>"

set completeopt=menuone,noinsert
inoremap <expr><C-n> pumvisible() ? "<Down>" : "<C-n>"
inoremap <expr><C-p> pumvisible() ? "<Up>" : "<C-p>"
"補完候補選択時は<TAB>で候補移動snipppet時は<TAB>で次の入力先へ
imap <expr><TAB> pumvisible() ? "\<C-N>" : neosnippet#jumpable() ?  "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#jumpable() ?  "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"

"--------------------------------------------------------------------------
"独自スニペット
let g:neosnippet#snippets_directory='~/.config/nvim/snippets/'

"--------------------------------------------------------------------------
" Quickrun
silent! nmap <Space>r <Plug>(quickrun)


highlight Normal ctermbg=none
highlight NonText ctermbg=none
highlight LineNr ctermbg=none
highlight Folded ctermbg=none
highlight EndOfBuffer ctermbg=none


"--------------------------------------------------------------------------
" LaTeX
let g:tex_flavor = "latex"
let maplocalleader=' '
let g:tex_conceal=''

"--------------------------------------------------------------------------
" ターミナル

command! -nargs=* F split | wincmd j | resize 20 | terminal <args>
command! -nargs=* T split | wincmd j | resize 20 | terminal <args>
tnoremap <c-t><c-t> <C-¥><C-n><C-w><C-w>

"--------------------------------------------------------------------------
" Tab
set expandtab
set tabstop=4
set shiftwidth=4


filetype plugin indent on