call jetpack#begin()
Jetpack 'neovim/nvim-lspconfig'
Jetpack 'williamboman/nvim-lsp-installer'
Jetpack 'ray-x/lsp_signature.nvim'
Jetpack 'hrsh7th/nvim-cmp'
Jetpack 'hrsh7th/cmp-nvim-lsp'
Jetpack 'hrsh7th/cmp-buffer'
Jetpack 'hrsh7th/cmp-path'
Jetpack 'hrsh7th/cmp-cmdline'
Jetpack 'onsails/lspkind-nvim'
Jetpack 'ray-x/cmp-treesitter'
Jetpack 'hrsh7th/cmp-vsnip'
Jetpack 'hrsh7th/vim-vsnip'
Jetpack 'folke/lsp-colors.nvim' " LSPハイライト
Jetpack 'nvim-telescope/telescope.nvim'
Jetpack 'nvim-lualine/lualine.nvim' " ステータスライン
Jetpack 'cohama/lexima.vim' " 閉じ括弧
Jetpack 'pepo-le/win-ime-con.nvim' " モード変更時にIME状態を自動で切り替える
Jetpack 'skanehira/translate.vim' " :translateで翻訳
Jetpack 'yuttie/comfortable-motion.vim' " スムーズなスクロール
Jetpack 'bronson/vim-trailing-whitespace' " 末尾の無駄なスペースをハイライト
Jetpack 'Shougo/defx.nvim' " ファイラ
Jetpack 'nvim-treesitter/nvim-treesitter' " nvim-treesitterのインターフェース
Jetpack 'sharkdp/fd' " ファイルシステム内のエントリを検索する
Jetpack 'nvim-lua/plenary.nvim' " lua関数
Jetpack 'BurntSushi/ripgrep' " 現在の検索を再帰的に検索する行指向の検索ツール
Jetpack 'zefei/vim-wintabs' " バッファをタブラインに表示
Jetpack 'ray-x/lsp_signature.nvim' " シグネチャを表示
call jetpack#end()


" -----------------------------------------------------
" LSP Config
lua << EOF

local nvim_lsp = require('lspconfig')
-- local servers = {
--   'gopls'
-- }
-- for _, lsp in ipairs(servers) do
--   nvim_lsp[lsp].setup {
--     capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
--     flags = {
--       debounce_text_changes = 150,
--     }
--   }
-- end

-- require'lspconfig'.volar.setup{}

EOF

" nnoremap <silent>gD <cmd>lua vim.lsp.buf.declaration()<CR>
" nnoremap <silent>gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent>gh <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent>gH <cmd>lua vim.lsp.buf.signature_help()<CR>
" nnoremap <silent>gi <cmd>lua vim.lsp.buf.implementation()<CR>
" nnoremap <silent><space>wa <cmd>lua vim.lsp.buf.add_workspace_folder()<CR>
" nnoremap <silent><space>wr <cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>
" nnoremap <silent><space>wl <cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>
" nnoremap <silent><space>D <cmd>lua vim.lsp.buf.type_definition()<CR>
" nnoremap <silent><space>rn <cmd>lua vim.lsp.buf.rename()<CR>
" nnoremap <silent><space>ca <cmd>lua vim.lsp.buf.code_action()<CR>
" nnoremap <silent>gf <cmd>lua vim.lsp.buf.references()<CR>
" nnoremap <silent><space>e <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
nnoremap <silent>[d <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent>]d <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
" nnoremap <silent><space>q <cmd>lua vim.lsp.diagnostic.set_loclist()<CR>
" nnoremap <silent><space>f <cmd>lua vim.lsp.buf.formatting()<CR>

" -----------------------------------------------------
" LSP Installer
lua << EOF

local server_configs = {
  ["gopls"] = {
  }
}

local lsp_installer = require("nvim-lsp-installer")

lsp_installer.on_server_ready(function(server)
    local opts = {}

    -- (optional) Customize the options passed to the server
    -- if server.name == "tsserver" then
    --     opts.root_dir = function() ... end
    -- end

    if server_configs[server.name] then
      opts = vim.tbl_deep_extend('force', opts, server_configs[server.name])
    end

    opts.capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

    -- This setup() function is exactly the same as lspconfig's setup function (:help lspconfig-quickstart)
    server:setup(opts)
    vim.cmd [[ do User LspAttachBuffers ]]
end)

EOF

