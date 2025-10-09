.PHONY: help
help:
	@grep -Eh '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' | uniq

.env:
	@echo CODESPACE_NAME=$$CODESPACE_NAME >.env
	@echo GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN=$$GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN >>.env

.PHONY: clean
clean:
	devenv gc
	$(RM) -r .venv .devenv*

.PHONY: devenv-up
devenv-up: .env
	devenv processes up -d

.PHONY: devenv-attach
devenv-attach:
	devenv shell -- process-compose attach

.PHONY: devenv-down
devenv-down:
	devenv processes down

.PHONY: devenv-test
devenv-test: .env
	devenv test

.PHONY: format
format:
	treefmt

.PHONY: install
install: .env
	devenv shell -- echo "Ok."

.PHONY: shell
shell: .env ## Enter development shell
	devenv shell

.PHONY: show
show:
	devenv info

.PHONY: start
start: devenv-up  ## Start background services

.PHONY: start-monitor
start-monitor: .env devenv-attach  ## Open process monitor

.PHONY: stop
stop: devenv-down  ## Stop background services

.PHONY: watch-docs
watch-docs:
	LC_ALL=C make -C docs nix-watch

devenv-%:  ## Run command in devenv shell
	devenv shell -- $(MAKE) $*

nix-%:  ## Run command in devenv shell
	devenv shell -- $(MAKE) $*

FORCE:
