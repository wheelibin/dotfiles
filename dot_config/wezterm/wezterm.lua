-- Pull in the wezterm API
local wezterm = require 'wezterm'
local action = wezterm.action

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- theme
-- config.color_scheme = 'Melange Dark'
-- config.color_scheme = 'Catppuccin Mocha'
-- config.color_scheme = 'Gruvbox Material'
-- config.color_scheme = 'OneDark (base16)'
-- config.color_scheme = 'Gruvbox Material (Gogh)'
-- config.colors = {
--   cursor_fg = '#2C2E34'
-- }
config.color_scheme = 'nightfox'

-- fonts
-- config.font = wezterm.font { family = 'Fira Code' }
-- config.font = wezterm.font { family = 'Hack' }
-- config.font = wezterm.font { family = 'Source Code Pro' }
config.font_size = 20

-- window appearance
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
config.inactive_pane_hsb = {
  saturation = 0.6,
  brightness = 0.8,
}

config.enable_tab_bar = false
config.adjust_window_size_when_changing_font_size = false


-- smart splits
--
-- Equivalent to POSIX basename(3)
-- Given "/foo/bar" returns "bar"
-- Given "c:\\foo\\bar" returns "bar"
local function basename(s)
  return string.gsub(s, '(.*[/\\])(.*)', '%2')
end

local function is_vim(pane)
  local process_name = basename(pane:get_foreground_process_name())
  return process_name == 'nvim' or process_name == 'vim'
end

local direction_keys = {
  Left = 'm',
  Down = 'n',
  Up = 'e',
  Right = 'i',
  -- reverse lookup
  m = 'Left',
  n = 'Down',
  e = 'Up',
  i = 'Right',
}

local function split_nav(key, mods)
  return {
    key = key,
    mods = mods,
    action = wezterm.action_callback(function(win, pane)
      if is_vim(pane) then
        -- pass the keys through to vim/nvim
        win:perform_action({
          SendKey = { key = key, mods = 'ALT' },
        }, pane)
      else
        win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
      end
    end),
  }
end

-- key bindings
config.disable_default_key_bindings = true

config.keys = {
  { key = 'N',     mods = 'SHIFT|CTRL', action = action.SpawnWindow },
  { key = 'Enter', mods = 'META',       action = action.TogglePaneZoomState },
  { key = 'h',     mods = 'SHIFT|ALT',  action = action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'v',     mods = 'SHIFT|ALT',  action = action.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = '-',     mods = 'SHIFT|CTRL', action = action.DecreaseFontSize },
  { key = '+',     mods = 'SHIFT|CTRL', action = action.IncreaseFontSize },

  -- clipboard
  { key = 'c',     mods = 'SUPER',      action = action.CopyTo 'Clipboard' },
  { key = 'c',     mods = 'SHIFT|CTRL', action = action.CopyTo 'Clipboard' },
  { key = 'v',     mods = 'SUPER',      action = action.PasteFrom 'Clipboard' },
  { key = 'v',     mods = 'SHIFT|CTRL', action = action.PasteFrom 'Clipboard' },

  -- move between split panes
  split_nav('m', 'ALT'),
  split_nav('n', 'ALT'),
  split_nav('e', 'ALT'),
  split_nav('i', 'ALT'),

}

-- and finally, return the configuration to wezterm
return config
