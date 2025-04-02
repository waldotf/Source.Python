# Dependencies

Previous versions of Source.Python included compiled binaries and C++ header files in the repo. This both obscured the actual build process/flags for dependencies as well as made tracking versions difficult, with the benefit that compilation was simpler.

## Building

The shared libraries we're building ultimately need to be compatible with the 2013 SDK, so we're doing a sort of cross compile. As such, this will all be done in a container. I like Debian, so it will be Debian.

`prep_deps.sh` is to be run post-`git submodule update --init`, but outside the container to avoid permissions weirdness

`prep_build.sh` should eventually be in a Dockerfile, but for now should be run interactively after `container.sh` as we're figuring it out.

The `build*` scripts are intended to be run inside the container, with some rough ordering -- python first, probably some other dependencies?
