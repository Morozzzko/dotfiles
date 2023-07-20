return function()
  local lsp = require('lsp-zero')
  lsp.preset('recommended', {
    manage_nvim_cmp = true,
  })

  lsp.ensure_installed({
    'tsserver',
    'eslint',
    'rubocop',
    'solargraph',
    'vimls',
    'html',
  })

  vim.diagnostic.config({
    float = true
  })

  local cmp = require('cmp')

  lsp.setup_nvim_cmp({
    sources = {
      { name = "copilot" },
      {name = 'path'},
      {name = 'nvim_lsp', keyword_length = 2},
      {name = 'buffer', keyword_length = 3},
      {name = 'luasnip', keyword_length = 3},
    },
    mapping = lsp.defaults.cmp_mappings({
      ["<CR>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      }),
    })
  })

  lsp.format_on_save({
    format_opts = {
      async = false,
      timeout_ms = 3000,
    },
    servers = {
      ['rubocop'] = {'ruby'},
      -- if you have a working setup with null-ls
      -- you can specify filetypes it can format.
      -- ['null-ls'] = {'javascript', 'typescript'},
    }
  })

  lsp.setup()
end
