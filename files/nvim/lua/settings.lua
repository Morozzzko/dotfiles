local options = {
        langmap = 'ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz',
	wrap = true,
	linebreak = true,
	number = true,
	hlsearch = true,
	ignorecase = true,
	smartcase = true,
	relativenumber = true,
	expandtab = true,
	softtabstop = 2,
	shiftwidth = 2,
	splitbelow = true,
	cmdheight = 2,
	signcolumn = 'no',
	scrolloff = 3,
	-- turn backup off
	backup = false,
	writebackup = false,
	wb = false,
	swapfile = false,

	showcmd = true,
	autowrite = true,

	hidden = true,

        -- persistent undo
        undofile = true,

        clipboard = "unnamedplus,unnamed", -- use system clipboard
}

local globals = {
  mapleader = ' '
}


for k, v in pairs(options) do
  vim.opt[k] = v
end

for k, v in pairs(globals) do
  vim.g[k] = v
end
