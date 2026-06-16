return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>cf",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        desc = "Format buffer",
      },
    },
    opts = {
      formatters_by_ft = {
        lua          = { "stylua" },
        ruby         = { "rubocop" },
        javascript   = { "prettier" },
        javascriptreact = { "prettier" },
        typescript   = { "prettier" },
        typescriptreact = { "prettier" },
        json         = { "prettier" },
        css          = { "prettier" },
        html         = { "prettier" },
        yaml         = { "prettier" },
      },
      format_on_save = {
        timeout_ms = 3000,
        lsp_fallback = true,
      },
    },
  },
}
