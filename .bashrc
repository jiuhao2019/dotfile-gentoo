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
alias ls='ls --color=never'
alias grep='grep --color=auto'

eval "$(fzf --bash)"
# Print tree structure in the preview window
export FZF_ALT_C_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'tree -L 1 -d -C {}'"

alias l='ls -lha --file-type --group-directories-first'
alias ll='ls -1 --file-type --group-directories-first'
alias ..='cd ..'
alias pcmu='sudo pacman -Syu'
alias pru='paru -Syu'
alias mv='mv -i'
alias rm='rm -irv'
