local bind = vim.keymap.set
local opts = { silent = true, noremap = true }
local opts_remap = { silent = true }

-- Create windows if they don't exist
WinMove = function (key)
  local initial_window = vim.api.nvim_call_function('winnr', {})
  vim.api.nvim_command("wincmd " .. key)

  local current_window = vim.api.nvim_call_function('winnr', {})

  if current_window == initial_window then
    if key == 'j' or key == 'k' then
      vim.api.nvim_command("wincmd s")
    else
      vim.api.nvim_command("wincmd v")
    end
    vim.api.nvim_command("wincmd " .. key)
  end
end


bind("", "<C-h>", "<cmd>lua WinMove('h')<cr>", opts_remap)
bind("", "<C-j>", "<cmd>lua WinMove('j')<cr>", opts_remap)
bind("", "<C-k>", "<cmd>lua WinMove('k')<cr>", opts_remap)
bind("", "<C-l>", "<cmd>lua WinMove('l')<cr>", opts_remap)


-- Neotree
bind('n', '<leader><leader>', ':Neotree toggle<CR>')
bind('n', '<CR>', ':Neotree reveal<CR>')
bind('n', '<C-n>', ':NvimTreeFindFile<CR>')


-- Use "displayed" lines instead of real lines. Use wrapped lines
bind('n', 'j', 'gj', opts)
bind('n', 'k', 'gk', opts)
bind('n', '<Down>', 'gj', opts)
bind('n', '<Up>', 'gk', opts)

-- buffers
bind('n', '<leader>b', ':Neotree action=focus source=buffers position=bottom<CR>', opts)

local builtin = require('telescope.builtin')
bind('n', '<leader>ff', builtin.find_files, opts)
bind('n', '<leader>fa', builtin.live_grep, opts)
bind('n', '<leader>fh', builtin.help_tags, opts)

bind('n', '<leader>yl', '0vg_y', opts)


vim.keymap.set({ "n", "x" }, "<leader>fr", function() require("ssr").open() end)

bind('n', 'ff', ':LspZeroFormat!<CR>', opts)

bind('n', '<leader>cp', ":let @+=expand('%p')<cr>", opts)
bind('n', '<leader>yp', ":let @+=expand('%p')<cr>", opts)
