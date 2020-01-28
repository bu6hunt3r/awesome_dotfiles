verifylink() {
    local symlink=${1:a}
    if [[ -e $symlink ]] && [[ ! -h $symlink ]]; then
        echo -e "\t${Yellow}$symlink${Rst} is a ${Red}regular${Rst} file on your system."
        echo -e "Rename/backup the file ${Yellow}$symlink${Rst}, and run the script again."
        exit 1
    fi
}

updatelinks() {
    local symlink=${1:a}
    local symlink_old_target=${1:A}
    local symlink_new_target=${2:A}
    if [[ ! -h $symlink ]]; then
        echo -e "\t$symlink ${Green}->${Rst} $symlink_new_target"
    elif [[ $symlink_old_target != $symlink_new_target ]]; then
        rm $symlink 
        echo -e "\t$1 ${Red}-${Black}X${Rst}->${Rst} $symlink ${Green}->${Rst} $symlink_new_target"
    else
        echo -e "\t$1 ${Green}ok.${Rst}"
        return 0
    fi

    ln -s $symlink_new_target $symlink
}

# dotgrab function
build_git_url() {
    local name="$1"
    local gitservermask="https://github.com/"
    if [[ -n ${GITMASK+X} ]]; then
        gitservermask=$GITMASK
    fi
    local url=${gitservermask}${name}.git
    echo $url
}

# dotgrab function
git_clone_error_msg() {
    if [[ ! $1 = 0 ]]; then
        echo -e "${Red}[ERROR]${Rst} git clone finished with return code: ${Red}${1}${Rst}. ${Yellow}aborting...${Rst}"
        echo -e "-------------------"
        return $1
    fi
}

# simplest dependency fetcher known to mankind
if [[ "$1" == "update" ]]; then

    dotgrab() {
        local name="$1"
        local cwd=$(readlink -f .)
        cd $name
        echo -e "-------------------"
        echo -e "${Yellow}Performing git status${Rst} on [${Green}${name}${Rst}]."

        git fetch -v

        # hack lifted from http://stackoverflow.com/a/3278427/4921402
        LOCAL=$(git rev-parse @)
        REMOTE=$(git rev-parse @{u})
        BASE=$(git merge-base @ @{u})
        if [[ $LOCAL = $REMOTE ]]; then
            echo "${Cyan}${name}${Rst} is already ${Blue}Up-to-date${Rst}."
        elif [[ $LOCAL = $BASE ]]; then
            echo "${Cyan}${name}${Rst}  ${Yellow}needs a pull${Rst} Performing git pull..."
            git pull --rebase; rc=$?
            if [[ ! $rc = 0 ]]; then
            echo -e "${Red}[ERROR]${Rst} git pull returned code: ${Red}${rc}${Rst}. ${Yellow}aborting...${Rst}"
            echo -e "-------------------"
            return $rc
            fi
            echo -e "${Blue}[Success]${Rst} ${Green}$name${Rst} successfully ${Cyan}updated${Rst}."
        elif [[ $REMOTE = $BASE ]]; then
            echo "${name} needs to be ${Red}pushed${Rst}. Wait, What? You should not be commiting here. Or perhaps history was rewritten in upstream. You may have to issue a ${Yellow}git reset --hard origin/master.${Rst}"
        else
            echo "${name} needs to be ${Red}rebased and pushed${Rst}. Wait, What? You should not be commiting here."
        fi

        cd $cwd
        echo -e "-------------------"
        }

else

    dotgrab() {
    local name="$1"
    local url=$(build_git_url $name)
    local ref=$2
    echo "" && echo "-------------------"
    if [[ -d $name ]]; then
        echo -e "[${Green}${name}${Rst}] already cloned from ${Blue}${url}${Rst}"
    else
        echo -e "[${Red}${name}${Rst}] not cloned. cloning now from ${Blue}${url}${Rst}"
        if [[ -n ${2+x} ]]; then
        echo -e "the ref: ${Yellow}${ref}${Rst} was passed. Performing ${Blue}full${Rst} clone."

        git clone $url $name; rc=$?; git_clone_error_msg $rc
        if [[ ! $rc = 0 ]]; then
            return $rc
        fi

        local cwd=$(readlink -f .)
        cd $name
        git checkout --quiet $ref
        echo -e "[${Green}performing checkout${Rst}] ${Yellow}$(git branch --no-color --quiet --column=dense)${Rst}"
        cd $cwd
        else
        echo -e "no ref to checkout. ${Yellow}shallow${Rst} cloning."
        git clone --depth 1 $url $name; rc=$?; git_clone_error_msg $rc
        if [[ ! $rc = 0 ]]; then
            return $rc
        fi
        fi
        echo -e "[${Green}${name}${Rst}] sucessfully cloned."
    fi
    echo -e "-------------------"
    }
fi


echo "\033[1;33m[STATUS - $0]\033[0m Loaded git management functions."