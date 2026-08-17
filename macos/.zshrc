export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=()

source "$ZSH/oh-my-zsh.sh"

source ~/.zsh_profile
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
