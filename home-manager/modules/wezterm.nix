{ config, pkgs, ... }:
{
  home.file.".wezterm.lua".text = ''
		local wezterm = require 'wezterm';
		return {
			color_scheme = "Gruvbox Dark",
			-- color_scheme = "Ayu Mirage",
			window_background_opacity = 0.97,
			font = wezterm.font({family='JetBrains Mono', stretch="ExtraExpanded", weight="ExtraLight"}),
			font_size = 9.5,
			exit_behavior = "Close",
			adjust_window_size_when_changing_font_size = false,
      hide_tab_bar_if_only_one_tab = true,
			scrollback_lines = 100000,
			enable_scroll_bar = true,
			default_prog = { 'zsh' },
			check_for_updates = false
		}
	'';

  home.packages = with pkgs; [ wezterm ];
}
