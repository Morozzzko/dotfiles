vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

-- line numbers
opt.number = true
opt.relativenumber = true

-- indentation
opt.expandtab = true
opt.shiftwidth = 2
opt.softtabstop = 2
opt.smartindent = true

-- search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true

-- display
opt.wrap = true
opt.linebreak = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.signcolumn = "yes"
opt.cursorline = true
opt.termguicolors = true
opt.cmdheight = 1

-- splits
opt.splitbelow = true
opt.splitright = true

-- files
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.undofile = true

-- clipboard
opt.clipboard = "unnamedplus"

-- completion
opt.completeopt = { "menu", "menuone", "noselect" }
opt.pumheight = 10

-- misc
opt.hidden = true
opt.autowrite = true
opt.showcmd = true
opt.updatetime = 250
opt.timeoutlen = 300

-- Russian keyboard support
opt.langmap =
"ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz"
