PWD ?= $(shell pwd)
DATABASE_SAMPLE ?= $(PWD)/config/database.yml.sample
SECRETS_SAMPLE ?= $(PWD)/config/secrets.yml.sample

all:

dev-env:
	@cp $(DATABASE_SAMPLE) $(PWD)/config/database.yml 1> /dev/null
	@cp $(SECRETS_SAMPLE) $(PWD)/config/secrets.yml 1> /dev/null
	@bundle install
	@bundle exec rake db:drop db:create db:migrate 1> /dev/null
	@echo "Build environment is set up."

.PHONY: all
