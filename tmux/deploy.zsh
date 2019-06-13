verifylink ~/.tmux.conf
updatelinks ~/.tmux.conf tmux/main.tmux

verifylink ~/.tmux.d
updatelinks ~/.tmux.d tmux

printf "\e[1;33m%s\e[m %s\n" "[INFO]" "Cloning tmux plugin manager"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
git clone --recursive https://github.com/Morantron/tmux-fingers ~/.tmux/plugins/tmux-fingers
