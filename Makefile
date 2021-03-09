.PHONY: fmt lint setup system-libs

system-libs:
	sudo apt install -y libglu1-mesa xvfb

setup: system-libs
	poetry env use python3.8
	poetry install
	poetry run jupyter labextension install @jupyter-widgets/jupyterlab-manager

fmt:
	isort .
	black .

lint:
	flakehell lint
