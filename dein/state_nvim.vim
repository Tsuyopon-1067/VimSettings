if g:dein#_cache_version !=# 410 || g:dein#_init_runtimepath !=# '/home/tsuyopon/.config/nvim,/etc/xdg/xdg-plasma/nvim,/etc/xdg/nvim,/usr/share/kubuntu-default-settings/kf5-settings/nvim,/home/tsuyopon/.local/share/nvim/site,/usr/share/plasma/nvim/site,/usr/local/share/nvim/site,/usr/share/nvim/site,/usr/share/nvim/runtime,/usr/lib/nvim,/usr/share/nvim/site/after,/usr/local/share/nvim/site/after,/usr/share/plasma/nvim/site/after,/home/tsuyopon/.local/share/nvim/site/after,/usr/share/kubuntu-default-settings/kf5-settings/nvim/after,/etc/xdg/nvim/after,/etc/xdg/xdg-plasma/nvim/after,/home/tsuyopon/.config/nvim/after,/home/tsuyopon/.cache/dein/repos/github.com/Shougo/dein.vim' | throw 'Cache loading error' | endif
let [s:plugins, s:ftplugin] = dein#min#_load_cache_raw(['/home/tsuyopon/.config/nvim/init.vim', '/home/tsuyopon/.config/nvim/dein_lazy.toml'])
if empty(s:plugins) | throw 'Cache loading error' | endif
let g:dein#_plugins = s:plugins
let g:dein#_ftplugin = s:ftplugin
let g:dein#_base_path = '/home/tsuyopon/.config/nvim/dein'
let g:dein#_runtime_path = '/home/tsuyopon/.cache/dein/.cache/init.vim/.dein'
let g:dein#_cache_path = '/home/tsuyopon/.cache/dein/.cache/init.vim'
let g:dein#_on_lua_plugins = {}
let &runtimepath = '/home/tsuyopon/.config/nvim,/etc/xdg/xdg-plasma/nvim,/etc/xdg/nvim,/usr/share/kubuntu-default-settings/kf5-settings/nvim,/home/tsuyopon/.local/share/nvim/site,/usr/share/plasma/nvim/site,/usr/local/share/nvim/site,/usr/share/nvim/site,/home/tsuyopon/.cache/dein/repos/github.com/Shougo/dein.vim,/home/tsuyopon/.cache/dein/.cache/init.vim/.dein,/usr/share/nvim/runtime,/home/tsuyopon/.cache/dein/.cache/init.vim/.dein/after,/usr/lib/nvim,/usr/share/nvim/site/after,/usr/local/share/nvim/site/after,/usr/share/plasma/nvim/site/after,/home/tsuyopon/.local/share/nvim/site/after,/usr/share/kubuntu-default-settings/kf5-settings/nvim/after,/etc/xdg/nvim/after,/etc/xdg/xdg-plasma/nvim/after,/home/tsuyopon/.config/nvim/after'
filetype off
 imap <expr> <C-l> vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-j>'
 smap <expr> <C-l> vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-j>'
 imap <expr> <C-k> vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<C-f>'
 smap <expr> <C-k> vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<C-f>'
 imap <expr> <C-j> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-b>'
 smap <expr> <C-j> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-b>'
 let g:vsnip_filetypes = {}
 let g:vsnip_snippet_dir = expand('~/.config/nvim/snippets')
 let g:vsnip_sync_delay = 0
 let g:vsnip_choice_delay = 0
 
 nnoremap <silent> <Leader>. :<C-u>FZFFileList<CR>
 nnoremap <silent> <Leader>, :<C-u>FZFMru<CR>
 nnoremap <silent> <Leader>l :<C-u>Lines<CR>
 nnoremap <silent> <Leader>b :<C-u>Buffers<CR>
 nnoremap <silent> <Leader>k :<C-u>Rg<CR>
 command! FZFFileList call fzf#run({ 'source': 'rg --files --hidden', 'sink': 'e', 'options': '-m --border=none', 'down': '20%'})
 command! FZFMru call fzf#run({ 'source': v:oldfiles, 'sink': 'e', 'options': '-m +s --border=none', 'down':  '20%'})
 let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'border': 'none' } }
 augroup vimrc_fzf
 autocmd!
 autocmd FileType fzf tnoremap <silent> <buffer> <Esc> <C-g>
 autocmd FileType fzf set laststatus=0 noshowmode noruler| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler
 augroup END
 function! RipgrepFzf(query, fullscreen)
    let command_fmt = 'rg --column --hiddden --line-number --no-heading --color=always --smart-case %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
 endfunction
 command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
autocmd dein-events InsertEnter * call dein#autoload#_on_event("InsertEnter", ['ddc.vim', 'vim-vsnip'])
autocmd dein-events BufEnter * call dein#autoload#_on_event("BufEnter", ['nvim-lspconfig'])
