{ config, pkgs, ... }:
{
  home.file.".wezterm.lua".text = ''
		local wezterm = require 'wezterm';
		return {
			color_scheme = "Gruvbox Dark",
			-- color_scheme = "Ayu Mirage",
			window_background_opacity = 0.97,
			font = wezterm.font({family='JetBrains Mono', stretch="ExtraExpanded", weight="ExtraLight"}),
			font_size = 10,
			exit_behavior = "Close",
			adjust_window_size_when_changing_font_size = false,
			scrollback_lines = 100000,
			enable_scroll_bar = false,
			default_prog = { 'zsh' },
			check_for_updates = false,
      window_decorations = "RESIZE",
      hide_tab_bar_if_only_one_tab = true,
      use_fancy_tab_bar = false,
      keys = {
        -- paste from the clipboard
        {key="V", mods="CTRL", action=wezterm.action{PasteFrom="Clipboard"}},

        -- paste from the primary selection
        {key="V", mods="CTRL", action=wezterm.action{PasteFrom="PrimarySelection"}},
        
        -- activate quick select mode
        {key=" ", mods="SHIFT|CTRL", action="QuickSelect"},
      }
		}
	'';

  home.packages = [ pkgs.wezterm ];
}
