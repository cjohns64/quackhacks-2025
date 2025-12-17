#!/bin/sh
printf '\033c\033]0;%s\a' quackhacks-2025
base_path="$(dirname "$(realpath "$0")")"
"$base_path/linux_build.x86_64" "$@"
