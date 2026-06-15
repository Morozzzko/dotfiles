return function() 
    require('mason').setup()
     local handlers = {
         -- The first entry (without a key) will be the default handler
         -- and will be called for each installed server that doesn't have
         -- a dedicated handler.
         function (server_name) -- default handler (optional)
             require("lspconfig")[server_name].setup {}
         end,
         -- Next, you can provide targeted overrides for specific servers.
         ["rust_analyzer"] = function ()
             require("rust-tools").setup {}
         end,
         ["lua_ls"] = function ()
             local lspconfig = require("lspconfig")
             lspconfig.lua_ls.setup {
                 settings = {
                     Lua = {
                         diagnostics = {
                             globals = { "vim" }
                         }
                     }
                 }
             }
         end,
     }
    require('mason-lspconfig').setup({
        handlers = handlers,
        ensure_installed = {
            -- 'lua_ls',
            -- 'ruby-lsp',
            -- 'ts',
            -- 'cssls',
            -- 'jsonls',
            -- 'yamlls',
            -- 'tailwindcss',
            -- 'gopls'
        },
        automatic_installation = true
    })
    vim.diagnostic.config({
      float = true
    })

    local lspconfig_defaults = require('lspconfig').util.default_config
    lspconfig_defaults.capabilities = vim.tbl_deep_extend(
      'force',
      lspconfig_defaults.capabilities,
      require('cmp_nvim_lsp').default_capabilities()
    )

    -- This is where you enable features that only work
    -- if there is a language server active in the file
    vim.api.nvim_create_autocmd('LspAttach', {
      desc = 'LSP actions',
      callback = function(event)
        local opts = {buffer = event.buf}

        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
        vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
        vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
        vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
        vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
      end,
    })

    local cmp = require('cmp')

    cmp.setup({
      sources = {
        {name = 'path'},
        {name = 'nvim_lsp', keyword_length = 2},
        {name = 'buffer', keyword_length = 3},
        {name = "copilot"},
        {name = 'luasnip', keyword_length = 3},
      },
      snippet = {
        expand = function(args)
          -- You need Neovim v0.10 to use vim.snippet
          vim.snippet.expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert(
          {
            ["<CR>"] = cmp.mapping.confirm({
              behavior = cmp.ConfirmBehavior.Replace,
              select = true,
            }),
          }
        )
    })
end
