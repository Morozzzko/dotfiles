.PHONY: setup audit dump-iterm

setup:
	@bin/setup

audit:
	@bin/apps/audit

dump-iterm:
	cp ~/Library/Preferences/com.googlecode.iterm2.plist iterm2/
