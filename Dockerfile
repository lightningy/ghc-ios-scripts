###
# This compiles a Docker base image of the ghc-ios compiler.
# This would be useful for downstream projects that want a Haskell platform Docker base
# image which supports iOS cross-compilation, to avoid having to install ghc-ios in their
# own project-specific Docker images.

# Preinstall regular Haskell platform
FROM haskell:7.8

MAINTAINER Chris Kilding <chris@chriskilding.com>

# Add current repo contents
ADD . /usr/src/app

WORKDIR /usr/src/app

RUN ./installGHCiOS.sh

CMD ["ghc-ios"]