# Alias
# ---
# source zsh
alias zsrc='source ~/.zshrc'

# update and upgrade
alias apt-sync='sudo bash -c "apt update && apt upgrade"'

# alias for vscode
# alias code="/home/ting/.local/bin/code"


#
# alias k="kubectl"
# alias h="helm"
# alias tf="terraform"
# alias a="ansible"
# alias ap="ansible-playbook"

# alias code="open -a 'Visual Studio Code'"
# alias code="game-performance code"

alias gprj="cd $HOME/Projects"

# alias cd="z"
alias cl="clear"
# alias ls="eza --icons --group-directories-first"
# alias ll="eza --icons --group-directories-first -l"
# alias lsa="ls -a"
#
alias grep='grep --color'

# ---- Eza (better ls) -----
if command -v eza >/dev/null 2>&1; then
    alias ls="eza --icons=always"
    alias lsa="ls -a"
fi

# ---- lsd (better ls) -----
if command -v lsd >/dev/null 2>&1; then
    alias ls="lsd --color=always --icon=always"
fi

if command -v zoxide >/dev/null 2>&1; then
  alias cd="z"
fi 


# alias prx="ssh root@prx-prod-2.home.clcreative.de"

alias N="nvim ."
alias n="nvim"

alias vnvim=":e ~/.config/nvim-vscode/init.lua"

alias p="pnpm"

# source tmux inside tmux
alias txsrc='tmux source ~/.config/tmux/tmux.conf'
alias txkill='tmux kill-server'
alias txres='tmux -u a'
alias tx='tmux -u'

# lazygit
alias lg='lazygit'

#------ php ------#
alias pha='php artisan'
## generate key
alias pha:key-gen='php artisan key:generate'
## laravel sails
alias sail='sh $([ -f sail ] && echo sail || echo vendor/bin/sail)'
## php test
alias pht='php artisan test'

# Nix package manager Alias
alias nix-switch='home-manager switch --flake ~/dotfiles/nix/#$USER'

#---docker---#
alias d='docker'
alias ds1='docker start sql1'

