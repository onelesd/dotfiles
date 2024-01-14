# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZPLUG_HOME=/opt/homebrew/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug "zplug/zplug", hook-build:"zplug --self-manage"

zplug romkatv/powerlevel10k, as:theme, depth:1
zplug "zsh-users/zsh-completions",              defer:0
zplug "zsh-users/zsh-autosuggestions",          defer:2, on:"zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting",      defer:3, on:"zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-history-substring-search", defer:3, on:"zsh-users/zsh-syntax-highlighting"

zplug "mafredri/zsh-async", from:"github", use:"async.zsh"
zplug "djui/alias-tips"
zplug "supercrabtree/k"
zplug "felixr/docker-zsh-completion"
# zplug "plugins/globalias", from:oh-my-zsh
zplug "mollifier/cd-gitroot", from:"github", use:"cd-gitroot.plugin.zsh"

# Install plugins if there are plugins that have not been installed
if ! zplug check; then
   zplug install
fi

# Load everything
zplug load

# . /opt/homebrew/opt/asdf/libexec/asdf.sh

eval "$(mise activate zsh)"

export FZF_DEFAULT_OPTS='--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# DISABLED because it remaps SHIFT-Up and SHIFT-Down which we want to use in vim
# define semantic zones
# see: https://gitlab.freedesktop.org/Per_Bothner/specifications/blob/master/proposals/semantic-prompts.md
# [ -f ~/.semantic_zones.sh ] && source ~/.semantic_zones.sh
# shell integrations for wezterm
# [ -f ~/.wezterm.sh ] && source ~/.wezterm.sh

# no c-s/c-q output freezing
setopt noflowcontrol
# enable job control
setopt monitor
# this is default, but set for share_history
setopt inc_append_history
setopt HIST_IGNORE_ALL_DUPS

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# enable ... while waiting for completions
expand-or-complete-with-dots() {
    # toggle line-wrapping off and back on again
    [[ -n "$terminfo[rmam]" && -n "$terminfo[smam]" ]] && echoti rmam
    print -Pn "%{%F{red}...%f%}"
    [[ -n "$terminfo[rmam]" && -n "$terminfo[smam]" ]] && echoti smam

    zle expand-or-complete
    zle redisplay
}
zle -N expand-or-complete-with-dots
bindkey "^I" expand-or-complete-with-dots

alias ll="ls -Glart"
alias ls="ls -G1"
alias bup="brew update; brew upgrade; brew cleanup; brew doctor"
alias bs="brew search"
alias bi="brew install"
alias grep="grep --color"

# git aliases
alias gs="git status"
alias gd="git diff"
alias ga="git add"
alias gc="git commit"
alias gl="git l"
alias lg="lazygit"
alias cdg="cd-gitroot"
alias pgit="GIT_SSH_COMMAND='ssh -i ~/.ssh/github-onelesd -o IdentitiesOnly=yes' git"
alias nvs="rush update && rush build --to-except=web --to-except=nvs-test-environment ; say 'NVS Rebuild complete' && echo -n 'Press [Enter] to continue or [Ctrl-C] to quit' ; read"

# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# this file doesn't get cleaned up sometimes and causes job control (setopt monitor) to not work
[[ -f $_zplug_lock ]] && echo "You probably want to delete the zplug lockfile: $_zplug_lock"

eval $(thefuck --alias)

# use GNU versions of packages when available
PATH="$(brew --prefix)/opt/grep/libexec/gnubin:$PATH"

# add emacs doom to path
PATH="${HOME}/.emacs.d/bin:$PATH"

export EDITOR="nvim"
export VISUAL="nvr --remote-tab +'set bufhidden=wipe'"

# add go path
PATH="$GOPATH/bin:$PATH"
GOPATH=$HOME/go
GOROOT="$(brew --prefix golang)/libexec"
PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"
PATH="$PATH:$HOME/bin"
# PATH="$PATH:$HOME/.asdf/installs/rust/1.58.1/bin"
PATH="$PATH:$HOME/.local/bin"

alias localstack="DISABLE_EVENTS=1 localstack"
export AWS_PROFILE="NIKE.SSO.AdminRole"
export AWS_REGION="us-west-2"
export GIT_SSH_COMMAND='ssh -i ~/.ssh/id_rsa -o IdentitiesOnly=yes'

[ -f $HOME/work/nvs-code/common/zsh/nvs-code-helpers.zsh ] && source $HOME/work/nvs-code/common/zsh/nvs-code-helpers.zsh

[ -f $HOME/.zshenv ] && source $HOME/.zshenv
