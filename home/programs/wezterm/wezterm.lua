local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

config.automatically_reload_config = true
config.enable_tab_bar = false
config.window_close_confirmation = "NeverPrompt"
config.default_cursor_style = "BlinkingBar"
config.font = wezterm.font("JetBrains Mono", { weight = "Regular" })
config.check_for_updates = false
config.use_fancy_tab_bar = true
config.tab_bar_at_bottom = false
config.color_scheme = "Catppuccin Mocha (Gogh)"
config.hide_tab_bar_if_only_one_tab = false
config.tab_and_split_indices_are_zero_based = false

config.window_decorations = "RESIZE"

config.window_background_opacity = 0.75
-- config.macos_window_background_blur = 10

-- This is where you actually apply your config choices
config.font_size = 14.0
config.line_height = 1.1

-- For example, changing the color scheme:


config.window_padding = {
  left = 8,
  right = 8,
  top = 8,
  bottom = 0,
}
config.leader = { key = "a", mods = "CMD", timeout_milliseconds = 1000 }

config.colors = {
  foreground = "#D9E0EE",
  background = "#09090b",
  cursor_bg = "#F5E0DC",
  cursor_fg = "#1E1D2F",
  cursor_border = "#F5E0DC",
  selection_fg = "#1E1D2F",
  selection_bg = "#F5E0DC",
  scrollbar_thumb = "#6E6C7E",
  split = "#6E6C7E",

  ansi = {
    "#6E6C7E",
    "#F28FAD",
    "#ABE9B3",
    "#FAE3B0",
    "#96CDFB",
    "#F5C2E7",
    "#89DCEB",
    "#D9E0EE",
  },
  brights = {
    "#988BA2",
    "#F28FAD",
    "#ABE9B3",
    "#FAE3B0",
    "#96CDFB",
    "#F5C2E7",
    "#89DCEB",
    "#D9E0EE",
  },
  indexed = {
    [16] = "#F8BD96",
    [17] = "#F5E0DC",
  },
  tab_bar = {
    background = "#2c2e33",
    active_tab = {
      bg_color = "#14161b",
      fg_color = "#e0e2ea",
      intensity = "Bold",
    },
    inactive_tab = {
      bg_color = "#2c2e33",
      fg_color = "#c4c6cd",
    },
    inactive_tab_hover = {
      bg_color = "#4f5258",
      fg_color = "#e0e2ea",
      italic = true,
    },
    new_tab = {
      bg_color = "#2c2e33",
      fg_color = "#c4c6cd",
    },
    new_tab_hover = {
      bg_color = "#4f5258",
      fg_color = "#e0e2ea",
      italic = true,
    },
  },
}

