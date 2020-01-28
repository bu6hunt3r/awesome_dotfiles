verifylink ~/.tmux.conf
updatelinks ~/.tmux.conf common/tmux/main.tmux

verifylink ~/.tmux.d
updatelinks ~/.tmux.d common/tmux

printf "\e[1;33m%s\e[m %s\n" "[INFO]" "Cloning tmux plugin manager"

if [ -d "$HOME/.tmux/plugins/tpm/" ]; then
	printf "\e[1;33m%s\e[m %s\n" "[INFO]" "tpm already cloned... skipping"
else
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

if [ -d "$HOME/.tmux/plugins/tmux-fingers/" ]; then
	printf "\e[1;33m%s\e[m %s\n" "[INFO]" "tmux-fingers already cloned... skipping"
else
	git clone --recursive https://github.com/Morantron/tmux-fingers ~/.tmux/plugins/tmux-fingers
fi
