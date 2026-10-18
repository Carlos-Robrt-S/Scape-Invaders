#!/bin/sh
printf '\033c\033]0;%s\a' Mappy
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Scape_Invaders_Linux.x86_64" "$@"
