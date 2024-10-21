# Alias
# ---
# source zsh
alias zsrc='source ~/.zshrc'
#
alias k="kubectl"
alias h="helm"
alias tf="terraform"
alias a="ansible"
alias ap="ansible-playbook"

# alias code="open -a 'Visual Studio Code'"

alias gprj="cd $HOME/Projects"

alias cl="clear"
alias ls="eza --icons --group-directories-first"
alias ll="eza --icons --group-directories-first -l"
alias lsa="ls -a"
#alias grep='grep --color'

# alias prx="ssh root@prx-prod-2.home.clcreative.de"

alias N="nvim ."
alias n="nvim"

alias p="pnpm"

# source tmux inside tmux
alias txsrc='tmux source ~/.config/tmux/tmux.conf'
alias txkill='tmux kill-server'
alias txres='tmux -u a'
alias tx='tmux -u'
