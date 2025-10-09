help:
	@grep -Eh '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' | uniq

.env:
	@echo CODESPACE_NAME=$$CODESPACE_NAME >.env
	@echo GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN=$$GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN >>.env

.PHONY: clean
clean:
	devenv gc
	$(RM) -r .venv .devenv*

.PHONY: install
install: .env
	@devenv shell -- echo "Ok."

.PHONY: shell
shell: .env ## Enter development shell
	@devenv shell

.PHONY: start
start: .env ## Start development services
	@devenv up -d

.PHONY: start-monitor
start-monitor: .env devenv-attach  ## Open process monitor

.PHONY: devenv-test
devenv-test:
	@devenv test

.PHONY: stop
stop: ## Stop background services
	devenv processes down

watch-docs:
	LC_ALL=C make -C docs nix-watch
