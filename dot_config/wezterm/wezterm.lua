-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- theme
config.color_scheme = 'Melange Dark'

-- fonts
config.font = wezterm.font { family = 'Fira Code' }
config.font_size = 20
config.font_rules = {
  -- disable italics
  {
    intensity = 'Normal',
    italic = true,
    font = wezterm.font { family = 'Fira Code' }
  },
  {
    intensity = 'Normal',
    italic = false,
    font = wezterm.font { family = 'Fira Code' }
  },
}

-- window appearance
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
config.enable_tab_bar = false

-- key bindings
config.keys = {
  { key = 'h', mods = 'SHIFT|ALT', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'v', mods = 'SHIFT|ALT', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
}

-- and finally, return the configuration to wezterm
return config
