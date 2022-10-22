-- config: https://wezfurlong.org/wezterm/config/lua/config/index.html
local wezterm = require 'wezterm';

wezterm.on(
  "update-right-status",
  function(window)
    local date = wezterm.strftime("%Y-%m-%d %H:%M:%S ")
    window:set_right_status(
      wezterm.format(
        {
          { Text = date }
        }
      )
    )
  end
)

-- change the title of tab to current working directory.
-- ref:
-- https://wezfurlong.org/wezterm/config/lua/window-events/format-tab-title.html#format-tab-title
-- https://wezfurlong.org/wezterm/config/lua/PaneInformation.html
-- https://wezfurlong.org/wezterm/config/lua/pane/get_current_working_dir.html
wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    local pane = tab.active_pane
    -- cwd is a URI with file:// as beginning
    local cwd = pane.current_working_dir

    local home_dir = os.getenv('HOME')
    -- remove the prefix from directory
    local res = string.sub(cwd, 8)
    -- shorten the path by using ~ as $HOME.
    return string.gsub(res, home_dir, '~')
  end
)


return {
  font = wezterm.font_with_fallback({
    "IBM Plex Mono",
    -- "Azeret Mono",
    -- "Iosevka Nerd Font",
    -- "Noto Sans SC",
  }),
  font_size = 13,
  line_height = 1.2,
  cell_width = 0.9,
  -- color scheme can be found here: https://github.com/mbadolato/iTerm2-Color-Schemes/tree/master/wezterm
  color_scheme = "Solarized Dark - Patched",
  default_cursor_style = "BlinkingBar",
  cursor_blink_rate = 400,
  force_reverse_video_cursor = false,
  enable_tab_bar = true,
  use_fancy_tab_bar = true,
  hide_tab_bar_if_only_one_tab = true,
  tab_bar_at_bottom = false,
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },
  window_decorations = "TITLE | RESIZE",
  native_macos_fullscreen_mode = false,
  send_composed_key_when_left_alt_is_pressed = false,
  send_composed_key_when_right_alt_is_pressed = false,
  use_ime = true,
  window_background_opacity = 1.0,
  -- term = "wezterm",
  -- set term to wezterm will break the nvim titlestring option, see https://github.com/wez/wezterm/issues/2112
  term = "xterm-256color",
  automatically_reload_config = false,
}
