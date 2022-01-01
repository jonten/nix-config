{ config, pkgs, ... }:
{
  home.file.".wezterm.lua".text = ''
		local wezterm = require 'wezterm';
		-- Equivalent to POSIX basename(3)
		-- Given "/foo/bar" returns "bar"
		function basename(s)
			return string.gsub(s, "(.*[/\\])(.*)", "%2")
		end

		wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
			local pane = tab.active_pane
			local title = basename(pane.foreground_process_name) .. " " .. pane.pane_id
			local color = "gray"
			if tab.is_active then
				color = "navy"
			end
			return {
				{Background={Color=color}},
				{Text=" " .. title .. " "},
			}
		end)
    
		return {
			-- color_scheme = "Gruvbox Dark",
			color_scheme = "Ayu Mirage",
			window_background_opacity = 0.97,
			font = wezterm.font({family='JetBrains Mono', stretch="ExtraExpanded", weight="ExtraLight"}),
			font_size = 9.5,
			exit_behavior = "Close",
			adjust_window_size_when_changing_font_size = false,
			scrollback_lines = 100000,
			enable_scroll_bar = true,
			default_prog = { 'zsh' },
			check_for_updates = false
		}
	'';

  home.packages = with pkgs; [ wezterm ];
}
