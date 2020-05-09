# Enable smart completion
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# Functions
function emacs_alias            () { emacs "$@"            & }
function edit_bash_config_file  () { emacs "$HOME"/.bashrc & }
function edit_emacs_config_file () { emacs "$HOME"/.emacs  & }
function create_python3_virtualenv_project ()
{
    local project_name="$1"
    local project_activate_command="bin/activate"
    if [ -d "$project_name" ]
    then
        source "${project_name}/$project_activate_command"
        mkdir -p "${project_name}/src" && cd "${project_name}/src" && clear
    else
        virtualenv -p python3 "$project_name"
        source "${project_name}/$project_activate_command"
        pip install --upgrade pip
        pip install --upgrade jedi rope autopep8 yapf
        pip install --upgrade black flake8 ipython jupyter
        pip install --upgrade 'python-language-server[all]'
        mkdir "${project_name}/src" &&  cd "${project_name}/src"
        pip freeze > requirements.txt && clear
    fi
}

# Aliases
alias .="pwd"
alias x="exit"
alias c="clear"
alias ..="cd .."
alias ll="ls -l"
alias cp="cp -v"
alias mv="mv -v"
alias la="ls -la"
alias rm="rm -Iv"
alias h="history"
alias e="emacs_alias"
alias cb="edit_bash_config_file"
alias ce="edit_emacs_config_file"
alias pvp="create_python3_virtualenv_project"
alias geant4="source ~/.CERN/geant4/install/bin/geant4.sh"
alias root="source ~/.CERN/root/install/bin/thisroot.sh && root"

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

# 256 colors on the Linux terminal
export TERM=xterm-256color
# Bash history and prompt
export HISTSIZE=10240
export HISTCONTROL=ignoreboth:erasedups
export HISTIGNORE=".:..:c:h:x:cd:la:ll:ls"
export PS1="\[\e[1m\][\u] [\h] [\w]\n\\$ \[\e[0m\]"
# Update history file after every command
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
