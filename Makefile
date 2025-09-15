.PHONY: install
install:
	@devenv shell -- echo "Ok."

.PHONY: shell
shell: ## Enter development shell
	@devenv shell

.PHONY: up
up: ## Start development services
	@devenv up
