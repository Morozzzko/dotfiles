return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      -- Better notifications (replaces vim.notify)
      notifier = {
        enabled = true,
        timeout = 3000,
      },
      -- Indent guides with scope highlighting
      indent = {
        enabled = true,
        animate = { enabled = false },
      },
      -- Highlight all occurrences of the word under cursor
      words = { enabled = true },
      -- Smooth scrolling
      scroll = { enabled = true },
      -- Nicer UI for vim.ui.input / vim.ui.select
      input = { enabled = true },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "catppuccin/nvim" },
    event = "VeryLazy",
    opts = {
      options = {
        theme = "catppuccin",
        globalstatus = true,
        disabled_filetypes = { statusline = { "neo-tree" } },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    },
  },
  {
    "folke/ts-comments.nvim",
    event = "VeryLazy",
    opts = {},
  },
}
