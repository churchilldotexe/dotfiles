# aliases for .zsh folder
[[ -f ~/.zsh/aliases.zsh ]] && source ~/.zsh/aliases.zsh
[[ -f ~/.zsh/functions.zsh ]] && source ~/.zsh/functions.zsh
# [[ -f ~/.zsh/starship.zsh ]] && source ~/.zsh/starship.zsh
[[ -f ~/.zsh/nvm.zsh ]] && source ~/.zsh/nvm.zsh
[[ -f ~/.zsh/wsl2fix.zsh ]] && source ~/.zsh/wsl2fix.zsh
# [[ -f ~/.zsh/goto.zsh ]] && source ~/.zsh/goto.zsh

export DISPLAY=:0
# if youre using wsl
# export BROWSER=~/.local/bin/wsl-browser

# uncomment if you're using homebrew
# eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"


# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# uncomment if you're using ubuntu with homebrew
# source /home/linuxbrew/.linuxbrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# source /home/linuxbrew/.linuxbrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# if youre using arch linux and installed with pacman
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# source /home/ting/.nix-profile/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
# source /home/ting/.nix-profile/share/zsh-autosuggestions/zsh-autosuggestions.zsh




# ---- oh my posh ---- # 
export PATH=$PATH:/home/ting/.local/bin
eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/ting.toml)"


# ---- Eza (better ls) -----

alias ls="eza --icons=always"

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"

alias cd="z"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# Node version manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pnpm
export PNPM_HOME="/home/tingexe/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Turso
export PATH="$PATH:/home/tingexe/.turso"


#php composer
export PATH="$PATH:$HOME/.config/composer/vendor/bin"
export PATH="/home/ting/.config/herd-lite/bin:$PATH"
export PHP_INI_SCAN_DIR="/home/ting/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"
