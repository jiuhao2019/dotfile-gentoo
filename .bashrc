# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi


# Put your fun stuff here.
alias grep='grep --color=auto'

eval "$(fzf --bash)"
# Print tree structure in the preview window
export FZF_ALT_C_COMMAND="ls -d */ | sort"
export FZF_ALT_C_OPTS="--preview 'ls -1 --file-type --group-directories-first {}' --height 40% --reverse"

alias l='ls -lha --file-type --group-directories-first'
alias ll='ls -1 --file-type --group-directories-first'
alias ls='ls --file-type --color=never'
alias ..='cd ..'
alias mv='mv -i'
alias rm='rm -irv'
