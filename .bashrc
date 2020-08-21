[ -z "$PS1" ] && return
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
export HISTCONTROL=ignoreboth
shopt -s histappend
shopt -s checkwinsize

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.bash_aliases_private ]; then
    . ~/.bash_aliases_private
fi

if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
fi

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=$PATH:~/sources/scripts/bin
source $HOME/.bashrc_private

source $HOME/.bash/gitprompt.sh