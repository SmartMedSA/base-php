SHELL := /bin/bash
.EXPORT_ALL_VARIABLES:

REPO = $(CI_REGISTRY_IMAGE)

ifeq ($(REPO),)
    # Emulate docker-compose repo structure.
	REPO = $(shell basename $(CURDIR))
endif

NAME = app


ifeq ($(IMAGE_TAG),)
    IMAGE_TAG ?= latest
endif

.PHONY: build buildx check test pull push shell run start stop logs clean release
default: build

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

# Include the .d makefiles. The - at the front suppresses the errors of missing
# Include the .d makefiles.
-include makefiles.d
