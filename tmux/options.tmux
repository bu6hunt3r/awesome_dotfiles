# -*- mode: sh -*-

# Prevent tmux from renaming the tab when processes change
set-option -g allow-rename off

# Tells tmux up front what shell to expect
def_shell=/bin/zsh
set-option -g default-shell $def_shell

# Set base to 1
set -g base-index 1

# Enable UTF-8 support in status bar
set -g status on

# Increase scrollback lines
set -g history-limit 30000

# Renumber windows automatically after removing a window
set-option -g renumber-windows on

# The modes {
setw -g clock-mode-colour colour135
setw -g mode-attr bold
setw -g mode-fg colour196
setw -g mode-bg colour238

# }
# The panes {
#
##set -g pane-border-bg colour235
#set -g pane-border-fg colour238
##set -g pane-active-border-bg colour236
#set -g pane-active-border-fg colour51

# }
# The statusbar {
set-window-option -g window-status-current-format '#[bg=blue,fg=cyan,bold]#I#[bg=blue,fg=cyan]:#[fg=colour230]#W#[fg=dim]#F'
#set -g status-position bottom
#set -g status-bg colour234
#set -g status-fg colour137
#set -g status-attr dim
#set -g status-left ''
#set -g status-right '#[fg=colour233,bg=colour245,bold] %A %-I:%M #[fg=colour255,bg=colour000] #(whoami)@#H'
#set -g status-right-length 50
#set -g status-left-length 20
#
#setw -g window-status-current-fg colour81
#setw -g window-status-current-bg colour238
#setw -g window-status-current-attr bold
#setw -g window-status-current-format ' #I#[fg=colour250]:#[fg=colour255]#W#[fg=colour50]#F '
#
#setw -g window-status-fg colour138
#setw -g window-status-bg colour235
#setw -g window-status-attr none
#setw -g window-status-format ' #I#[fg=colour237]:#[fg=colour250]#W#[fg=colour244]#F '
#
#setw -g window-status-bell-attr bold
#setw -g window-status-bell-fg colour255
#setw -g window-status-bell-bg colour1
#
# }
# The messages {

set -g message-attr bold
set -g message-fg colour232
set -g message-bg colour166

# }
