SHELL := /bin/bash

.PHONY : help init test clean
.DEFAULT: help

help:
	@echo "init 		generate project for local development"
	@echo "test			run pre-commit checks"
	@echo "clean		delete virtualenv and installed libraries"

# Install local dependencies and git hooks
init: venv
	venv/bin/pre-commit install

# virtualenv setup
venv: venv/bin/activate

venv/bin/activate:
	test -d venv || virtualenv venv
	. venv/bin/activate; pip install -Ur requirements-dev.txt; pip install -Ur requirements.txt
	touch venv/bin/activate

test:
	pre-commit run --all-files

# Cleanup local build
clean:
	rm -rf venv
	find . -iname "*.pyc" -delete
