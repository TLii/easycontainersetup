#!/usr/bin/env bash

# Easy Container Setup Model (ECSM)
# Installation library template
# Copyright 2023 Tuomas Liinamaa <tlii@iki.fi>

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.

# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.


# Partially derived from Docker Hub's official images;
# Copyright 2014 Docker, Inc.


# EDIT THIS FILE TO CREATE YOUR ENTRYPOINT LOGIC.

# Prepare the environment
prepare_env() {
  return
}

# Set up necessary dependencies and their settings
setup_dependencies() {
  return
}

# Prepare app for setup
prepare_app() {
  return
}

# Run the setting up of the app, either installing it, upgrading it or verifying its configuration.
setup_app() {
  return
}

# Wrap up setting up the application.
finish_app_setup() {
  return
}

# Do any cleanup to minimize container size etc.
finish_cleanup() {
  return
}

# The actual entrypoint command, executing CMD from Dockerfile.
run_entrypoint() {

    exec "$@"
}
