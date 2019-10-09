# Prefix
unbind C-b
set -g prefix C-a
bind C-a send-prefix

# Easy Config Reloads
bind r source-file ~/.tmux.conf

# Quick key for moving back to the previous window
bind-key p last-window

# Direction
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

# mouse behavior
#setw -g mouse

#-------- Copy Mode (Vim Style) {{{
#------------------------------------------------------
# This section of hotkeys mainly work in copy mode and no where else

# vim keys in copy and choose mode
set-window-option -g mode-keys vi

# copying selection vim style
# http://jasonwryan.com/blog/2011/06/07/copy-and-paste-in-tmux/
# https://github.com/myfreeweb/dotfiles/blob/master/tmux.conf
bind-key Escape copy-mode			# enter copy mode; default [
bind-key -T copy-mode-vi 'v' send -X begin-selection
#bind-key -T copy-mode-vi 'y' send -X copy-selection-and-cancel
bind-key -T copy-mode-vi 'V' send-keys -X select-line
bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
bind-key -T choice-mode-vi 'h' send-keys -X tree-collapse
bind-key -T choice-mode-vi 'l' send-keys -X tree-expand
bind-key -T choice-mode-vi 'H' send-keys -X tree-collapse-all
bind-key -T choice-mode-vi 'L' send-keys -X tree-expand-all
bind -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel "xclip -selection clipboard"
#}}}

# vim splits
bind-key y split-window -h
bind-key x split-window -v

# moving panes
bind-key g command-prompt -p "join pane from:"  "join-pane -s '%%'"
bind-key s command-prompt -p "send pane to:"  "join-pane -t '%%'"

# Make resizing panes easier
bind-key Left resize-pane -L 5
bind-key Right resize-pane -R 5
bind-key Up resize-pane -U 5
bind-key Down resize-pane -D 5
bind-key = select-layout even-vertical
bind-key | select-layout even-horizontal

# ditched m which had select-pane -m
# this place a stronger visual cue on the selected pane
# add bind for mouse support toggle needs tmux 2.2
bind-key m set -g mouse

# toggles tmux bar on/off
bind-key - set status

#### directly bind function keys
# fast window selection
bind -n F1 select-window -t 1
bind -n F2 select-window -t 2
bind -n F3 select-window -t 3
bind -n F4 select-window -t 4
bind -n F5 select-window -t 5
bind -n F6 new-window

# renames tmux window
# more info here: http://unix.stackexchange.com/a/269542/155613
bind -n F7 command-prompt "rename-window '%%'"

# reload tmux config
bind -n F8 source ~/.tmux.conf
