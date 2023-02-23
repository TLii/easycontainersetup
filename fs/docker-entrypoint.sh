#!/usr/bin/env bash

# Easy Container Setup Model (ECSM)
# Entrypoint script
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


# YOU DO NOT NEED TO EDIT THIS FILE.

set -Eeo pipefail

for sc in /opt/lib/*.sh; do $sc; done
for sc in /opt/scripts/*.sh; do $sc; done


run_init "$@"

run_setup "$@"

run_finish "$@"

run_entrypoint "$@"