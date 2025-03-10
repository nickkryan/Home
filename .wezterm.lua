-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'N0tch2k'

config.keys = {
  { key = 'v',  mods = 'CTRL', action = wezterm.action.PasteFrom 'Clipboard'}
}

config.mouse_bindings = {
  -- Ctrl-click will open the link under the mouse cursor
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'CTRL',
    action = wezterm.action.OpenLinkAtMouseCursor,
  },
}

config.default_prog = { 'C:\\Program Files\\Git\\bin\\bash.exe', '-l'}

-- and finally, return the configuration to wezterm
return config