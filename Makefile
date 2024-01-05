PROJECT_NAME = slackbot
SHELL := /bin/sh

help:
	@echo "Please use 'make <target>' where <target> is one of"
	@echo "  all                      to setup the whole environment for the project"
	@echo "  venv                     to create the virtualenv for the project"
	@echo "  requirements             install the requirements to the virtualenv"
	@echo "  run                			start bot"
	@echo "  clean                    remove builds"

.PHONY: all clean

all: clean venv requirements

# Command variables
MANAGE_CMD = python3 manage.py
PIP_INSTALL_CMD = pip install
VIRTUALENV_NAME = venv

# Helper functions to display messagse
ECHO_BLUE = @echo "\033[33;34m $1\033[0m"
ECHO_RED = @echo "\033[33;31m $1\033[0m"

venv:
	( \
		rm -rf venv; \
		python3 -m venv $(VIRTUALENV_NAME); \
	)

requirements:
	( \
		. $(VIRTUALENV_NAME)/bin/activate; \
		$(PIP_INSTALL_CMD) --upgrade pip; \
		$(PIP_INSTALL_CMD) -r requirements.txt; \
	)

clean:
	# Remove files not in source control
	find . -type f -name "*.pyc" -delete
	rm -rf nosetests.xml coverage.xml htmlcov *.egg-info *.pdf dist violations.txt

