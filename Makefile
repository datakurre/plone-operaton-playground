.env:
	@echo CODESPACE_NAME=$$CODESPACE_NAME >.env
	@echo GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN=$$GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN >>.env

.PHONY:
install: .env
	@devenv shell -- echo "Ok."

.PHONY:
up: .env ## Start services
	@devenv up
