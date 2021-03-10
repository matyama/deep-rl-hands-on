.PHONY: clean fmt fmt-code fmt-nb lint lint-code lint-nb setup system-libs tb xjl

clean:
	rm -rf recording runs

system-libs:
	sudo apt install -y ffmpeg libglu1-mesa xvfb

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

runs:
	mkdir -p runs

tb: runs
	tensorboard --logdir runs

xjl:
	xvfb-run -s "-screen 0 640x480x24" jupyter lab --ContentsManager.allow_hidden=True
