# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# Make bash append rather than overwrite the history on disk
shopt -s histappend

# Turn on programmable completion enhancements.
# Completions you add in ~/.bash_completion are sourced last.
[[ -f /etc/bash_completion ]] && . /etc/bash_completion

# History Options
#
# Don't put duplicate lines in the history.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups


# Aliases
if [ -f "${HOME}/.aliases" ]; then
    source "${HOME}/.aliases"
fi

PATH=/home/chrol/bin:$PATH
PS1="\[\e[33m\]\w\[\e[0m\] \$ "

set completion-ignore-case on
set completion-prefix-display-length 2
set show-all-if-ambiguous on
set show-all-if-unmodified on
set completion-map-case on
