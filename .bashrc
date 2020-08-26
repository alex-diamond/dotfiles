set -o emacs
PROMPT_DIRTRIM=2

if [ -d /usr/share/bash-completion ]; then
    . /usr/share/bash-completion/bash_completion
fi

alias ..="cd .."
alias .2="cd ../.."
alias .3="cd ../../.."
alias .4="cd ../../../.."
alias .5="cd ../../../../.."
alias .="pwd"
alias aac="asciiquarium && clear"
alias addall="git add ."
alias c="clear"
alias cmc="cmatrix && clear"
alias commit="git commit -m"
alias cp="cp -v"
alias df="df -Tha --total"
alias du="du -ach | sort -h"
alias free="free -mt"
alias h="history"
alias la="ls -lah"
alias ll="ls -lh"
alias mkdir="mkdir -p"
alias mv="mv -v"
alias ps="ps auxf"
alias push="git push origin master"
alias reload="source ~/.bashrc"
alias rm="rm -Iv"
alias sl="sl && clear"
alias t="tree"
alias x="exit"

shopt -s autocd
shopt -s cdable_vars
shopt -s cdspell
shopt -s checkjobs
shopt -s checkwinsize
shopt -s cmdhist
shopt -s direxpand
shopt -s dirspell
shopt -s globstar
shopt -s histappend
shopt -s histreedit

export EDITOR=emacs
export HISTCONTROL=ignoreboth:erasedups
export HISTIGNORE=".:..:c:h:x:cd:la:ll:ls"
export HISTSIZE=10240
export PROMPT_COMMAND="history -a"
export PS1=$'\n\w \U25B6 '
export TERM=xterm-256color
export VISUAL="$EDITOR"

SOFTWARE_PATH=/mnt/DATA
CERN_PATH=$SOFTWARE_PATH/CERN
ROOT_PATH=$CERN_PATH/ROOT/install/bin
GEANT4_PATH=$CERN_PATH/Geant4/install/bin
if [ -f "$ROOT_PATH/thisroot.sh" ]; then
    source "$ROOT_PATH/thisroot.sh"
fi
if [ -f "$GEANT4_PATH/geant4.sh" ]; then
    source "$GEANT4_PATH/geant4.sh"
fi

if [ -f /usr/bin/tldr ]; then
    export TLDR_CODE="red"
    export TLDR_DESCRIPTION="green"
    export TLDR_HEADER="magenta bold underline"
    export TLDR_PARAM="blue"
    export TLDR_QUOTE="italic"
fi

if [ -f /usr/share/fzf/completion.bash ] && \
       [ -f /usr/share/fzf/key-bindings.bash ]; then
    source /usr/share/fzf/completion.bash
    source /usr/share/fzf/key-bindings.bash
    bind -m emacs-standard -x '"\C-f": fzf-file-widget'
    if [ -f /usr/bin/fd ]; then
        export FZF_DEFAULT_COMMAND="fd --type f --hidden"
    fi
    export FZF_DEFAULT_OPTS="-m --preview='head {}' --preview-window=right"
fi

function EASF () { emacs "$@"            & }; alias e="EASF"
function EBCF () { emacs "$HOME/.bashrc" & }; alias cb="EBCF"
function EECF () { emacs "$HOME/.emacs"  & }; alias ce="EECF"

function extract () {
    if [ -f "$1" ]; then
        case $1 in
            *.tar.bz2) tar        xjvf "$1" ;;
            *.tar.gz)  tar        xzvf "$1" ;;
            *.bz2)     bunzip2         "$1" ;;
            *.rar)     unrar      e    "$1" ;;
            *.gz)      gunzip          "$1" ;;
            *.tar)     tar        xvf  "$1" ;;
            *.tbz2)    tar        xjvf "$1" ;;
            *.tgz)     tar        xzvf "$1" ;;
            *.zip)     unzip           "$1" ;;
            *.Z)       uncompress      "$1" ;;
            *.7z)      7z         x    "$1" ;;
            *)         echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

function CP3VP ()
{
    local project_name="$1"
    local project_activate_command="bin/activate"
    function install_packages ()
    {
        virtualenv -p python3 "$project_name"
        source "$project_name/$project_activate_command"
        pip install --upgrade pip
        pip install --upgrade jedi rope autopep8 yapf
        pip install --upgrade black flake8 ipython jupyter
        pip install --upgrade 'python-language-server[all]'
        mkdir "$project_name/src" && cd "$project_name/src" || exit
        pip freeze > requirements.txt && clear && git init
    }
    if [ -d "$project_name" ]; then
        if [ -f "$project_name/$project_activate_command" ]; then
            source "$project_name/$project_activate_command"
            mkdir -p "$project_name/src" && cd "$project_name/src" && clear
        else
            install_packages
        fi
    else
        install_packages
    fi
}; alias pvp="CP3VP"
