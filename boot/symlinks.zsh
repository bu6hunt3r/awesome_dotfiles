# deploy symlinks

cd $GIT_ROOT
for file in ./**/deploy.zsh; do
    source $file
done

verifylink ~/.dotfiles
updatelink ~/.dotfiles .

echo "\033[1;33m[STATUS - $0]\033[0m Checked/Updated symlinks within ${HOME}/dotfiles."