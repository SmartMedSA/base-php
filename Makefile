SHELL := /bin/bash

APP_SERVICE_NAME := app-name
PMA_SERVICE_NAME := phpmyadmin
XDEBUG_SERVICE_NAME := xdebug
TEST_SERVICE_NAME := test
S3_SERVICE_NAME := s3server

REPO = $(CI_REGISTRY_IMAGE)

ifeq ($(REPO),)
    # Emulate docker-compose repo structure.
	REPO = $(shell basename $(CURDIR))_$(APP_SERVICE_NAME)
endif

NAME = app-name

ifeq ($(IMAGE_TAG),)
    IMAGE_TAG ?= latest
endif

.PHONY: build buildx check test pull push shell run start stop logs clean release

default: build

.EXPORT_ALL_VARIABLES:

build:
	docker build \
		$(PARAMS) \
		--cache-from $(REPO):$(IMAGE_TAG) \
		-t $(REPO):$(IMAGE_TAG) \
		--pull \
		./

buildx:
	docker buildx build \
		$(PARAMS) \
		--cache-from=type=registry,ref=$(REPO):$(IMAGE_TAG) \
		-t $(REPO):$(IMAGE_TAG) \
		--push \
		./

check:
	docker run --rm \
		--name $(NAME) \
		$(PORTS) \
		$(VOLUMES) \
		--env-file .env.local --env-file .env.test $(ENV) \
		$(REPO):$(IMAGE_TAG) \
		composer run check

test:
	docker run --rm \
		--name $(NAME) \
		$(PORTS) \
		$(VOLUMES) \
		--env-file .env.local --env-file .env.test $(ENV) \
		$(REPO):$(IMAGE_TAG) \
		composer run test

pull:
	-docker pull $(REPO):$(IMAGE_TAG)

push:
	docker push $(REPO):$(IMAGE_TAG)

shell:
	docker run --rm -i -t \
		--name $(NAME) \
		$(PORTS) \
		$(VOLUMES) \
		--env-file .env.local $(ENV) \
		$(REPO):$(IMAGE_TAG) \
		/bin/bash

run:
	docker run --rm --name $(NAME) $(PORTS) $(VOLUMES) $(ENV) $(REPO):$(IMAGE_TAG) $(CMD)

start:
	docker run -d --name $(NAME) $(PORTS) $(VOLUMES) $(ENV) $(REPO):$(IMAGE_TAG)

stop:
	docker stop $(NAME)

logs:
	docker logs $(NAME)

clean:
	-docker rm -f $(NAME)

# Run build steps on CI.
ci.build: pull build push

# Get services URLs and docker-compose process status.
dcps:
	$(eval APP_ID := $(shell docker-compose ps -q $(APP_SERVICE_NAME)))
	$(eval APP_PORT := $(shell docker inspect $(APP_ID) --format='{{json (index (index .NetworkSettings.Ports "8080/tcp") 0).HostPort}}' 2> /dev/null))
	@echo $(APP_SERVICE_NAME): $(if $(APP_PORT), "http://localhost:$(APP_PORT)", "port not found.")

	$(eval PMA_ID := $(shell docker-compose ps -q $(PMA_SERVICE_NAME)))
	$(eval PMA_PORT := $(shell docker inspect $(PMA_ID) --format='{{json (index (index .NetworkSettings.Ports "80/tcp") 0).HostPort}}' 2> /dev/null))
	@echo $(PMA_SERVICE_NAME): $(if $(PMA_PORT), "http://localhost:$(PMA_PORT)", "port not found.")

	-$(eval XDEBUG_ID := $(shell docker-compose  --profile xdebug ps -q $(XDEBUG_SERVICE_NAME)))
	-$(eval XDEBUG_PORT := $(shell docker inspect $(XDEBUG_ID) --format='{{json (index (index .NetworkSettings.Ports "8080/tcp") 0).HostPort}}' 2> /dev/null))
	@echo $(XDEBUG_SERVICE_NAME): $(if $(XDEBUG_PORT), "http://localhost:$(XDEBUG_PORT)", "port not found.")

	-$(eval S3_ID := $(shell docker-compose  --profile xdebug ps -q $(S3_SERVICE_NAME)))
	-$(eval S3_PORT := $(shell docker inspect $(S3_ID) --format='{{json (index (index .NetworkSettings.Ports "9000/tcp") 0).HostPort}}' 2> /dev/null))
	@echo $(S3_SERVICE_NAME): $(if $(S3_PORT), "http://localhost:$(S3_PORT)", "port not found.")

# New line before the ps.
	@echo
	@docker-compose ps -a

# Rebuild images, remove orphans, and docker-compose up.
dcupd:
	docker-compose up -d --build --remove-orphans

# Stop all runner containers.
dcstop:
	docker-compose stop

# Get app-name container logs.
dclogs:
	docker-compose logs --tail=100 -f $(APP_SERVICE_NAME)

# Get a bash inside running app-name container.
dcshell:
	docker-compose exec $(APP_SERVICE_NAME) bash

# Start app-name with xdebug enabled.
dcxdbg:
	docker-compose --profile $(XDEBUG_SERVICE_NAME) up -d --build --remove-orphans
	docker-compose --profile $(XDEBUG_SERVICE_NAME) logs --tail=100 -f $(XDEBUG_SERVICE_NAME)

# Start app-name test
dctest:
	docker-compose --profile $(TEST_SERVICE_NAME) run --rm test composer test

# Include the .d makefiles. The - at the front suppresses the errors of missing
# Include the .d makefiles.
-include makefiles.d
