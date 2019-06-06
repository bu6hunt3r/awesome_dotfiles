# colors: magenta, green, blue,cyan, yellow, red
# prompt chars: ,λ ,› ,➤ ,∴ ,→ ,★ ,➜ ,❯

build_prompt_char() {
    local pc="$DOT_PROMPT_CHAR"
    local prompt_char="%(?.%F{magenta}.%F{red})${pc:-$}%f"
    echo -n "$prompt_char"
}