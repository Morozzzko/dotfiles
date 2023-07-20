.PHONY: store-shell-config store-nvim-config

store-shell-config:
	rsync -rv ~/.config/fish/ files/fish/

store-nvim-config:
	rsync -rv ~/.config/nvim/ files/nvim/
