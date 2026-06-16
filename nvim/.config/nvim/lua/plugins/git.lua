return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      signs = {
        add          = { text = "▎" },
        change       = { text = "▎" },
        delete       = { text = "" },
        topdelete    = { text = "" },
        changedelete = { text = "▎" },
        untracked    = { text = "▎" },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns
        local map = vim.keymap.set
        local opts = { buffer = buffer }

        map("n", "]h", function() gs.nav_hunk("next") end, opts)
        map("n", "[h", function() gs.nav_hunk("prev") end, opts)
        map("n", "<leader>hs", gs.stage_hunk, opts)
        map("n", "<leader>hr", gs.reset_hunk, opts)
        map("v", "<leader>hs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, opts)
        map("v", "<leader>hr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, opts)
        map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, opts)
        map("n", "<leader>hd", gs.diffthis, opts)
        map("n", "<leader>hp", gs.preview_hunk, opts)
      end,
    },
  },
  {
    "akinsho/git-conflict.nvim",
    event = "BufReadPost",
    opts = {
      default_mappings = true,
      disable_diagnostics = true,
    },
  },
  { "Morozzzko/git_browse.nvim" },
}
