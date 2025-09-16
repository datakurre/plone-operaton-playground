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
	@devenv up
