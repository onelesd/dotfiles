starship preset nerd-font-symbols -o ~/.config/starship.toml
eval "$(starship init zsh)"

export ZPLUG_HOME=/opt/homebrew/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug "zplug/zplug", hook-build:"zplug --self-manage"

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

source ~/.zsh/spaceship-section-aws-ext/spaceship-section-aws-ext.plugin.zsh
spaceship add awsext

SPACESHIP_PROMPT_ORDER=(
  time           # Time stamps section
  user           # Username section
  dir            # Current directory section
  host           # Hostname section
  git            # Git section (git_branch + git_status)
  hg             # Mercurial section (hg_branch  + hg_status)
  package        # Package version
  node           # Node.js section
  bun            # Bun section
  deno           # Deno section
  ruby           # Ruby section
  python         # Python section
  elm            # Elm section
  elixir         # Elixir section
  xcode          # Xcode section
  swift          # Swift section
  golang         # Go section
  perl           # Perl section
  php            # PHP section
  rust           # Rust section
  haskell        # Haskell Stack section
  scala          # Scala section
  kotlin         # Kotlin section
  java           # Java section
  lua            # Lua section
  dart           # Dart section
  julia          # Julia section
  crystal        # Crystal section
  docker         # Docker section
  docker_compose # Docker section
  aws            # Amazon Web Services section
  awsext         # Amazon Web Services extended section
  gcloud         # Google Cloud Platform section
  azure          # Azure section
  venv           # virtualenv section
  conda          # conda virtualenv section
  dotnet         # .NET section
  ocaml          # OCaml section
  vlang          # V section
  zig            # Zig section
  purescript     # PureScript section
  erlang         # Erlang section
  gleam          # Gleam section
  kubectl        # Kubectl context section
  ansible        # Ansible section
  terraform      # Terraform workspace section
  pulumi         # Pulumi stack section
  ibmcloud       # IBM Cloud section
  nix_shell      # Nix shell
  gnu_screen     # GNU Screen section
  exec_time      # Execution time
  async          # Async jobs indicator
  line_sep       # Line break
  battery        # Battery level and status
  jobs           # Background jobs indicator
  exit_code      # Exit code section
  sudo           # Sudo indicator
  char           # Prompt character
)

# erlang build options
# see: https://github.com/asdf-vm/asdf-erlang/issues/191
export CPPFLAGS="${CPPFLAGS+"$CPPFLAGS "}-I/opt/homebrew/opt/unixodbc/include"
export LDFLAGS="${LDFLAGS+"$LDFLAGS "}-L/opt/homebrew/opt/unixodbc/lib"
export KERL_CONFIGURE_OPTIONS="--with-odbc=/opt/homebrew/opt/unixodbc --disable-debug --without-javac --with-ssl=$(brew --prefix openssl@1.1)"
export KERL_BUILD_DOCS=yes

# eval "$(mise activate zsh)"
eval "$(direnv hook zsh)"

eval "$(zoxide init zsh)"

export FZF_DEFAULT_OPTS='--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# DISABLED because it remaps SHIFT-Up and SHIFT-Down which we want to use in vim
# define semantic zones
# see: https://gitlab.freedesktop.org/Per_Bothner/specifications/blob/master/proposals/semantic-prompts.md
# [ -f ~/.semantic_zones.sh ] && source ~/.semantic_zones.sh
# shell integrations for wezterm
[ -f ~/.zsh/wezterm.sh ] && source ~/.zsh/wezterm.sh

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

alias ls="eza"
alias ll="eza -Glar -t modified"
alias brewup="brew update; brew upgrade; brew cleanup; brew doctor"
alias bs="brew search"
alias bi="brew install"
alias grep="grep --color"
alias cat="bat"
alias neovide="neovide --fork" # detach from terminal

# git aliases
alias gs="git status"
alias gd="git diff"
alias ga="git add"
alias gc="git commit"
alias gl="git l"
alias lg="lazygit"
alias cdg="cd-gitroot"

# this file doesn't get cleaned up sometimes and causes job control (setopt monitor) to not work
[[ -f $_zplug_lock ]] && echo "You probably want to delete the zplug lockfile: $_zplug_lock"

# use GNU versions of packages when available
PATH="$(brew --prefix)/opt/grep/libexec/gnubin:$PATH"

export EDITOR="nvim"
export VISUAL="nvr --remote-tab +'set bufhidden=wipe'"

# add go path
PATH="$GOPATH/bin:$PATH"
GOPATH=$HOME/go
GOROOT="$(brew --prefix golang)/libexec"
PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"
PATH="$PATH:$HOME/bin"
PATH="$PATH:$HOME/.local/bin"

export GIT_SSH_COMMAND='ssh -i ~/.ssh/id_ed25519 -o IdentitiesOnly=yes'

[ -f $HOME/.zshenv ] && source $HOME/.zshenv
export PATH="$PATH:./node_modules/.bin"
eval "$(atuin init zsh)"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/dseleno/.cache/lm-studio/bin"
export PATH="$PATH:./node_modules/.bin"
