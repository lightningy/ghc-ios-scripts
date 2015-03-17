###
# This compiles a Docker base image of the ghc-ios compiler.
# This would be useful for downstream projects that want a Haskell platform Docker base
# image which supports iOS cross-compilation, to avoid having to install ghc-ios in their
# own project-specific Docker images.
###

# Preinstall regular Haskell platform
FROM haskell:7.8

MAINTAINER Chris Kilding <chris@chriskilding.com>

# Add current repo contents
# Mirror the workdir structure suggested from the README,
# but we cannot use relative paths in a Dockerfile ADD command,
# so must use the absolute /usr top level directory.
ADD . /usr/bin/ghc-ios-scripts
WORKDIR /usr/bin/ghc-ios-scripts

# Add the project directory to the path
RUN echo -e "\nPATH=/usr/bin/ghc-ios-scripts:"'$PATH' >> ~/.profile
RUN PATH=/usr/bin/ghc-ios-scripts:$PATH

# Need CURL on the system for the script to work
RUN apt-get update
RUN apt-get -y install curl

# Run the installer
RUN ./installGHCiOS.sh

CMD ["ghc-ios"]