#
# Makefile used for Jenkins pipelines
#

# DRYRUN is set in the ENV by Jenkins
DRY_RUN :=
ifeq (${DRYRUN},yes)
DRY_RUN := --dry
endif

# all: prepare-job

build-image:
	@echo "Preparing mke-ui-tests image..."
	@echo ""
	docker build -t mke-ui-tests -f ./Dockerfile .

remove-image:
	@echo "Removing mke-ui-tests image..."
	@echo ""
	docker image rm mke-ui-tests -f

# Create and run a container from the named image
create-container:
	@echo "Creating mke-ui-tests container..."
	@echo ""
	docker run --name mke-ui-tests-run -d -it mke-ui-tests

remove-container:
	@echo "Destroying mke-ui-tests container..."
	@echo ""
	docker rm -f mke-ui-tests-run


# opens the shell in the container
shell:
	@echo "Opening shell in mke-ui-tests container..."
	@echo ""
	docker exec -it mke-ui-tests-run bash

# This command must be run in the form of NPM_TOKEN="$NPM_TOKEN" make prepare-dependencies, or anything that substitutes a suitable value for $NPM_TOKEN
install:
	# @echo "Setting Registry Token"
	@echo ""
	# docker exec -it mke-ui-tests-run npm config set //registry.npmjs.org/:_authToken ${NPM_TOKEN}
	@echo "Installing dependencies..."
	@echo ""
	docker exec -it mke-ui-tests-run npm install --force

list-tools:
	@echo "Listing tools..."
	@echo "---- bash version:"
	@bash --version
	@echo "---- git version:"
	@git --version
	@echo "---- docker version:"
	@docker --version
	@echo "---- node version:"
	@node --version
	@echo "---- npm version:"
	@npm --version
	@echo "---- yarn version:"
	@yarn --version

# prepares the job for ensuing tasks
prepare-job: list-tools prepare-env

all-tests:
	@echo "Running all tests..."
	@echo ""
	docker exec -it mke-ui-tests-run npm run lint && npm run ci
	@echo ""

# ci-lint:
# 	@echo "Running ESLint..."
# 	@echo ""
# 	docker exec -it mke-ui-tests-run yarn lint
# 	@echo ""

# ci-unit:
# 	@echo "Running unit tests..."
# 	@echo ""
# 	docker exec -it mke-ui-tests-run yarn ci:unit
# 	@echo ""

# ci-enzyme:
# 	@echo "Running legacy enzyme tests..."
# 	@echo ""
# 	docker exec -it mke-ui-tests-run yarn ci:enzyme
# 	@echo ""

# ci-rtl:
# 	@echo "Running RTL tests..."
# 	@echo ""
# 	docker exec -it mke-ui-tests-run yarn ci:rtl
# 	@echo ""

# .PHONY: list-tools prepare-npm-env prepare-env prepare-job dependency-check tooling-image-update all-packages webimages-build webimages-push webimages-deploy webimages-capture tests publish-get-names publish-single publish-all publish-release