set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_CACHE_HOME "$HOME/.cache"
set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx XDG_STATE_HOME "$HOME/.local/state"

set -gx EDITOR nvim

set -gx pure_prompt_symbol '>'

set -gx LESSHISTFILE '-'
set -gx FZF_DEFAULT_OPTS_FILE "$XDG_CONFIG_HOME/fzf/fzfrc"
set -gx TLRC_CONFIG "$XDG_CONFIG_HOME/tldr/config.toml"
set -gx _ZO_DATA_DIR "$XDG_DATA_HOME/zoxide"
set -gx PNPM_HOME "$XDG_DATA_HOME/pnpm"

abbr bis 'brew install'
abbr bus 'brew uninstall'
abbr bup 'brew update'
abbr bug 'brew upgrade'
abbr bss 'brew search'
abbr bcl 'brew cleanup'
abbr blv 'brew leaves'
abbr gin 'git init'
abbr gcl 'git clone'
abbr gst 'git status'
abbr gdf 'git diff'
abbr gad 'git add'
abbr gada 'git add .'
abbr gcm 'git commit'
abbr gcmm 'git commit -m'
abbr gcma 'git commit --amend'
abbr gpl 'git pull'
abbr gps 'git push'
abbr gco 'git checkout'
abbr gcob 'git checkout -b'
abbr gbr 'git branch'
abbr gbrd 'git branch -d'
abbr gbrm 'git branch -D'
abbr gsw 'git switch'
abbr gswb 'git switch -b'
abbr gsh 'git stash'
abbr gshp 'git stash pop'
abbr gshd 'git stash drop'
abbr gshl 'git stash list'
abbr tns 'tmux new-session -s'
abbr tls 'tmux list-sessions'
abbr tks 'tmux kill-session -t'
abbr tas 'tmux attach -t'
abbr tka 'tmux kill-server'

alias n='nvim'
alias e='emacs'
alias g='lazygit'

alias dot='git --git-dir=$HOME/.dotfiles/ --work-tree=$XDG_CONFIG_HOME'
alias lazydot='lazygit --git-dir=$HOME/.dotfiles/ --work-tree=$XDG_CONFIG_HOME'

zoxide init fish | source
fzf --fish | source
fnm env --shell fish | source
glab completion -s fish | source

