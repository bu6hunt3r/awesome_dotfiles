source ~/.tmux.d/options.tmux
source ~/.tmux.d/truecolor-hacks.tmux
source ~/.tmux.d/keybinds.tmux
source ~/.tmux.d/theme.tmux

# Set env vars for fingers plugin
# set-environment -g PATH "/usr/local/bin:/bin:/usr/bin"

set-window-option -g window-status-current-format '#[bg=blue,fg=cyan,bold]#I#[bg=blue,fg=cyan]:#[fg=colour230]#W#[fg=dim]#F'

run-shell ~/.tmux/plugins/tmux-fingers/tmux-fingers.tmux

# List of plugins
set -g @plugin 'tmux-plugins/tpm'

# Source fingers key bnidings
source ~/.tmux.d/fingers.tmux
