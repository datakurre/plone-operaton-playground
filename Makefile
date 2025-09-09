.env:
	@echo CODESPACE_NAME=$$CODESPACE_NAME >.env
	@echo GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN=$$GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN >>.env

.PHONY:
codespace-install: .env
	@devenv shell -- echo "Ok."

.PHONY:
codespace-start: .env ## Start services at GitHub Codespaces
	@devenv up
