vim.lsp.config("ts_ls", {
  init_options = {
    preferences = {
      importModuleSpecifierPreference = "relative",
    },
  },
})
