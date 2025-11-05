plugins=(git)

fpath=(~/.zsh/completions $fpath)

autoload -Uz compinit
compinit

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'

setopt extendedglob notify

alias ls='eza --icons -F -H --group-directories-first --git -1'
alias ll='eza --icons -F -H --group-directories-first --git -1 -alF'

eval "$(starship init zsh)"
eval "$(zoxide init --cmd cd zsh)"
