{ config, ... }:
    {
      programs.starship = {
        enable = true;
        enableFishIntegration = true;
        settings = {
          add_newline = false;

          # Prompt
          character = {
            success_symbol = "[➜](bold green)";
            error_symbol = "[✗](bold red)";
          };

          # Cloud Platforms
          aws.style = "bold #${config.lib.stylix.colors.base09}";
          gcloud.style = "bold #${config.lib.stylix.colors.base0D}";

          # System
          cmd_duration = {
            style = "bold #${config.lib.stylix.colors.base0C}";
            min_time = 500;
            format = "took [$duration]($style) ";
          };
          directory = {
            style = "bold #${config.lib.stylix.colors.base0A}";
            truncation_length = 3;
            truncate_to_repo = false;
          };
          hostname = {
            style = "bold #${config.lib.stylix.colors.base0D}";
            ssh_only = true;
            format = "at [$hostname]($style) ";
          };
          username = {
            style_user = "bold #${config.lib.stylix.colors.base0E}";
            style_root = "bold red";
            format = "[$user]($style) ";
            show_always = false;
          };

          # Git
          git_branch = {
            style = "bold #${config.lib.stylix.colors.base0B}";
            format = "[$symbol$branch]($style) ";
          };
          git_status = {
            style = "bold #${config.lib.stylix.colors.base08}";
          };

          # Languages and Frameworks
          nodejs.style = "bold #${config.lib.stylix.colors.base0B}";
          python.style = "bold #${config.lib.stylix.colors.base0E}";
          rust.style = "bold #${config.lib.stylix.colors.base09}";
          java.style = "bold #${config.lib.stylix.colors.base0D}";

          # Package Managers
          package.style = "bold #${config.lib.stylix.colors.base0F}";

          nix_shell = {
            disabled = false;
            format = "via [☃️ $state( \\($name\\))](bold blue) ";
          };
        };
      };
    }
