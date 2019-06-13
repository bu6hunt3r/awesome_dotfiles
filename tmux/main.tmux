# -*- mode: sh -*-
source ~/.tmux.d/options.tmux
source ~/.tmux.d/truecolor-hacks.tmux
source ~/.tmux.d/keybinds.tmux
source ~/.tmux.d/theme.tmux

# Set env vars for fingers plugin
set-environment -g PATH "/usr/local/bin:/bin:/usr/bin"

run-shell ~/.tmux/plugins/tmux-fingers/tmux-fingers.tmux

# List of plugins
set -g @plugin 'tmux-plugins/tpm'

# Source fingers key bnidings
source ~/.tmux.d/fingers.tmux
