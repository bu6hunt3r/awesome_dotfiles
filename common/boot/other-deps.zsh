mkdir -p $other_deps && cd $other_deps

# install seebi's dircolors-solarized
dotgrab seebi/dircolors-solarized
verifylink ~/.lscolors
updatelinks ~/.lscolors $other_deps/seebi/dircolors-solarized/dircolors.256dark

# grab tmux fingers
dotgrab Morantron/tmux-fingers