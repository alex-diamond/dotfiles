# Enable smart completion
if [ -f /etc/bash_completion.d ]; then
    . /etc/bash_completion.d/hwloc-completion.bash
fi

# Aliases
alias .="pwd"
alias x="exit"
alias t="tree"
alias c="clear"
alias ..="cd .."
alias ll="ls -lh"
alias cp="cp -v"
alias mv="mv -v"
alias la="ls -lah"
alias rm="rm -Iv"
alias h="history"
alias sl="sl && clear"
alias cmc="cmatrix && clear"
alias aac="asciiquarium && clear"

# Functions
function EASF () { emacs "$@"            & }; alias ec="EASF"
function EBCF () { emacs "$HOME"/.bashrc & }; alias cb="EBCF"
function EECF () { emacs "$HOME"/.emacs  & }; alias ce="EECF"

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

# Emacs mode
set -o emacs
# A command name that is the name of a directory
# is executed as if it were the argument to the "cd" command
shopt -s autocd
# Minor errors in the spelling of a directory component
# in a "cd" command will be corrected
shopt -s cdspell
# Bash attempts spelling correction on directory names
# during word completion if the directory name
# initially supplied does not exist
shopt -s dirspell
# The pattern "**" used in a filename expansion context will
# match all files and zero or more directories and subdirectories
shopt -s globstar
# Bash lists the status of any stopped and running jobs
# before exiting an interactive shell
shopt -s checkjobs
# The history list is appended to the history file
shopt -s histappend
# Bash checks the window size after each command and
# updates the values of LINES and COLUMNS
shopt -s checkwinsize

export TERM=xterm-256color
# Bash history and prompt
export HISTSIZE=10240
export HISTCONTROL=ignoreboth:erasedups
export HISTIGNORE='.:..:c:h:x:cd:la:ll:ls'
PROMPT_DIRTRIM=2
show_git_branch ()
{
    git branch 2> /dev/null | \
        sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
export PS1='\n[\u] [\H] [\w]: [J: \j] $(show_git_branch)\n\$ '
# Update history file after every command
export PROMPT_COMMAND="history -a"
# Set default EDITOR
export EDITOR=emacs
export VISUAL="$EDITOR"

SOFTWARE_PATH=/mnt/DATA
CERN_PATH=$SOFTWARE_PATH/CERN
ROOT_PATH=$CERN_PATH/ROOT/install/bin
GEANT4_PATH=$CERN_PATH/Geant4/install/bin
if [ -f $ROOT_PATH/thisroot.sh ]; then
    source "$ROOT_PATH/thisroot.sh"
fi
if [ -f $GEANT4_PATH/geant4.sh ]; then
    source "$GEANT4_PATH/geant4.sh"
fi
