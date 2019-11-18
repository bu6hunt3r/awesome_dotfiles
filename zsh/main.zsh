source ~/.zsh.d/constants.zsh
# load custom own shell_options from ~/.options/shell-options.zsh if present
source ~/.zsh.d/envbootstrap.zsh

# history settings / dir navigation options / glob options / better completion options
source ~/.zsh.d/options.zsh
# ANSI Color codes
source ~/.zsh.d/termcolors.zsh
# load autosuggestions module
source ~/.zsh.d/autosuggestions.zsh
# new bind keys in zsh
source ~/.zsh.d/fixescapecodes.zsh
# megabytes / kilobytes measurement & faster dir creation & bc utility
source ~/.zsh.d/functions.zsh
# load diverse aliases
# source ~/.zsh.d/aliases.zsh
# load git aliases
source ~/.zsh.d/git-aliases.zsh
# load docker aliases
source ~/.zsh.d/docker-aliases.zsh
# load emacs aliases
source ~/.zsh.d/alias-emacs.zsh
# load vim aliases
source ~/.zsh.d/alias-vim.zsh
# load prompt_settings
source ~/.zsh.d/prompt.zsh
# load plugin functionality
source ~/.zsh.d/dotplug.zsh

#load step
load_plugins

# init completion system
source ~/.zsh.d/completions.zsh

# colors for GNU ls (from coreutils)
#eval $(dircolors ~/.lscolors)

# Initialize fuzzy command line finder
source ~/.zsh.d/fzf.zsh

source ~/.zsh.d/syntax-highlighting.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

echo -e "\033[1;33m==== Loading aliases ====\033[0m"
lsd_installed=$(which lsd &>/dev/null)
if [[ -z $lsd_installed ]]; then
		lsd_prompt="\033[1;32m- [√] lsd installed...\033[0m"
		echo "alias ls='lsd'"  >> ~/.zsh.d/aliases.zsh
		echo "alias l='ls -l'" >> ~/.zsh.d/aliases.zsh
		echo "alias la='ls -a'"  >> ~/.zsh.d/aliases.zsh
		echo "alias lla='ls -la'" >> ~/.zsh.d/aliases.zsh
		echo "alias lt='ls --tree'" >> ~/.zsh.d/aliases.zsh
else
		lsd_prompt="\033[1;31m- [ ] lsd not installed...(also check for patched font -> https://github.com/ryanoasis/nerd-fonts/blob/master/readme.md)\033[0m"
fi

echo -e "$lsd_prompt"

# load diverse aliases
source ~/.zsh.d/aliases.zsh

# load tmux aliases
source ~/.config/zsh/.tmux_aliases
if [[ $? -eq 0 ]]; then
		echo -e "\033[1;32m- [√] tmux aliases loaded...\033[0m"
else
		echo -e "\033[1;31m- [ ] tmux aliases not loaded...\033[0m"
fi

# load virtualenv aliases
source ~/.config/zsh/.python_functions
if [[ $? -eq 0 ]]; then
		echo -e "\033[1;32m- [√] virtualenv aliases loaded...\033[0m"
else
		echo -e "\033[1;31m- [ ] virtualenv aliases not loaded...\033[0m"
fi


case "$(uname -s)" in
    Linux)
    if [[ -f "$HOME/.local/bin/virtualenvwrapper.sh" ]]; then
			virtualenvwrapper_prompt="\033[1;32m- [√] virtualenvwrapper installed...\033[0m"
			source "$HOME/.local/bin/virtualenvwrapper.sh"
		else
      virtualenvwrapper_prompt="\033[1;31m- [ ] virtualenvwrapper not installed...\033[0m"
		fi
		;;
esac

echo -e "$virtualenvwrapper_prompt"

echo ""
echo "\033[1;33m==== Loading zsh's config files (stow actions) ====\033[0m"
source "$HOME/.config/zsh/.zsh_path"
if [ $? -eq 0 ]; then
		echo -e "\033[1;32m- [√] loaded ~/.config/zsh/.zsh_path...(check within ~/.zshrc)\033[0m"
else
		echo -e "\033[1;31m- [ ] did not load ~/.config/zsh/.zsh_path...something went wrong...(check within ~/.zshrc)\033[0m"
fi

# General checks
echo ""
echo -e "\033[1;33m==== General checks ====\033[0m"
brew_installed=$(which brew &>/dev/null)
if [[ -z $brew_installed ]]; then
		brew_prompt="\033[1;32m- [√] brew installed...\033[0m"
else
		brew_prompt="\033[1;31m- [ ] brew not installed...\033[0m"
fi
echo -e "$brew_prompt"

tig_installed=$(which tig &>/dev/null)
if [[ -z $tig_installed ]]; then
		tig_prompt="\033[1;32m- [√] tig installed...\033[0m"
else
		tig_prompt="\033[1;31m- [ ] tig not installed...\033[0m"
fi
echo -e "$tig_prompt"


export ZSH_LOADED=1
