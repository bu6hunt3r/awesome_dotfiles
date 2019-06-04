verifylink() {
    local symlink=${1:a}
    if [[ -e $symlink ]] && [[ ! -h $symlink ]]; then
        echo -e "${Yellow}$symlink${Rst} is a ${Red}regular${Rst} file on your system."
        echo -e "Rename/backup the file ${Yellow}$symlink${Rst}, and run the script again."
        exit 1
    fi
}