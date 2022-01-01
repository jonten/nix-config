{ config, pkgs, ... }:
{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    # Configuration written to ~/.config/starship.toml
    settings = {
      add_newline = false;
			scan_timeout = 100;
      command_timeout = 1000;
      time = {
        disabled = false;
        style = "bright-black";
        format = "[$time]($style)";
      };
      right_format = "$time";
      format = "$all";
      #character = {
      #  success_symbol = "[➜](bold green)";
      #  error_symbol = "[➜](bold red)";
      #};
      package.disabled = true;
      line_break.disabled = true;
      directory = {
        truncation_length = 4; 
        truncation_symbol = "…/";
        style = "bold blue";
        home_symbol = "~";
        truncate_to_repo = false;
        read_only = " ";
      };				
      git_branch = {
        format = "[$branch]($style)";
        style = "yellow";
      };
			git_status = {
				format = "[[( $diverged$up_to_date$conflicted$untracked$modified$staged$renamed$deleted)](218) ($ahead_behind$stashed)]($style) ";
				style = "cyan";
        ahead = "⇡";
        behind = "⇣";
        diverged = "⇕";
        up_to_date = "";
				conflicted = "=";
				untracked = "?";
				modified = "!";
				staged = "+";
				renamed = "»";
				deleted = "✘";
				stashed = "≡";
			};
			git_state = {
				format = "\([$state( $progress_current/$progress_total)]($style)\) ";
				style = "yellow";
			};
      kubernetes = {
        disabled = true;
				symbol = "☸ ";
      };
      nix_shell = {
				symbol = " ";
        impure_msg = "[impure](red)";
        pure_msg = "[pure](green)";
        format = "[\($state( $name\))](bright-black) ";
      };
			aws = {
				symbol = "  ";
			};
			docker_context = {
				symbol = " ";
			};
			elixir = {
				symbol = " ";
        #version_format = "v${raw}";
			};
			elm = {
				symbol = " ";
        #version_format = "v${raw}";
			};
			gcloud = {
				symbol = "  ";
			};
			golang = {
				symbol = " ";
        #version_format = "v${raw}";
			};
			java = {
				symbol = " ";
        #version_format = "v${raw}";
			};
			package = {
				symbol = " ";
			};
			perl = {
				symbol = " ";
        #version_format = "v${raw}";
			};
			php = {
				symbol = " ";
        #version_format = "v${raw}";
			};
			python = {
				symbol = " ";
        #version_format = "v${raw}";
			};
			ruby = {
				symbol = " ";
        #version_format = "v${raw}";
			};
			rust = {
				symbol = " ";
        #version_format = "v${raw}";
			};
			scala = {
				symbol = " ";
        #version_format = "v${raw}";
			};
			shlvl = {
				symbol = " ";
			};
			swift = {
				symbol = "ﯣ ";
        #version_format = "v${raw}";
			};
    };
  };
}

