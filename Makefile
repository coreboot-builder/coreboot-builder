PWD ?= $(shell pwd)
DATABASE_SAMPLE ?= $(PWD)/config/database.yml.sample
SECRETS_SAMPLE ?= $(PWD)/config/secrets.yml.sample

all:

dev-env:
	@wget -O $(PWD)/.git/hooks/commit-msg https://review.coreboot.org/tools/hooks/commit-msg 1> /dev/null
	@chmod +x $(PWD)/.git/hooks/commit-msg 1> /dev/null
	@git config remote.origin.push HEAD:refs/for/master 1> /dev/null
	@cp $(DATABASE_SAMPLE) $(PWD)/config/database.yml 1> /dev/null
	@cp $(SECRETS_SAMPLE) $(PWD)/config/secrets.yml 1> /dev/null
	@bundle exec rake db:drop db:create db:migrate 1> /dev/null
	@echo -e "\e[92mBuild environment is set up."

.PHONY: all
