SHELL_OPTIONS_DIR=~/.options
SHELL_OPTIONS_FILE=$SHELL_OPTIONS_DIR/shell-options.zsh

zsh_deps=~/.dotfiles/deps/zsh
emacs_deps=~/.dotfiles/deps/emacs
vim_deps=~/.dotfiles/deps/vim
other_deps=~/.dotfiles/deps/other 

const_keys=(zsh_deps emacs_deps vim_deps other_deps)

printf "\e[1;33m%s\e[m %s" "[STATUS - $0]" "Loaded constants: "
for i in ${const_keys[@]}; do
    echo -n "$i ";
done
echo ""