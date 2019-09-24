# fetch zsh deps
echo "\033[1;33m[STATUS - $0]\033[0m Creating dir $zsh_deps."
mkdir -p $zsh_deps && cd $zsh_deps

# functionality 
dotgrab ninrod/zsh-bd
dotgrab ninrod/k

# completion
dotgrab ninrod/docker-zsh-completion
dotgrab ninrod/docker-compose-zsh-completion
dotgrab zsh-users/zsh-completions
dotgrab ninrod/pass-zsh-completion
dotgrab ninrod/gradle-zsh-completion
dotgrab zsh-users/zsh-autosuggestions
dotgrab zsh-users/zsh-syntax-highlighting
