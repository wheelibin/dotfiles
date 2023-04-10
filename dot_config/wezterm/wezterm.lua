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
}

-- window appearance
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
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
  Left = 'LeftArrow',
  Down = 'DownArrow',
  Up = 'UpArrow',
  Right = 'RightArrow',
  -- reverse lookup
  LeftArrow = 'Left',
  DownArrow = 'Down',
  UpArrow = 'Up',
  RightArrow = 'Right',
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
config.keys = {
  { key = 'h',         mods = 'SHIFT|ALT',      action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'v',         mods = 'SHIFT|ALT',      action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = 'UpArrow',   mods = 'SHIFT|ALT|CTRL', action = wezterm.action.DisableDefaultAssignment },
  { key = 'DownArrow', mods = 'SHIFT|ALT|CTRL', action = wezterm.action.DisableDefaultAssignment },

  -- move between split panes
  split_nav('LeftArrow', 'ALT'),
  split_nav('DownArrow', 'ALT'),
  split_nav('UpArrow', 'ALT'),
  split_nav('RightArrow', 'ALT'),

}

-- and finally, return the configuration to wezterm
return config
