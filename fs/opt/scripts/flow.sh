#!/usr/bin/env bash

# Easy Container Setup Model (ECSM)
# Entrypoint flow script
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


# EDITING THIS FILE IS NOT RECOMMENDED.

run_init() {
  prepare_env "$@"

  # Setup all dependencies
  setup_dependencies "$@"

  # Prepare application install
  prepare_app "$@"

  run_custom_init "$@"
}

run_custom_init() {
  if [[ $(ls -A /opt/custom_scripts/init) ]]; then
    for sc in /opt/custom_scripts/init/*.sh; do bash "$sc"; done
  fi
  # If trigger_custom_init() exists, run it
  if [[ $(type -t trigger_custom_init) == function ]]; then
    trigger_custom_init "$@"
  else
    return
  fi

}

run_setup() {

  prepare_app "$@"

  setup_app "$@"

  run_custom_setup "$@"

}

run_custom_setup() {
  if [[ $(ls -A /opt/custom_scripts/setup) ]]; then
    for sc in /opt/custom_scripts/setup/*.sh; do bash "$sc"; done
  fi
  # If trigger_custom_setup() exists, run it
  if [[ $(type -t trigger_custom_setup) == function ]]; then
    trigger_custom_setup "$@"
  else
    return
  fi

}


run_finish() {

    finish_app_setup "$@"

    finish_cleanup "$@"

    run_custom_finish "$@"
}

run_custom_finish() {
    if [[ $(ls -A /opt/custom_scripts/finish) ]]; then
        for sc in /opt/custom_scripts/finish/*.sh; do bash "$sc"; done
    fi
    # If trigger_custom_finish() exists, run it
    if [[ $(type -t trigger_custom_finish) == function ]]; then
        trigger_custom_finish "$@"
    fi

}

run_entrypoint() {
    if [[ $(ls -A /opt/custom_scripts/entrypoint/) ]]; then
        # If there are scripts under /opt/custom_scripts/entrypoint, run them.
        # Note: results are unpredictable, if there are multiple files in the
        # directory.
        for sc in /opt/custom_scripts/entrypoint/*; do bash "$sc"; done
    elif [[ $(type -t custom_entrypoint) == function ]]; then
        # If set, run custom_entrypoint(), otherwise run default app_entrypoint().
        custom_entrypoint "$@"
    else
        app_entrypoint "$@"
    fi
}