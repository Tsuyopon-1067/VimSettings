"NeoBundle から dein.vim に乗り換えたら爆速だった話
" vimrc に以下のように追記

" プラグインがインストールされるディレクトリ
" dein.vim settings {{{
" install dir {{{
let s:dein_dir = expand('~/.config/nvim/dein/')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
" }}}

" dein.vim がなければ github から落としてくる
" dein installation check {{{
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . s:dein_repo_dir
endif
" }}}

" begin settings {{{

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
" }}}

" 未インストールものものがあったらインストール
" plugin installation check {{{
if dein#check_install()
  call dein#install()
endif
" }}}

" 未アンインストールものものがあったらアンインストール
" plugin remove check {{{
let s:removed_plugins = dein#check_clean()
if len(s:removed_plugins) > 0
  call map(s:removed_plugins, "delete(v:val, 'rf')")
  call dein#recache_runtimepath()
endif
" }}}


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

highlight Normal ctermbg=NONE guibg=NONE
highlight NonText ctermbg=NONE guibg=NONE
highlight LineNr ctermbg=NONE guibg=NONE
highlight Folded ctermbg=NONE guibg=NONE
highlight EndOfBuffer ctermbg=NONE guibg=NONE


"--------------------------------------------------------------------------
" クリップボード
"set clipboard=unnamedplus
set clipboard=unnamed,unnamedplus

"--------------------------------------------------------------------------
" 全コピー
nmap cy :%y<Enter>

"--------------------------------------------------------------------------
" 囲む
nmap cq dwi"<ESC>p

"--------------------------------------------------------------------------
" ターミナル

function MakeTerm() abort
    split
    wincmd j
    resize 20
    terminal
endfunction
function FirstTerm() abort
    let l:kaku = expand('%:e')
    if (kaku == 'cpp' || kaku == 'java' || kaku == 'py')
        call MakeTerm()
    endif
endfunction
command! -nargs=* T w | :call MakeTerm() | :call feedkeys("i")
tnoremap <c-t><c-t> <C-¥><C-n><C-w><C-w>


if has('vim_starting')
    call FirstTerm()
endif
function RunTerm() abort
    echo(mode())
endfunction

"--------------------------------------------------------------------------
" 自動コンパイル
autocmd BufEnter *.cpp nnoremap <expr> <F5> '<C-w>jig++ -O0 -o ' . expand("%:r") . '.out ' . expand("%:p") . '<CR> ./' .expand("%:r") . '.out <CR>'
autocmd BufEnter *.cpp nnoremap <expr> <F5> '<C-w>jig++ -O0 -o ' . expand("%:r") . '.out ' . expand("%:p") . '<CR> ./' .expand("%:r") . '.out <CR>'
autocmd BufEnter *.cpp nnoremap <expr> <F6> '<C-w>jig++ -O0 -o ' . expand("%:r") . '.out ' . expand("%:p") . '<CR>'
autocmd BufEnter *.java nnoremap <expr> <F5> '<C-w>jijavac ' . expand("%:p") . '<CR> java ' .expand("%:r") . ' <CR>'
autocmd BufEnter *.java nnoremap <expr> <F6> '<C-w>jijavac ' . expand("%:p") . '<CR>'
autocmd BufEnter *.py nnoremap <expr> <F5> '<C-w>jipython3 ' . expand("%:p") . '<CR>'

"--------------------------------------------------------------------------
" Tab
set expandtab
set tabstop=4
set shiftwidth=4


filetype plugin indent on

augroup fileTypeIndent
    autocmd!
    autocmd BufNewFile,BufRead *.py setlocal tabstop=4 softtabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.py set noexpandtab 
    autocmd BufNewFile,BufRead *.rb setlocal tabstop=2 softtabstop=2 shiftwidth=2noexpandtab
    autocmd BufNewFile,BufRead *.rb set noexpandtab 
augroup END

filetype plugin indent on


"--------------------------------------------------------------------------
" 言語
autocmd BufReadPost *.kt setlocal filetype=kotlin

"--------------------------------------------------------------------------
" previm ブラウザ指定
let g:previm_open_cmd = 'open -a firefox'
autocmd BufRead,BufNewFile *.md nnoremap <Leader>a :<C-u> PrevimOpen <CR>
autocmd FileType defx call s:defx_my_settings()

"--------------------------------------------------------------------------
" defx.nvim キーバインド
function! s:defx_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
   \ defx#do_action('drop')
  nnoremap <silent><buffer><expr> c
  \ defx#do_action('copy')
  nnoremap <silent><buffer><expr> m
  \ defx#do_action('move')
  nnoremap <silent><buffer><expr> p
  \ defx#do_action('paste')
  nnoremap <silent><buffer><expr> l
  \ defx#do_action('drop')
  nnoremap <silent><buffer><expr> t
  \ defx#do_action('open','tabnew')
  nnoremap <silent><buffer><expr> E
  \ defx#do_action('drop', 'vsplit')
  nnoremap <silent><buffer><expr> P
  \ defx#do_action('drop', 'pedit')
  nnoremap <silent><buffer><expr> o
  \ defx#do_action('open_or_close_tree')
  nnoremap <silent><buffer><expr> K
  \ defx#do_action('new_directory')
  nnoremap <silent><buffer><expr> N
  \ defx#do_action('new_file')
  nnoremap <silent><buffer><expr> M
  \ defx#do_action('new_multiple_files')
  nnoremap <silent><buffer><expr> C
  \ defx#do_action('toggle_columns',
  \                'mark:indent:icon:filename:type:size:time')
  nnoremap <silent><buffer><expr> S
  \ defx#do_action('toggle_sort', 'time')
  nnoremap <silent><buffer><expr> d
  \ defx#do_action('remove')
  nnoremap <silent><buffer><expr> r
  \ defx#do_action('rename')
  nnoremap <silent><buffer><expr> !
  \ defx#do_action('execute_command')
  nnoremap <silent><buffer><expr> x
  \ defx#do_action('execute_system')
  nnoremap <silent><buffer><expr> yy
  \ defx#do_action('yank_path')
  nnoremap <silent><buffer><expr> .
  \ defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> ;
  \ defx#do_action('repeat')
  nnoremap <silent><buffer><expr> h
  \ defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> ~
  \ defx#do_action('cd')
  nnoremap <silent><buffer><expr> q
  \ defx#do_action('quit')
  nnoremap <silent><buffer><expr> <Space>
  \ defx#do_action('toggle_select') . 'j'
  nnoremap <silent><buffer><expr> *
  \ defx#do_action('toggle_select_all')
  nnoremap <silent><buffer><expr> j
  \ line('.') == line('$') ? 'gg' : 'j'
  nnoremap <silent><buffer><expr> k
  \ line('.') == 1 ? 'G' : 'k'
  nnoremap <silent><buffer><expr> <C-l>
  \ defx#do_action('redraw')
  nnoremap <silent><buffer><expr> <C-g>
  \ defx#do_action('print')
  nnoremap <silent><buffer><expr> cd
  \ defx#do_action('change_vim_cwd')
endfunction

" vim起動時に起動、<Leader>fで起動
nnoremap <silent> <Leader>f :<C-u> Defx <CR>

" 起動時のレイアウトや設定
call defx#custom#option('_', {
      \ 'winwidth': 24,
      \ 'split': 'vertical',
      \ 'direction': 'topleft',
      \ 'show_ignored_files': 1,
      \ 'buffer_name': 'exlorer',
      \ 'toggle': 1,
      \ 'resume': 1,
      \ })