" -----------------------------------------------------
" nvim cmp
lua << EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'
  local lspkind = require('lspkind')

  cmp.setup({
    preselect = cmp.PreselectMode.None,
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` user.
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<C-k>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = {
      { name = 'nvim_lsp' },
      { name = 'vsnip' },

      { name = 'buffer' },
      { name = 'path' },
      { name = 'treesitter' },
    },
    formatting = {
      format = lspkind.cmp_format({
        mode = 'symbol',
        maxwidth = 50, 
        before = function (entry, vim_item)
          return vim_item
        end
      })
    }
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

EOF

" -----------------------------------------------------
"  vim-vsnip
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

" -----------------------------------------------------
" lspkind.nvim
lua << EOF
require('lspkind').init({
    -- DEPRECATED (use mode instead): enables text annotations
    --
    -- default: true
    -- with_text = true,

    -- defines how annotations are shown
    -- default: symbol
    -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
    mode = 'symbol_text',

    -- default symbol map
    -- can be either 'default' (requires nerd-fonts font) or
    -- 'codicons' for codicon preset (requires vscode-codicons font)
    --
    -- default: 'default'
    preset = 'codicons',

    -- override preset symbols
    --
    -- default: {}
    symbol_map = {
      Text = "",
      Method = "",
      Function = "",
      Constructor = "",
      Field = "ﰠ",
      Variable = "",
      Class = "ﴯ",
      Interface = "",
      Module = "",
      Property = "ﰠ",
      Unit = "塞",
      Value = "",
      Enum = "",
      Keyword = "",
      Snippet = "",
      Color = "",
      File = "",
      Reference = "",
      Folder = "",
      EnumMember = "",
      Constant = "",
      Struct = "פּ",
      Event = "",
      Operator = "",
      TypeParameter = ""
    },
})
EOF

" -----------------------------------------------------
" lsp-colors.nvim

lua << EOF
require("lsp-colors").setup({
  Error = "#db4b4b",
  Warning = "#e0af68",
  Information = "#0db9d7",
  Hint = "#10B981"
})
EOF

" -----------------------------------------------------
" telescope.nvim
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" -----------------------------------------------------
" lualine.nvim

lua << EOF
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}
EOF

" -----------------------------------------------------
"  nvim-ts-autotag

lua << EOF
local filetypes = {
    'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'svelte', 'vue', 'tsx', 'jsx', 'rescript',
    'xml',
    'php',
    'markdown',
    'glimmer','handlebars','hbs'
}
local skip_tags = {
  'area', 'base', 'br', 'col', 'command', 'embed', 'hr', 'img', 'slot',
  'input', 'keygen', 'link', 'meta', 'param', 'source', 'track', 'wbr','menuitem'
}
EOF


" -----------------------------------------------------
"  defx
nnoremap <silent> <Leader>f :<C-u> Defx <CR>
" kidoujireiauto
call defx#custom#option('_', {
      \ 'winwidth': 40,
      \ 'split': 'vertical',
      \ 'direction': 'topleft',
      \ 'show_ignored_files': 1,
      \ 'buffer_name': 'exlorer',
      \ 'toggle': 1,
      \ 'resume': 1,
      \ })
      
autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
  " Define mappings
  nnoremap <silent><buffer><expr> <CR>
  \ defx#do_action('open')
  nnoremap <silent><buffer><expr> c
  \ defx#do_action('copy')
  nnoremap <silent><buffer><expr> m
  \ defx#do_action('move')
  nnoremap <silent><buffer><expr> p
  \ defx#do_action('paste')
  nnoremap <silent><buffer><expr> l
  \ defx#do_action('open')
  nnoremap <silent><buffer><expr> E
  \ defx#do_action('open', 'vsplit')
  nnoremap <silent><buffer><expr> P
  \ defx#do_action('preview')
  nnoremap <silent><buffer><expr> o
  \ defx#do_action('open_tree', 'toggle')
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


  
" -----------------------------------------------------
" vim-wintabs 
map <C-H> <Plug>(wintabs_previous)
map <C-L> <Plug>(wintabs_next)
map <C-T>c <Plug>(wintabs_close)
map <C-T>u <Plug>(wintabs_undo)
map <C-T>o <Plug>(wintabs_only)
map <C-W>c <Plug>(wintabs_close_window)
map <C-W>o <Plug>(wintabs_only_window)
command! Tabc WintabsCloseVimtab
command! Tabo WintabsOnlyVimtab
