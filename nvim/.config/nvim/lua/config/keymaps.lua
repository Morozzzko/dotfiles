local map = vim.keymap.set
local o = { silent = true, noremap = true }

-- Smart window navigation (auto-split if target doesn't exist)
local function win_move(key)
  local cur = vim.fn.winnr()
  vim.cmd("wincmd " .. key)
  if vim.fn.winnr() == cur then
    vim.cmd(key == "j" or key == "k" and "wincmd s" or "wincmd v")
    vim.cmd("wincmd " .. key)
  end
end

map("", "<C-h>", function() win_move("h") end, o)
map("", "<C-j>", function() win_move("j") end, o)
map("", "<C-k>", function() win_move("k") end, o)
map("", "<C-l>", function() win_move("l") end, o)

-- Visual-line movement for wrapped lines
map("n", "j", "gj", o)
map("n", "k", "gk", o)
map("n", "<Down>", "gj", o)
map("n", "<Up>", "gk", o)

-- File tree (neo-tree)
map("n", "<leader><leader>", ":Neotree toggle<CR>", o)
map("n", "<leader>e", ":Neotree reveal<CR>", o)
map("n", "<leader>b", ":Neotree action=focus source=buffers position=bottom<CR>", o)

-- Yank helpers
map("n", "<leader>yl", "0vg_y", o)           -- yank line content (no newline)
map("n", "<leader>yp", ":let @+=expand('%:p')<CR>", o)  -- copy absolute file path

-- Clear search highlight
map("n", "<Esc>", ":nohlsearch<CR>", o)

-- Better indenting in visual mode (keep selection)
map("v", "<", "<gv", o)
map("v", ">", ">gv", o)
