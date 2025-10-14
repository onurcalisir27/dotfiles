#!/bin/bash
DOTFILES_DIR = ~/home/($whoami)/
set -e

stow -t ~/.config/tmux tmux

stow -t ~/.config/nvim nvim
