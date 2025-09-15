.env:
	@echo CODESPACE_NAME=$$CODESPACE_NAME >.env
	@echo GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN=$$GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN >>.env

.PHONY: install
install: .env
	@devenv shell -- echo "Ok."

.PHONY: shell
shell: .env ## Enter development shell
	@devenv shell

.PHONY: up
up: .env ## Start development services
	@devenv up