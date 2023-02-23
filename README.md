# Easy Container Setup Model (ECSM)
# Copyright 2023 Tuomas Liinamaa <tlii@iki.fi>

## General information
This repository contains a template for creating and setting up Docker containers in a more standardized and easily understandable way. The template is immediately usable and requires very little configuration to begin with.

## Features
* Intuitive filesystem control
* Easy customization of installation and/or setup flow
* Requires `bash`, and nothing more.

**There is no guaranteed support.**  If you don't know how to run this or break it while running, you risk keeping the pieces. I'm developing this primarily for my own use and won't make any promises. If however anyone finds this useful, please go ahead and use it! If you notice any problems or have feature ideas, feel free to file an issue.

**This repository does nothing alone.** You get nowhere by just placing this to your image's filesystem. It *always* requires a bit of coding. However the minimum amount of scripting required is not much (see below).

## Setup and usage
If you are creating a base image, it is recommended that files of the application itself are downloaded from a separate repository. Placing it under `/fs/path/to/app` wouldn't kill any kittens, but it is confusing at best.

A fine approach is to download the files in the Dockerfile, or better yet, use a multi-stage Dockerfile and a separate build stage (see examples under `/doc`) to download and extract the files before copying them to the running stage.

If you are extending another image however, placing files under `fs/` will inject them to the image, overriding existing (base image's) files. This can be used to modify basically *any* part of the base image.

Download one of the releases (or clone this repo) to the root of your Dockerfile context (usually the same directory as the Dockerfile itself). See `Dockerfile.example` for the required directives to add to your `Dockerfile` or more complex/complete examples under `/doc`. Any files you want copied to the container's filesystem should be added to their respective directories under `/fs`, which is copied directly to the image's root (`/`, so `/fs/opt` will become `/opt`).

Configure entrypoint starting from `fs/opt/lib/libinstall.sh`. Do not edit `fs/opt/scripts/flow.sh`, as it will just run functions from `libinstall.sh` consecutively. All files under `fs/opt/lib` and `fs/opt/scripts` will be run directly from the entrypoint, so beware of the dragons.

You can find further documentation under `/doc`.

## Post-build customization
The container setup runs in three (or four, if you count entrypoint) stages:
1. `init` - Initialization before the app is set up.
2. `setup` - Setting up the app itself.
3. `finish` - Cleanup and other finalizing tasks.
4. `entrypoint` - The final entrypoint command.

You can add your own scripts to run in `init`, `setup` and `finish` stages and, if you wish, override the entrypoint altogether.

There are two built-in ways to add scripts to the first three stages. First, you can either place script files to `/opt/custom_scripts/[init|setup|finish]`. All `.sh` files in those directories will be run consecutively.
If you want more control over the flow, you can use an object-oriented approach, place files under `/opt/lib` (these files *must* contain no procedural code!), and use functions `trigger_custom_init()` `trigger_custom_setup()` and `trigger_custom_finish()` to trigger their run.

If you want to override the default entrypoint, you can do so with `custom_entrypoint()`. Note: if `custom_entrypoint()` exists, *it will completely override* the default entrypoint.


## License
This image is licensed under AGPL3.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.


Partially derived from Docker Hub's official images;
Copyright 2014 Docker, Inc, originally licensed under Apache License 2.0.