.ONESHELL:

.DEFAULT_GOAL := install

PACKAGE_VERSION := uv version -s

help:
	@echo "Please use 'make <target>' where <target> is one of"
	@echo "  uv_mac         to install the uv package manager on macOS"
	@echo "  uv_win         to isntall the uv package manager on Windows via powershell"
	@echo "  install    	to create virtual environment and install dependencies"
	@echo "  clean      	to remove virtual environment"
	@echo "  test       	to run tests"
	@echo "  lint       	to perform lint fixes"

test: ## run tests quickly with the default Python
	uv run pytest --cov=src


coverage: ## run coverage report
	coverage report -m

lint: ## perform inplace lint fixes
	ruff --fix .
	pre-commit run --all-files

uv_mac: ## Setup uv environment
	curl -LsSf https://astral.sh/uv/install.sh | sh
	uv venv
	pre-commit install

uv_win: ## Setup uv environment
	powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
	uv venv
	pre-commit install

install: ## install Python dependencies
	uv sync -C --no-build

clean: ## remove virtual environment
	rm -rf __pycache__
	rm -rf .venv
