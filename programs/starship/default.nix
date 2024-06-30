{config, ...}
: {
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      #add_newline = true;
      aws.style = "bold #${config.lib.stylix.colors.base09}";
      cmd_duration.style = "bold #${config.lib.stylix.colors.base04}";
      directory.style = "bold #${config.lib.stylix.colors.base0A}";
      hostname.style = "bold #${config.lib.stylix.colors.base0A}";
      git_branch.style = "bold #${config.lib.stylix.colors.base09}";
      git_status.style = "bold #${config.lib.stylix.colors.base08}";
      username = {
        format = "[$user]($style) on ";
        style_user = "bold #${config.lib.stylix.colors.base04}";
      };
      character = {
        success_symbol = "[λ](bold #${config.lib.stylix.colors.base08})";
        error_symbol = "[λ](bold #${config.lib.stylix.colors.base08})";
      };
    };
  };
}
