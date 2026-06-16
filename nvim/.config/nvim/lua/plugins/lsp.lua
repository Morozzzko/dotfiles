return {
  {
    "williamboman/mason.nvim",
    opts = {
      ui = { border = "rounded" },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "lua_ls",
        "ruby_lsp",
        "ts_ls",
        "cssls",
        "jsonls",
        "tailwindcss",
      },
      automatic_enable = true,
    },
    config = function(_, opts)
      -- Load per-server configs from lua/lsp/*.lua before mason-lspconfig enables them
      local lsp_dir = vim.fn.stdpath("config") .. "/lua/lsp"
      for _, file in ipairs(vim.fn.readdir(lsp_dir)) do
        local server = file:match("^(.+)%.lua$")
        if server then
          require("lsp." .. server)
        end
      end
      require("mason-lspconfig").setup(opts)
    end,
  },
  {
    -- Provides default server configurations consumed by vim.lsp.config
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    config = function()
      vim.diagnostic.config({
        virtual_text = { prefix = "●" },
        signs = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          focusable = true,
          border = "rounded",
          source = true,
        },
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp_keymaps", { clear = true }),
        callback = function(event)
          local opts = { buffer = event.buf, silent = true }
          local map = vim.keymap.set

          map("n", "K", vim.lsp.buf.hover, opts)
          map("n", "gd", vim.lsp.buf.definition, opts)
          map("n", "gD", vim.lsp.buf.declaration, opts)
          map("n", "gi", vim.lsp.buf.implementation, opts)
          map("n", "go", vim.lsp.buf.type_definition, opts)
          map("n", "gr", vim.lsp.buf.references, opts)
          map("n", "gs", vim.lsp.buf.signature_help, opts)
          map("n", "<leader>rn", vim.lsp.buf.rename, opts)
          map({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, opts)
          map("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, opts)
          map("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, opts)
          map("n", "<leader>cd", vim.diagnostic.open_float, opts)
        end,
      })
    end,
  },
}
