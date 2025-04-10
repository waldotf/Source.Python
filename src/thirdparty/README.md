# Dependencies

Source.Python included compiled binaries and C++ header files in the repo. This both obscured the actual build process/flags for dependencies as well as made tracking versions difficult, with the benefit that compilation was simpler. Trying to make it a little more explicit/easy to follow by scripting the build process for each library.

## Building

The shared libraries we're building ultimately need to be compatible with the 2013 SDK, so we're doing a sort of cross compile. As such, this will all be done in an i386 container. I like Debian, so it will be Debian. Hopefully it's fine that this is a modern version and we don't have strange glibc version issues...

## How to use

First, setup all submodules: `git submodule update --init` from root.

Then, get your desired Python version by checking out the relevant branch (submodule pin is 3.12, should work with any 3.x).

Next, start the container and setup all relevant packages/environment vars (eventually build this into an image, or at least an entrypoint script): `./container` -> `source /src/src/thirdparty/prep_build.sh`.

Next, build each dependency (these set some env vars, so `source` rather than execute). Some have dependencies; this order works:

`build_python.sh` -> `build_boost.sh` -> `build_asmjit.sh` -> `build_dyncall.sh` -> `build_dynamichooks.sh`

The scripts will build the relevant (portions of) the project, then vaccuum out the compiled shared object libraries (packing `.o`'s into `.a`'s as needed) as well as include files.

Outputs are in `thirdparty/libs/` and `thirdparty/include/.

## Status

Seems to all build. Patched build as well; now need to fix `/addons/` for the new version...
