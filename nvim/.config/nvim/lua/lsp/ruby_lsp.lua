vim.lsp.config("ruby_lsp", {
  init_options = {
    formatter = "rubocop",
    linters = { "rubocop" },
  },
})
