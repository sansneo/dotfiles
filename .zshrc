# Colors
autoload -U colors && colors
stty stop undef
export COLORTERM="truecolor"

# Completion
setopt noautomenu
setopt nomenucomplete

# Prompt
export PS1="%{$(tput setaf 9)%}%n%{$(tput setaf 15)%}@%{$(tput setaf 12)%}%m %{$(tput setaf 15)%}%~ %{$(tput sgr0)%}$ "

# History
export HISTSIZE=1000000
export HISTFILE="$HOME/.zhistory"
setopt inc_append_history
setopt interactive_comments

# Environment
export EDITOR="hx" VISUAL="$EDITOR"
export BROWSER="thorium.exe"
PATH="$PATH:/mnt/c/Users/Sans/AppData/Local/Thorium/Application"
PATH="$PATH:/mnt/c/Program Files/Microsoft VS Code/bin"
export PATH="$PATH:$HOME/marksman:$HOME/go/bin:~:$HOME/elixir/"

# Aliases
alias ls="ls -lh --group-directories-first --color=always"
alias l="ls" s="ls" sl="ls" lx="ls" la="ls -a"
alias cp="cp -v" mv="mv -v" rm="rm -v"
alias free="free -h" df="df -h" dh="dh -h"
alias objdump="objdump -M intel"
alias fd="fd --hidden" rg="rg --hidden"
alias sk="sk --margin 10% --color='bw'"
alias q="docker run --rm -it -v /etc/resolv.conf:/etc/resolv.conf ghcr.io/natesales/q"
alias azure-cli="docker run --rm -it -v /home/$USER/.azure:/root/.azure -v $PWD:/data mcr.microsoft.com/azure-cli"
alias tencent-cli="docker run --rm -it -v /home/$USER/.tencent:/root/.tencent -v $PWD:/data tencentcloud/tencentcloud-cli"
alias thorium="thorium.exe"

# Plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
zinit load ael-code/zsh-colored-man-pages
zinit load multirious/zsh-helix-mode
zinit load zdharma-continuum/fast-syntax-highlighting
zinit load zsh-users/zsh-history-substring-search
zhm-add-update-region-highlight-hook

# Bindings
bindkey -M hxnor 'k' history-substring-search-up
bindkey -M hxnor 'j' history-substring-search-down
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X" edit-command-line

# Cheat
function cheat() { curl -s cheat.sh/$1 }

# Tmux
[[ -z $TMUX && -z $VSCODE_INJECTION ]] && exec tmux new -As hxwiki -n main -c ~/hxwiki
