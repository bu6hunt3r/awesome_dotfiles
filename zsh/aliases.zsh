# ls
alias ls='ls --color=auto --group-directories-first -X'
alias l='ls -lh'
alias la='l -A'

# quick aliases
alias c='clear'
alias q='exit'
alias b='builtin cd ..'

alias w='echo -e "$Blue ${"$(pwd)"/$HOME/~} ${Red}at ${Cyan}$(whoami)${Red}@${Yellow}$(hostname -s)$Red \
using $Yellow${0}$Purple ${DOT_PROMPT_CHAR:-$}${Rst}"'

# apps
alias tarc='tar -zcvf'
alias tarx='tar -zxvf'

# zsh config
alias re='exec zsh'
alias dot='la $(find ~ -maxdepth 1 -type l)'

# dotfiles
alias r='~/.dotfiles/install.zsh'

# tmux
alias t='~/.dotfile/scripts/tmux/tmux-attach.sh'

# tgdb
alias tgdb='tmux new gdb -x ~/.tgdbinit'

# grc
if [[ -z `command grc` ]]; then
    echo "grc is not installed. grc aliases will be ignored."
else
    alias irclog="grc irclog"
    alias log="grc log"
    alias configure="grc configure"
    alias ping="grc ping"
    alias traceroute="grc traceroute"
    alias gcc="grc gcc"
    alias netstat="grc netstat"
    alias stat="grc stat"
    alias ss="grc ss"
    alias diff="grc diff"
    alias wdiff="grc wdiff"
    alias last="grc last"
    alias ldap="grc ldap"
    alias cvs="grc cvs"
    alias mount="grc mount"
    alias findmnt="grc findmnt"
    alias mtr="grc mtr"
    alias ps="grc ps"
    alias dig="grc dig"
    alias ifconfig="grc ifconfig"
    alias mount="grc mount"
    alias df="grc df"
    alias du="grc du"
    alias ipaddr="grc ipaddr"
    alias iproute="grc iproute"
    alias ipneighbor="grc ipneighbor"
    alias ip="grc ip"
    alias env="grc env"
    alias iptables="grc iptables"
    alias lspci="grc lspci"
    alias lsblk="grc lsblk"
    alias lsof="grc lsof"
    alias blkid="grc blkid"
    alias id="grc id"
    alias iostat_sar="grc iostat_sar"
    alias fdisk="grc fdisk"
    alias free="grc free"
    alias findmnt="grc findmnt"
    alias log="grc log"
    alias systemctl="grc systemctl"
    alias sysctl="grc sysctl"
    alias tcpdump="grc tcpdump"
    alias tune2fs="grc tune2fs"
    alias lsmod="grc lsmod"
    alias lsattr="grc lsattr"
    alias semanageboolean="grc semanageboolean"
    alias semanagefcontext="grc semanagefcontext"
    alias semanageuser="grc semanageuser"
    alias getsebool="grc getsebool"
    alias ulimit="grc ulimit"
    alias vmstat="grc vmstat"
    alias dnf="grc dnf"
    alias nmap="grc nmap"
    alias uptime="grc uptime"
    alias getfacl="grc getfacl"
    alias ntpdate="grc ntpdate"
    alias showmount="grc showmount"
    alias ant="grc ant"
    alias mvn="grc mvn"
    alias iwconfig="grc iwconfig"
    alias lolcat="grc lolcat"
    alias whois="grc whois"
fi
