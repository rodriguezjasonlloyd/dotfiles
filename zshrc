plugins=(git)

osc7_cwd() {
    local hostname="${HOST:-$(hostname)}"
    local url_path="${PWD// /%20}"
    printf "\033]7;file://%s%s\033\\" "$hostname" "$url_path"
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd osc7_cwd

autoload -Uz compinit
compinit

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'

setopt extendedglob notify

alias ls='eza --icons -F -H --group-directories-first --git -1'
alias ll='eza --icons -F -H --group-directories-first --git -1 -alF'
alias hx=helix

eval "$(starship init zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(~/.local/bin/mise activate zsh)"
