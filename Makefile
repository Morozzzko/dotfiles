.PHONY: setup audit skills

setup:
	@bin/setup

audit:
	@bin/apps/audit

skills:
	@bin/skills/sync
