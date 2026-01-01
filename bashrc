[[ $- != *i* ]] && return

export EDITOR=nvim
. "$HOME"/.config/env

alias ls='eza --icons -F -H --group-directories-first --git -1'
alias ll='eza --icons -F -H --group-directories-first --git -1 -alF'

eval "$(starship init bash)"
eval "$(zoxide init --cmd cd bash)"
