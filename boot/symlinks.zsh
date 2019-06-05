# deploy symlinks

echo "\033[1;33m[STATUS - $0]\033[0m Sourcing deploy scripts."
cd $GIT_ROOT
for file in ./**/deploy.zsh; do
    source $file
done

echo "\033[1;33m[STATUS - $0]\033[0m Checking/Updated symlinks within ${HOME}/dotfiles."

verifylink ~/.dotfiles
updatelinks ~/.dotfiles .
