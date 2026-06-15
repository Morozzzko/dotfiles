.PHONY: stow unstow

PACKAGES = fish nvim shell git
DIR := $(shell pwd)

stow:
	@for pkg in $(PACKAGES); do \
		stow --dir=$(DIR) --target=$(HOME) $$pkg; \
	done

unstow:
	@for pkg in $(PACKAGES); do \
		stow --dir=$(DIR) --target=$(HOME) -D $$pkg; \
	done
