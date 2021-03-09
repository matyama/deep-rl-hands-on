.PHONY: fmt fmt-code fmt-nb lint lint-code lint-nb setup system-libs

system-libs:
	sudo apt install -y libglu1-mesa xvfb

setup: system-libs
	poetry env use python3.8
	poetry install
	poetry run jupyter labextension install @jupyter-widgets/jupyterlab-manager


fmt-code:
	isort .
	black .

fmt-nb:
	nbqa isort . --nbqa-mutate
	nbqa black . --nbqa-mutate

fmt: fmt-code fmt-nb

lint-code:
	flakehell lint .

lint-nb:
	nbqa flake8 .

lint: lint-code lint-nb
