[[ $- != *i* ]] && return

export EDITOR=nvim
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.rokit/bin:$PATH"

alias ls='eza --icons -F -H --group-directories-first --git -1'
alias ll='eza --icons -F -H --group-directories-first --git -1 -alF'

eval "$(starship init bash)"
eval "$(zoxide init --cmd cd bash)"
