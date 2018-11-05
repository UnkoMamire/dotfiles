#!/usr/bin/env sh

git clone --recursive https://github.com/UnkoMamire/vicker.git "${VICKDIR:-$HOME}/.vicker"
${VICKDIR:-$HOME}/.vicker/install.sh

