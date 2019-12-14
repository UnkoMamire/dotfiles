" setting
" 文字コードをUFT-8に設定
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
" ファイル形式の検出
filetype plugin indent on
" Viと非互換にする
set nocompatible

" 見た目系
" 相対行番号を表示
set relativenumber
" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore
" シンタックス
syntax enable
" 括弧入力時の対応する括弧を表示
set showmatch
" コマンドラインの補完
set wildmenu
set wildmode=full

" Tab系
" 不可視文字を可視化
set list
set listchars=tab:»-,eol:↲,extends:»,precedes:«,nbsp:%
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

" コマンド系
" コマンド履歴のフィルタリングをできるようにする
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
" コマンド履歴の個数
set history=200

" ファイル名表示
set statusline=%F
" 変更チェック表示
set statusline+=%m
" 読み込み専用かどうか表示
set statusline+=%r
" ヘルプページなら[HELP]と表示
set statusline+=%h
" プレビューウインドウなら[Prevew]と表示
set statusline+=%w
" これ以降は右寄せ表示
set statusline+=%=
" file encoding
set statusline+=[ENC=%{&fileencoding}]
" 現在行数/全行数
set statusline+=[LOW=%l/%L]
" ステータスラインを常に表示(0:表示しない、1:2つ以上ウィンドウがある時だけ表示)
set laststatus=2

" バッファリストをノーマルモードで移動できるようにする
nnoremap <silent> [b :bprevious<CR> 
nnoremap <silent> ]b :bnext<CR> 
nnoremap <silent> [B :bfirst<CR> 
nnoremap <silent> ]B :blast<CR> 
" 引数リストをノーマルモードで移動できるようにする
nnoremap <silent> [a :previous<CR> 
nnoremap <silent> ]a :next<CR> 
nnoremap <silent> [A :first<CR> 
nnoremap <silent> ]A :last<CR> 

" 矩形ビジュアルモードで文字のないところにもカーソル移動
set virtualedit=block

" 選択した範囲のインデントサイズを連続して変更する
vnoremap < <gv
vnoremap > >gv

" アクティブなファイルが含まれているディレクトリを手早く展開
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" ペーストしたテキストを再選択
nnoremap <expr> gb '`[' . strpart(getregtype(), 0, 1) . '`]'
" SpaceキーをLeaderにする
let mapleader = "\<space>"

" デフォルトのプラグインを有効化
packadd justify

" QuickRun
let g:quickrun_config = {}

" Gundo
if has("python3")
	let g:gundo_prefer_python3 = 1
endif
let g:gundo_return_on_revert = 0
nnoremap <leader>u :GundoToggle<CR>

" vim-operator-swap
nmap <C-P><C-M> <Plug>(operator-swap-marking)
nmap <C-P><C-P> <Plug>(operator-swap)
vmap <C-P><C-M> <Plug>(operator-swap-marking)
vmap <C-P><C-P> <Plug>(operator-swap)

" vim-operator-search
nmap <leader>/ <Plug>(operator-search)
vmap <leader>/ <Plug>(operator-search)

" vim-operator-replace
nmap _ <Plug>(operator-replace)
vmap _ <Plug>(operator-replace)

" numberstar
nnoremap <expr>*  numberstar#key('*')
nnoremap <expr>#  numberstar#key('#')
nnoremap <expr>g* numberstar#key('g*')
nnoremap <expr>#* numberstar#key('#*')

" " jplus
" nmap J <Plug>(jplus)
" vmap J <Plug>(jplus)
" nmap <Leader>J <Plug>(jplus-getchar)
" vmap <Leader>J <Plug>(jplus-getchar)

" neosnippet
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory = "~/.config/nvim/snippets"
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" deoplete
if has('nvim')
	let g:deoplete#enable_at_startup = 1
	packadd deoplete.nvim
	autocmd VimEnter * call deoplete#custom#option('sources', {
				\ '_': [''],
				\ 'c': ['LanguageClient'],
				\ 'cpp': ['LanguageClient'],
				\ 'java': ['LanguageClient'],
				\ 'python': ['LanguageClient'],
				\})
endif

" LanguageClient-neovim
if has('nvim')
	packadd LanguageClient-neovim
	let g:LanguageClient_serverCommands = {
				\ 'c': ['clangd'],
				\ 'cpp': ['clangd'],
				\ 'java': ['jdtls'],
				\ 'python' : ['pyls']
				\ }

	function s:confforLC()
		" Rename - rn => rename
		noremap <leader>rn :call LanguageClient#textDocument_rename()<CR>
		" Rename - rc => rename camelCase
		noremap <leader>rc :call LanguageClient#textDocument_rename(
					\ {'newName': Abolish.camelcase(expand('<cword>'))})<CR>
		" Rename - rs => rename snake_case
		noremap <leader>rs :call LanguageClient#textDocument_rename(
					\ {'newName': Abolish.snakecase(expand('<cword>'))})<CR>
		" Rename - ru => rename UPPERCASE
		noremap <leader>ru :call LanguageClient#textDocument_rename(
					\ {'newName': Abolish.uppercase(expand('<cword>'))})<CR>
		" Hover
		nnoremap <Leader>lh :call LanguageClient_textDocument_hover()<CR>
		" 定義位置へジャンプ
		nnoremap <C-]> :call LanguageClient_textDocument_definition()<CR>
		" フォーマット
		nnoremap <silent> <Leader>x :call LanguageClient_textDocument_formatting()<CR>
		vnoremap <silent> <Leader>x :call LanguageClient_textDocument_rangeformatting()<CR>
		setlocal formatexpr=LanguageClient#textDocument_rangeFormatting_sync()
		" LanguageClient-vimが生きてる間は常時signcolumを有効に
		setlocal signcolumn=yes
		highlight SignColumn guibg=black ctermbg=black
	endfunction
	autocmd Filetype c,cpp,java,python :call s:confforLC()

endif
