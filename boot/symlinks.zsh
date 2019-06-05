# deploy symlinks

cd $GIT_ROOT
for file in ./**/deploy.zsh;
    source $file
done

verifylink ~/.dotfiles
updatelink ~/.dotfiles .