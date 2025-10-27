set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_CACHE_HOME "$HOME/.cache"
set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx XDG_STATE_HOME "$HOME/.local/state"

set -gx EDITOR nvim

set -U pure_symbol_prompt "λ"

set -gx LESSHISTFILE '-'
set -gx FZF_DEFAULT_OPTS_FILE "$XDG_CONFIG_HOME/fzf/fzfrc"
set -gx TLRC_CONFIG "$XDG_CONFIG_HOME/tldr/config.toml"
set -gx _ZO_DATA_DIR "$XDG_DATA_HOME/zoxide"
set -gx NPM_CONFIG_USERCONFIG "$XDG_CONFIG_HOME/npm/npmrc"
set -gx PNPM_HOME "$XDG_DATA_HOME/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end

if test (uname -s) = Linux
  set -gx GTK_IM_MODULE fcitx
  set -gx QT_IM_MODULE fcitx
  set -gx XMODIFIERS @im=fcitx
end

function set-theme
  set themes \
    tokyonight-day \
    tokyonight-moon \
    tokyonight-night \
    tokyonight-storm
  set selected_theme (printf "%s\n" $themes | fzf --prompt="Select a theme: " --no-preview)

  if test -z "$selected_theme"
    echo "No theme selected. Exiting."
    exit 1
  end

  set ghostty_dir $XDG_CONFIG_HOME/ghostty
  set ghostty_theme_file $ghostty_dir/$selected_theme
  set ghostty_current_file $ghostty_dir/current
  if test -f $ghostty_theme_file
    cp $ghostty_theme_file $ghostty_current_file
    echo "Ghostty set to $selected_theme."
  else
    echo "Theme file '$theme_file' not found for Ghostty."
  end

  # Change nvim theme
  set nvim_theme_dir $XDG_CONFIG_HOME/nvim/lua/themes
  set nvim_theme_file $nvim_theme_dir/$selected_theme.lua
  set nvim_current_file $nvim_theme_dir/current.lua
  if test -f $nvim_theme_file
    cp $nvim_theme_file $nvim_current_file
    echo "Neovim set to $selected_theme."
  else
    echo "Theme file '$nvim_theme_file' not found for Neovim."
  end
end

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
abbr ghcs 'gh copilot suggest'
abbr ghce 'gh copilot explain'

if test (uname -s) = Darwin
  abbr bad 'brew install'
  abbr brm 'brew uninstall'
  abbr bup 'brew update'
  abbr bug 'brew upgrade'
  abbr bsc 'brew search'
  abbr bcl 'brew cleanup'
  abbr bls 'brew list'
  abbr blv 'brew leaves'
end

alias n='nvim'
alias g='lazygit'

alias st='set-theme'

alias dot='git --git-dir=$HOME/.dotfiles/ --work-tree=$XDG_CONFIG_HOME'
alias lazydot='lazygit --git-dir=$HOME/.dotfiles/ --work-tree=$XDG_CONFIG_HOME'

zoxide init fish | source
fzf --fish | source
