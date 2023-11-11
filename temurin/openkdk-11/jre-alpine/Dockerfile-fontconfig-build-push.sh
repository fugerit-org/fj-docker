#!/bin/bash
#
# Build and push my docker file
#
VERSION_TAG=${1}
if [[ "${VERSION_TAG}" == "" ]]; then
	echo "Version tag (first parameter) cannot be empty"
else
	DOCKER_ACCOUNT=fugeritorg
	DOCKER_FILE=Dockerfile-fontconfig
	REPO1=${DOCKER_ACCOUNT}/openjdk
	REPO2=${DOCKER_ACCOUNT}/openjdk-temurin
	echo "VERSION_TAG : ${VERSION_TAG}"
	TAG1="${REPO1}:temurin-11.0.21_9-jre-alpine-fontconfig.${VERSION_TAG}"
	TAG2="${REPO2}:11.0.21_9-jre-alpine-fontconfig.${VERSION_TAG}"
	echo "REPO1 ${REPO1} TAG1: ${TAG1}"
	echo "REPO2 ${REPO2} TAG2: ${TAG2}"
	echo "Dockerfile : ${DOCKER_FILE}"
	docker build -f Dockerfile-fontconfig -t ${TAG1} -t ${TAG2} .
	DOCKERBUILD_RES="${?}"
	if [[ "${DOCKERBUILD_RES}" == "0" ]]; then
		echo "OK"
		docker push ${TAG1}
		docker push ${TAG2}
	else
		echo "docker build failed : ${DOCKERBUILD_RES}"
	fi
fi

