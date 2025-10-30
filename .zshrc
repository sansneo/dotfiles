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
setopt hist_ignore_dups
setopt hist_ignore_space

# Prompt
export PS1="%{$(tput setaf 9)%}%n%{$(tput setaf 15)%}@%{$(tput setaf 12)%}%m %{$(tput setaf 15)%}%~ %{$(tput sgr0)%}$ "

# Environment
export HISTFILE="$HOME/.history" HISTSIZE=10000 SAVEHIST=10000
export PATH="$PATH:$HOME/go/bin:$HOME/.flatpak"
export EDITOR="hx" VISUAL="$EDITOR"
export BROWSER="firefox"

# Aliases
alias ls="ls -gh --group-directories-first --color=always"
alias l="ls" s="ls" sl="ls" lx="ls" lc="ls"
alias cp="cp -v" mv="mv -v" rm="rm -v"
alias free="free -h" df="df -h" dh="dh -h"
alias fd="fd --hidden" rg="rg --hidden"
alias sk="sk --margin 10% --color='bw'"
# Dockerized
alias q="docker run --rm -it --network host ghcr.io/natesales/q"
alias adb="docker run --rm -it --network host --privileged -v /dev/bus/usb:/dev/bus/usb sorccu/adb adb"
alias fastboot="docker run --rm -it --network host --privileged -v /dev/bus/usb:/dev/bus/usb sorccu/adb fastboot"
alias kubectl="docker run --rm -it -v $HOME/.kube:/root/.kube -v $PWD:/app -w /app bitnami/kubectl"
alias aws-cli="docker run --rm -it -v $HOME/.aws:/root/.aws -v $PWD:/aws -w /aws amazon/aws-cli"
alias azure-cli="docker run --rm -it -v $HOME/.azure:/root/.azure -v $PWD:/azure -w /azure mcr.microsoft.com/azure-cli az"
alias tencent-cli="docker run --rm -it -v $HOME/.tencent:/root/.tencent -v $PWD:/tencent -w /tencent tencentcom/tencentcloud-cli"
alias terraform="docker run --rm -it -v $HOME/.terraform.d:/root/.terraform.d -v $PWD:/terraform -w /terraform hashicorp/terraform:light"

# Using the system clipboard
alias xclip="xclip -selection clipboard"

# Disabling the bottom bar
alias nsxiv="nsxiv --no-bar"

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
