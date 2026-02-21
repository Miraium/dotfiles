local wezterm = require("wezterm")

local function is_wsl()
  local file = io.open("/proc/version", "r")
  if not file then
    return false
  end
  local version = file:read("*a")
  file:close()
  return version:lower():find("microsoft") ~= nil
end

local config = {
  font = wezterm.font_with_fallback({
    "Bizin Gothic NF",
    "JetBrainsMono Nerd Font",
    "CaskaydiaCove Nerd Font",
  }),
  font_size = 12.0,
  color_scheme = "Nord (Gogh)",
  hide_tab_bar_if_only_one_tab = true,
  use_fancy_tab_bar = false,
  window_background_opacity = 0.97,
  window_padding = {
    left = 8,
    right = 8,
    top = 8,
    bottom = 8,
  },
  keys = {
    { key = "v", mods = "CTRL|SHIFT", action = wezterm.action.PasteFrom("Clipboard") },
    { key = "c", mods = "CTRL|SHIFT", action = wezterm.action.CopyTo("Clipboard") },
    { key = "d", mods = "CTRL|SHIFT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { key = "D", mods = "CTRL|SHIFT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
    { key = "h", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Left") },
    { key = "j", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Down") },
    { key = "k", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Up") },
    { key = "l", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Right") },
  },
}

if is_wsl() then
  config.default_cwd = wezterm.home_dir
end

return config
