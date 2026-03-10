function theme
  set themes \
    flexoki \
    gruvbox \
    kanagawa \
    melange \
    tokyonight
  set selected_theme (printf "%s\n" $themes | fzf --prompt="Select a theme: " --no-preview)

  if test -z "$selected_theme"
    echo "No theme selected. Exiting."
    exit 1
  end

  # Change Ghostty theme
  set ghostty_dir $XDG_CONFIG_HOME/ghostty
  set ghostty_theme_file $ghostty_dir/theme

  # Detect OS color scheme (dark/light)
  set color_scheme (gsettings get org.gnome.desktop.interface color-scheme 2>/dev/null)
  if string match -q "*dark*" $color_scheme
    set os_mode dark
  else
    set os_mode light
  end

  # Resolve theme name. Some themes are built-in, others use custom files under themes/.
  if test "$selected_theme" = flexoki
    if test "$os_mode" = dark
      set ghostty_theme_name "Flexoki Dark"
    else
      set ghostty_theme_name "Flexoki Light"
    end
  else if test "$selected_theme" = gruvbox
    if test "$os_mode" = dark
      set ghostty_theme_name "Gruvbox Dark"
    else
      set ghostty_theme_name "Gruvbox Light"
    end
  else
    set ghostty_theme_name "$selected_theme-$os_mode"
    if not test -f $ghostty_dir/themes/$ghostty_theme_name
      echo "Note: '$ghostty_theme_name' not found, falling back to '$selected_theme-dark'."
      set ghostty_theme_name "$selected_theme-dark"
    end
  end

  # Parse current theme file (format: theme = light=X,dark=Y)
  set current_theme_line (cat $ghostty_theme_file 2>/dev/null)
  set current_light (string trim (string match -r 'light:([^,]+)' -- $current_theme_line)[2])
  set current_dark  (string trim (string match -r 'dark:([^,]+)'  -- $current_theme_line)[2])
  # Initialise slots if theme file uses old single-theme format
  if test -z "$current_light"
    set current_light "$selected_theme-dark"
  end
  if test -z "$current_dark"
    set current_dark "$selected_theme-dark"
  end

  # Update only the slot that matches the current OS mode
  if test "$os_mode" = dark
    set new_light $current_light
    set new_dark  $ghostty_theme_name
  else
    set new_light $ghostty_theme_name
    set new_dark  $current_dark
  end

  echo "theme = light:$new_light,dark:$new_dark" > $ghostty_theme_file
  echo "Ghostty $os_mode theme set to $ghostty_theme_name"

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

end
