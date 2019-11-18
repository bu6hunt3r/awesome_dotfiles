# colors: magenta, green, blue,cyan, yellow, red
# prompt chars: ,λ ,› ,➤ ,∴ ,→ ,★ ,➜ ,❯

build_prompt_char() {
    local pc="$DOT_PROMPT_CHAR"
    local prompt_char="%(?.%F{magenta}.%F{red})${pc:-$}%f"
    echo -n "$prompt_char"
}
# default: showing whoami@hostname without truncation

PROMPT_INFO_LEVEL=$SHELL_PROMPT_INFO_LEVEL

# 0: showing only PWD with trunction
# 1: showing @hostname and with truncation
# 2: showing whaami@hostname and with truncation
if [[ "${PROMPT_INFO_LEVEL}" == "0"  ]]; then
  PROMPT="%B%F{grey}%20<...<%1~%<<%f $(build_prompt_char)%b "
  # PROMPT="$(build_prompt_char) "
elif [[ "${PROMPT_INFO_LEVEL}" == "1"  ]]; then
  PROMPT="%F{blue}%13<...<%1~%<<%f %F{red}@%f%F{yellow}%m%f $(build_prompt_char) "
elif [[ "${PROMPT_INFO_LEVEL}" == "2"  ]]; then
  PROMPT="%F{blue}%13<...<%1~%<<%f %F{cyan}%n%f%F{red}@%f%F{yellow}%m%f $(build_prompt_char) "
fi

if [[ -f $HOME/.options/shell-options.zsh ]]; then
    source $HOME/.options/shell-options.zsh
fi
