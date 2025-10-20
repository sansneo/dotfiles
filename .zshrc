# Colors
autoload -U colors && colors
stty stop undef
export COLORTERM="truecolor"

# Options
setopt noautomenu
setopt nomenucomplete
setopt interactive_comments
setopt appendhistory
setopt inc_append_history
setopt share_history
setopt hist_ignore_dups
setopt hist_ignore_space

# Prompt
export PS1="%{$(tput setaf 9)%}%n%{$(tput setaf 15)%}@%{$(tput setaf 12)%}%m %{$(tput setaf 15)%}%~ %{$(tput sgr0)%}$ "

# Environment
export HISTFILE=~/.history HISTSIZE=1000 SAVEHIST=1000
export EDITOR="hx" VISUAL="$EDITOR"
export BROWSER="firefox-developer-edition"
export PATH="$PATH:$HOME/go/bin"

# Aliases
alias ls="ls -gh --group-directories-first --color=always"
alias l="ls" s="ls" sl="ls" lx="ls" lc="ls"
alias cp="cp -v" mv="mv -v" rm="rm -v"
alias free="free -h" df="df -h" dh="dh -h"
alias fd="fd --hidden" rg="rg --hidden"
alias sk="sk --margin 10% --color='bw'"
# Dockerized
alias q="docker run --rm -it --network host ghcr.io/natesales/q"
alias kubectl="docker run --rm -it -v $HOME/.kube:/root/.kube -v $PWD:/app -w /app bitnami/kubectl"
alias aws-cli="docker run --rm -it -v $HOME/.aws:/root/.aws -v $PWD:/aws -w /aws amazon/aws-cli"
alias azure-cli="docker run --rm -it -v $HOME/.azure:/root/.azure -v $PWD:/azure -w /azure mcr.microsoft.com/azure-cli az"
alias tencent-cli="docker run --rm -it -v $HOME/.tencent:/root/.tencent -v $PWD:/tencent -w /tencent tencentcom/tencentcloud-cli"
alias terraform="docker run --rm -it -v $HOME/.terraform.d:/root/.terraform.d -v $PWD:/terraform -w /terraform hashicorp/terraform:light"
# Flatapks
alias heroic="flatpak run com.heroicgameslauncher.hgl"
alias krita="flatpak run org.kde.krita"
alias kdenlive="flatpak run org.kde.kdenlive"
alias rust-desk="XDG_SESSION_TYPE=x11 flatpak run com.rustdesk.RustDesk"
alias android-studio="flatpak run com.google.AndroidStudio"
# Using the system clipboard by default
alias xclip="xclip -selection clipboard"

# Plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
zinit load multirious/zsh-helix-mode
zinit load zsh-users/zsh-syntax-highlighting
zinit load zsh-users/zsh-history-substring-search
zhm-add-update-region-highlight-hook

# Bindings
bindkey -M hxnor 'k' history-substring-search-up
bindkey -M hxnor 'j' history-substring-search-down
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^E" edit-command-line

# Fixing highlighting colors
ZSH_HIGHLIGHT_STYLES[comment]=fg=green

# Tmux
# [[ $DISPLAY && -z $TMUX && -z $VSCODE_INJECTION ]] && exec tmux new -As life -n main -c ~/life
[[ $DISPLAY && -z $TMUX && -z $VSCODE_INJECTION ]] && exec tmux new -As home
