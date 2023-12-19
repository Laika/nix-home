#!/bin/bash -eu

# Name: .bashrc
# Author: Laika

aec() {
    if [[ $# -lt 1 ]]; then
        echo "Usage: $(basename "$0") <type> [color]"
        exit 1
    fi

    if [[ "${1,,}" =~ "reset" ]]; then
        echo -en "\e[0m"
    elif [[ "${1,,}" =~ "bold" ]]; then
        echo -en "\e[1m"
    elif [[ "${1,,}" =~ "italic" ]]; then
        echo -en "\e[3m"
    elif [[ "${1,,}" =~ "underscore" ]]; then
        echo -en "\e[4m"
    elif [[ "${1,,}" =~ "fg" ]]; then
        if [[ $# -lt 2 ]]; then
            __usage
        fi
        color=$2
        echo -en "\e[38;2;$((16#${color:0:2}));$((16#${color:2:2}));$((16#${color:4:2}))m"
    elif [[ "${1,,}" =~ "bg" ]]; then
        if [[ $# -lt 2 ]]; then
            __usage
        fi
        color=$2
        echo -en "\e[48;2;$((16#${color:0:2}));$((16#${color:2:2}));$((16#${color:4:2}))m"
    else
        echo "[-] Invalid type"
    fi
}

pathmunge() {
    if ! echo $PATH | grep -E -q "(^|:)$1($|:)"; then
        if [[ "$2" = "after" ]]; then
            PATH=$PATH:$1
        else
            PATH=$1:$PATH
        fi
    fi
}

share_history() {
    history -a
    history -c
    history -r
}

..() {
    [[ -f "$1" ]] && . "$1"
}

unique() {
    awk '!x[$0]++{print}'
}

# PROMPT_COMMAND_DISPATCHER
export PROMPT_COMMANDS=(share_history)
export PROMPT_COMMAND="prompt-command-dispatch"
prompt-command-dispatch() {
    export EXIT_STATUS=$?
    local command
    OLDIFS="${IFS}"
    IFS=';'
    for command in "${PROMPT_COMMANDS[@]}"; do
        eval "${command}"
    done
    unset command
    IFS="${OLDIFS}"
}

# History
shopt -s histappend
HISTTIMEFORMAT='%F %T '
HISTSIZE=100000
HISTFILESIZE=100000
HISTIGNORE='history:pwd:w:top:df *'
HISTCONTROL=ignoreboth

# shopt
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion

    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

shopt -s checkwinsize
shopt -s autocd
shopt -s cdspell
shopt -s dirspell
shopt -s globstar
shopt -s dotglob
shopt -s extglob
shopt -s nocaseglob

[[ -f ~/.scripts/git-prompt.sh ]] && . ~/.scripts/git-prompt.sh
[[ -f ~/.scripts/git-completion.sh ]] && . ~/.scripts/git-completion.sh
[[ -f /usr/share/doc/fzf/examples/key-bindings.bash ]] && . /usr/share/doc/fzf/examples/key-bindings.bash
[[ -f /usr/share/doc/fzf/examples/completion.bash ]] && . /usr/share/doc/fzf/examples/completion.bash

# PS1
parse_git_user() {
    git rev-parse 2>/dev/null
    inside_git="$?"
    if [ ${inside_git} = "0" ]; then
        git config --get user.name
    fi
}

export PROMPT_DIRTRIM=3

RED="$(aec fg 97365F)"
MAIN_COLOR="\[$(aec fg 364C97)\]"
RESET="$(aec reset)"
PS1_USER="${MAIN_COLOR}\u${RESET}"
PS1_SEP="${MAIN_COLOR}@${RESET}"
PS1_HOST="${MAIN_COLOR}\h${RESET}"
PS1_TTY="${MAIN_COLOR}[\$(basename $(tty))]\[${RESET}\]"
PS1_TIME="${MAIN_COLOR}\$(date '+%H:%M:%S')${RESET}"
PS1_PWD="${MAIN_COLOR}\w${RESET}"
#PS1_PWD=""
PS1_GIT() {
    if [[ $(command -v __git_ps1) && $(__git_ps1) ]]; then
        echo -en "${RED}"
        echo -en "[\u0427 $(__git_ps1 %s) | $(parse_git_user)]"
        echo -en "${RESET}"
    fi
}

PS1="${PS1_PWD} ${PS1_TIME} \$(PS1_GIT)\n\$ "
# PS1=${PS1_PWD}\n${GREEN}\$${RESET}

# Env
pathmunge "/usr/local/go/bin" after
pathmunge "${GOPATH}/bin" after
pathmunge "${HOME}/.cargo/bin" after
pathmunge "/opt/bfg" after
pathmunge "${HOME}/.scripts"
pathmunge "${HOME}/.local/bin"
pathmunge "/usr/local/musl/bin" after
pathmunge "/share/tools/lysithea"

# nodenv
export NODENV_ROOT="${HOME}/.nodenv"
pathmunge "${NODENV_ROOT}/bin"
[[ $(command -v nodenv) ]] && eval "$(nodenv init -)"

# goenv
export GOENV_ROOT="${HOME}/.goenv"
pathmunge "${GOENV_ROOT}/bin"
[[ $(command -v goenv) ]] && eval "$(goenv init -)"

# pyenv
export PYENV_ROOT="${HOME}/.pyenv"
pathmunge "${PYENV_ROOT}/bin"
[[ $(command -v pyenv) ]] && eval "$(pyenv init --path)"

# rbenv
export RBENV_ROOT="${HOME}/.rbenv"
pathmunge "${RBENV_ROOT}/bin"
[[ $(command -v rbenv) ]] && eval "$(rbenv init - bash)"

# r2env
export R2ENV_PATH="${HOME}/.r2env"
pathmunge "${R2ENV_PATH}/bin"

# deno
export DENO_INSTALL="${HOME}/.deno"
pathmunge "${DENO_INSTALL}/bin"

# zoxide
[[ $(command -v zoxide) ]] && eval "$(zoxide init bash)" || echo "[WARN] zoxide is not installed."

# LS_COLORS
[[ $(command -v vivid) ]] && export LS_COLORS="$(vivid generate dracula)" || echo "[WARN] vivid is not installed."

# swift
pathmunge "/usr/local/swift-5.8.1-RELEASE-ubuntu20.04/usr/bin"

# env
export BROWSER="/usr/bin/google-chrome-stable"
#export TERMINAL="kitty"
export SAM_CLI_TELEMETRY=0

# ripgrep
export RIPGREP_CONFIG_PATH="${HOME}/.ripgreprc"

# python
export PYTHONSTARTUP="${HOME}/.pythonstartup"

# tigress
export TIGRESS_HOME="/opt/tigress/3.1"
pathmunge "${TIGRESS_HOME}"

# Pulumi
pathmunge "${HOME}/.pulumi/bin"

# functions
s() {
    local ssh_host
    ssh_host=$(grep -i "^host" ${HOME}/.ssh/{config,conf.d/*} | awk '{print $2}' | fzf --border --height 40%)
    if [ "${ssh_host}" = "" ]; then
        return 1
    fi
    echo "[*] Connecting to ${ssh_host} via ssh ..."
    ssh "${ssh_host}"
}

open() {
    (xdg-open "$@" &>/dev/null &)
}

send-discord() {
    if [ "$*" = "" ]; then
        echo -n "{\"content\": \"$(echo -e \`\`\`$(cat)\`\`\`)\"}" | http POST https://discord.com/api/webhooks/1140308965318729748/AmsdtcSQPHZiQfI3C6DZkr5coB9uH_5tyzDdQcpbaqomryDfw6pU6tQgowWiPxGuZvI3
    else
        echo -n "{\"content\": \"$*\"}" | http POST https://discord.com/api/webhooks/1140308965318729748/AmsdtcSQPHZiQfI3C6DZkr5coB9uH_5tyzDdQcpbaqomryDfw6pU6tQgowWiPxGuZvI3
    fi
}

# fzf
export FZF_COMPLETION_TRIGGER='@'
export FZF_COMPLETION_OPTS='--border --info=inline'
[[ -f ~/.fzf.bash ]] && . ~/.fzf.bash

# Remove duplicate in PATH
remove_duplicate_path() {
    _path=""
    for _p in $(echo $PATH | tr ':' ' '); do
        case ":${_path}:" in
        *:"${_p}":*) ;;
        *)
            if [ "$_path" ]; then
                _path="$_path:$_p"
            else
                _path=$_p
            fi
            ;;
        esac
    done
    PATH=$_path

    unset _p
    unset _path
}

# GDB with Voltron
gdv() {
    tmux new-window -n "gdb" -P -F "#{pane_id}:#{pane_tty}" \
        gdb -q $@
    tmux split-window -h voltron view stack
    tmux split-window voltron view register
    tmux split-window -h voltron view disasm
    tmux select-pane -L && tmux select-pane -L
}
######################################

fzf-rm() {
    if [[ "$#" -eq 0 ]]; then
        local files
        files=$(find . -maxdepth 1 -type f | fzf --multi)
        echo $files | xargs -I '{}' rm {}
    else
        command rm "$@"
    fi
}

pacman-install() {
    pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S
}

pacman-remove() {
    pacman -Qq | fzf --multi --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rns
}

dot2pdf() {
    dot -Tpdf \
        -v \
        -Granksep=2 \
        -Gnodesep=1 \
        -Grankdir=LR \
        -Gsplines=ortho \
        $1 -o ${1%.dot}.pdf
}

.. "${HOME}/.rye/env"

export SAM_CLI_TELEMETRY=0

[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases

# starship
eval "$(starship init bash)"

[[ $(command -v rbw) ]] && eval "$(rbw gen-completions bash)"

export GTK_IM_MODULE="fcitx"
export QT_IM_MODULE="fcitx"
export XMODIFIERS='@im=fcitx'

export LIBRARY_PATH="${LIBRARY_PATH}:$(pyenv root)/versions/3.11.4/lib"

hn() {
    if [[ $(command -v hostname) ]]; then
        echo $(hostname)
    elif [[ $(command -v hostnamectl) ]]; then
        echo $(hostnamectl hostname)
    fi
}

# tmux
[[ -z ${TMUX} ]] && tmux new -A -s $(whoami)

[[ "$(whoami)" = "vagrant" ]] && export DISPLAY=192.168.56.1:0.0

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
