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
source ~/.zsh.d/aliases.zsh
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
# ctf-tools: PATH setup
export PATH=/home/cr0c0/dev/ctf-tools/bin:$PATH

source ~/.options/shell-options.zsh
