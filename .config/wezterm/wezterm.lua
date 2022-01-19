local wezterm = require 'wezterm';
return {
  font = wezterm.font("Iosevka Nerd Font"),
  font_size = 14.0,
  color_scheme = "Gruvbox Dark",
  default_cursor_style = "BlinkingBar",
  cursor_blink_rate = 500,
  force_reverse_video_cursor = true,
  use_fancy_tab_bar = true,
  hide_tab_bar_if_only_one_tab = true,
  tab_bar_at_bottom = false,
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },
  window_decorations = "RESIZE",
  native_macos_fullscreen_mode = false,
  use_ime = true,
}
