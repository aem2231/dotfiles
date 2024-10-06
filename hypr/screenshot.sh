#!/usr/bin/env bash

nix-shell - p hyprshot &
hyprshot -m region --clipboard-only
