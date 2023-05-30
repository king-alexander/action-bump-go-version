# Container image that runs your code
FROM alpine:3.10

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY bump_version.sh /bump_version.sh

# Code file to execute when the docker container starts up (`bump_version.sh`)
ENTRYPOINT ["/bump_version.sh"]
