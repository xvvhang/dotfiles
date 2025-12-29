function theme
  set themes \
    flexoki \
    github \
    gruvbox \
    kanagawa \
    melange \
    tokyonight
  set selected_theme (printf "%s\n" $themes | fzf --prompt="Select a theme: " --no-preview)

  if test -z "$selected_theme"
    echo "No theme selected. Exiting."
    exit 1
  end

  # switch $selected_theme
  #   case flexoki
  #     set zed_theme "Flexoki Dark"
  #   case github
  #     set zed_theme "Github Dark Tritanopia"
  #   case gruvbox
  #     set zed_theme "Gruvbox Dark"
  #   case kanagawa
  #     set zed_theme "Kanagawa Dragon"
  #   case melange
  #     set zed_theme "Melange Dark"
  #   case tokyonight
  #     set zed_theme "Tokyo Night"
  # end

  # Change Ghostty theme
  set ghostty_dir $XDG_CONFIG_HOME/ghostty
  set ghostty_theme_file $ghostty_dir/$selected_theme
  set ghostty_current_file $ghostty_dir/current
  if test -f $ghostty_theme_file
    cp $ghostty_theme_file $ghostty_current_file
    echo "Ghostty set to $selected_theme"
  else
    echo "Theme file '$ghostty_theme_file' not found for Ghostty."
  end

  # Change Neovim theme
  set nvim_theme_dir $XDG_CONFIG_HOME/nvim/lua/themes
  set nvim_theme_file $nvim_theme_dir/$selected_theme.lua
  set nvim_current_file $nvim_theme_dir/current.lua
  if test -f $nvim_theme_file
    cp $nvim_theme_file $nvim_current_file
    echo "Neovim set to $selected_theme"
  else
    echo "Theme file '$nvim_theme_file' not found for Neovim."
  end

  # Change Zed theme
  # set zed_config $XDG_CONFIG_HOME/zed/settings.json
  # if test -f $zed_config
  #   sed '/^\/\//d' $zed_config | sed "s/\"theme\": \"[^\"]*\"/\"theme\": \"$zed_theme\"/" > $zed_config.tmp && mv $zed_config.tmp $zed_config
  #   echo "Zed set to $selected_theme"
  # else
  #   echo "Zed settings file not found."
  # end
end
