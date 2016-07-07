DOCKER_IMAGE_VERSION=latest
DOCKER_IMAGE_NAME=marhan/docker-jenkins
DOCKER_IMAGE_TAGNAME=$(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_VERSION)

default: build

build:
    set -e
    set -x

    JENKINS_VERSION=`curl -sq https://api.github.com/repos/jenkinsci/jenkins/tags | grep '"name":' | grep -o '[0-9]\.[0-9]*'  | uniq | sort --version-sort | tail -1`
    echo $JENKINS_VERSION

    JENKINS_SHA=`curl http://repo.jenkins-ci.org/simple/releases/org/jenkins-ci/main/jenkins-war/${JENKINS_VERSION}/jenkins-war-${JENKINS_VERSION}.war.sha1`
    echo $JENKINS_SHA

    docker build --build-arg JENKINS_VERSION=$JENKINS_VERSION \
                 --build-arg JENKINS_SHA=$JENKINS_SHA \
                 --no-cache --pull \
                 --tag marhan/docker-jenkins:$JENKINS_VERSION .

push:
	docker push marhan/docker-jenkins:$JENKINS_VERSION

