# s: get megabtye measurement {{{
# usage : s [-h] [path]
s() {
    if [[ -z ${1+x} ]]; then
        # no argument passed. measure current dir including hidden files.
        # summarize / -m specifies block size
        du -sm *(D) | sort -nr | head -n 20
        return 0
    fi
    # an argument was passed
    if [[ $1 = '-h' ]]; then
        # -h switch: human readable size output, but it is not suitable for ordering with, e.g., command sort.
        if [[ -n ${2+x} ]]; then
            # if a path was passed, apply -h to the path
            du -sh $2
            return 0;
        else
            # if a path was not passed, apply -h switch to all files, including hidden files
            du -sh *(D)
        fi
    else
        # bogus argument. print error
        print -l "bogus argument. check function documentation."
    fi
}
# }}}
# sk: get kilobytes measurement. for human readable output check the s function {{{

# usage: s [path] {{{
sk() {
    if [[ -z ${1+x} ]]; then
        # no argument passed. measure current dir including hidden files
        du -sk *(D) | sort -nr | head -n 20
        return 0;
    fi
    # argument passed.
    du -sk $1 | sort -nr | head -n 20
}
# }}}
# md: faster dir creation
md() {
    mkdir -p $1
    builtin cd $1
}
# }}}
# n: easy run project local npm executables {{{
n() {
    $(npm bin)/$@
}
#}}}
# =: front for `bc` utility {{{
= () {
    bc -l <<< "$@"
}
#}}}

# Kill process
# Fuzzy process search -> kill the selected process
#
function fkill() {
	local pid
	pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

	if [ "x$pid" != "x" ]; then
		echo $pid | xargs kill -${1:-9}
	fi
}
