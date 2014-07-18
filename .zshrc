# Skip all this for non-interactive shells
[[ -z "$PS1" ]] && return

eval `dircolors -b`

## oh-my-zsh config

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

## end oh-my-zsh config

HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=100000
setopt appendhistory autocd
bindkey -e

autoload -U promptinit
promptinit

zstyle :compinstall filename '/home/chrols/.zshrc'

autoload -U compinit
compinit

source $HOME/.aliases
source $HOME/.env

# Customize to your needs...


source $HOME/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_STYLES[globbing]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[path]='bold'

PROMPT='%F{green}%n@%m%f %B%2c%b %F{blue}[%f '
RPROMPT='$(git_prompt_info) %F{blue}]%f[%! %?]'
#RPROMPT='$ %F{blue}] %F{green}%D{%L:%M} %F{yellow}%D{%p}%f'

ZSH_THEME_GIT_PROMPT_PREFIX="%F{yellow}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%f"
ZSH_THEME_GIT_PROMPT_DIRTY=" %F{red}*%f"
ZSH_THEME_GIT_PROMPT_CLEAN=""

setopt DVORAK
setopt NOCLOBBER # Don’t write over existing files with >, use >! instead

alias -s 'pdf=evince'
alias -s 'se=opera'
alias -s 'com=opera'

##Set some keybindings URXVT
###############################################
typeset -g -A key
bindkey '^?' backward-delete-char
bindkey '^[[7~' beginning-of-line
bindkey '^[[5~' up-line-or-history
bindkey '^[[3~' delete-char
bindkey '^[[8~' end-of-line
bindkey '^[[6~' down-line-or-history
bindkey '^[[A' up-line-or-search
bindkey '^[[D' backward-char
bindkey '^[[B' down-line-or-search
bindkey '^[[C' forward-char 
bindkey '^[[2~' overwrite-mode
#################################################

ZSH_BOOKMARKS="$HOME/.cdbookmarks"

function cdb_edit() {
	  $EDITOR "$ZSH_BOOKMARKS"
}

function cdb() {
	  local index
	    local entry
		  index=0
		    for entry in $(echo "$1" | tr '/' '\n'); do
				if [[ $index == "0" ]]; then
					local CD
					      CD=$(egrep "^$entry\\s" "$ZSH_BOOKMARKS" | sed "s#^$entry\\s\+##")
						        if [ -z "$CD" ]; then
									echo "$0: no such bookmark: $entry"
        break
		else
									cd "$CD"
      fi
								else
					cd "$entry"
      if [ "$?" -ne "0" ]; then
		  break
		  fi
	  fi
				let "index++"
  done
			}

function _cdb() {
	  reply=(`cat "$ZSH_BOOKMARKS" | sed -e 's#^\(.*\)\s.*$#\1#g'`)
	  }

compctl -K _cdb cdb

unsetopt correct_all
unsetopt correct

# OPAM configuration
. /home/chrols/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