config.keys = {
  -- Pane management
  { key = "\\", mods = "CMD", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { key = "|",  mods = "CMD", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "z",  mods = "CMD", action = wezterm.action.TogglePaneZoomState },
  { key = "c",  mods = "CMD", action = wezterm.action.CloseCurrentPane({ confirm = true }) },

  -- Tab management
  { key = "t",  mods = "CMD", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
  { key = "w",  mods = "CMD", action = wezterm.action.CloseCurrentTab({ confirm = true }) },

  -- Copy/Paste
  { key = "c",  mods = "CMD", action = wezterm.action.CopyTo("Clipboard") },
  { key = "v",  mods = "CMD", action = wezterm.action.PasteFrom("Clipboard") },

  -- Font size
  { key = "=",  mods = "CMD", action = wezterm.action.IncreaseFontSize },
  { key = "-",  mods = "CMD", action = wezterm.action.DecreaseFontSize },
  { key = "0",  mods = "CMD", action = wezterm.action.ResetFontSize },

  -- Scrollback
  -- { key = 'k',  mods = 'CMD', action = wezterm.action.ClearScrollback 'ScrollbackOnly' },
  { key = "f",  mods = "CMD", action = wezterm.action.Search("CurrentSelectionOrEmptyString") },

  -- Quick select mode
  { key = "s",  mods = "CMD", action = wezterm.action.QuickSelect },

  -- Disable default CMD+m binding
  { key = "m",  mods = "CMD", action = wezterm.action.DisableDefaultAssignment },
  {
    key = "k",
    mods = "CMD",
    action = act.Multiple({
      act.ClearScrollback("ScrollbackAndViewport"),
      act.SendKey({ key = "L", mods = "CTRL" }),
    }),
  },
  {
    key = "l",
    mods = "CMD",
    action = act.Multiple({
      act.ClearScrollback("ScrollbackAndViewport"),
      act.SendKey({ key = "L", mods = "CTRL" }),
    }),
  },
}

-- The filled in variant of the < symbol
local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider

-- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

config.tab_bar_style = {
  -- active_tab_left = wezterm.format {
  --   { Background = { Color = '#0b0022' } },
  --   { Foreground = { Color = '#2b2042' } },
  --   { Text = SOLID_LEFT_ARROW },
  -- },
  -- active_tab_right = wezterm.format {
  --   { Background = { Color = '#0b0022' } },
  --   { Foreground = { Color = '#2b2042' } },
  --   { Text = SOLID_RIGHT_ARROW },
  -- },
  -- inactive_tab_left = wezterm.format {
  --   { Background = { Color = '#0b0022' } },
  --   { Foreground = { Color = '#1b1032' } },
  --   { Text = SOLID_LEFT_ARROW },
  -- },
  -- inactive_tab_right = wezterm.format {
  --   { Background = { Color = '#0b0022' } },
  --   { Foreground = { Color = '#1b1032' } },
  --   { Text = SOLID_RIGHT_ARROW },
  -- },
}
-- tmux status
-- wezterm.on("update-right-status", function(window, _)
--   local ARROW_FOREGROUND = { Foreground = { Color = "#c6a0f6" } }
--   local prefix = ""

--   if window:leader_is_active() then
--     prefix = " " .. utf8.char(0x1f30a) -- ocean wave
--     SOLID_LEFT_ARROW = utf8.char(0xe0b2)
--   end

--   if window:active_tab():tab_id() ~= 0 then
--     ARROW_FOREGROUND = { Foreground = { Color = "#1e2030" } }
--   end -- arrow color based on if tab is first pane

--   window:set_left_status(wezterm.format({
--     { Background = { Color = "#b7bdf8" } },
--     { Text = prefix },
--     ARROW_FOREGROUND,
--     { Text = SOLID_LEFT_ARROW },
--   }))
-- end)

-- Directory name in tab title
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local current_dir = (string.gsub(tab.active_pane.current_working_dir.path, "/$", ""))
  local home_dir = "/" .. wezterm.home_dir:gsub("\\", "/")
  return current_dir == home_dir and tab.tab_index + 1 .. ": ~ "
      or tab.tab_index + 1 .. ": " .. string.gsub(current_dir, "(.*[/\\])(.*)", "%2") .. " "
end)



config.hyperlink_rules = {
  -- Matches: a URL in parens: (URL)
  {
    regex = "\\((\\w+://\\S+)\\)",
    format = "$1",
    highlight = 1,
  },
  -- Matches: a URL in brackets: [URL]
  {
    regex = "\\[(\\w+://\\S+)\\]",
    format = "$1",
    highlight = 1,
  },
  -- Matches: a URL in curly braces: {URL}
  {
    regex = "\\{(\\w+://\\S+)\\}",
    format = "$1",
    highlight = 1,
  },
  -- Matches: a URL in angle brackets: <URL>
  {
    regex = "<(\\w+://\\S+)>",
    format = "$1",
    highlight = 1,
  },
  -- Then handle URLs not wrapped in brackets
  {
    -- Before
    --regex = '\\b\\w+://\\S+[)/a-zA-Z0-9-]+',
    --format = '$0',
    -- After
    regex = "[^(]\\b(\\w+://\\S+[)/a-zA-Z0-9-]+)",
    format = "$1",
    highlight = 1,
  },
  -- implicit mailto link
  {
    regex = "\\b\\w+@[\\w-]+(\\.[\\w-]+)+\\b",
    format = "mailto:$0",
  },
}


return config
