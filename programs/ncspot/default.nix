{config, ...}: {
  programs.ncspot = {
    enable = true;
    settings = {
      gapless = true;
      use_nerdfont = true;
      ap_port = 443;
      keybindings = {
        "Esc" = "back";
      };
      # theme = {
      #   background = "#${config.lib.stylix.colors.base00}";
      #   primary = "#${config.lib.stylix.colors.base05}";
      #   title = "#${config.lib.stylix.colors.base0D}";
      #   playing = "#${config.lib.stylix.colors.base0D}";
      #   playing_selected = "#${config.lib.stylix.colors.base0A}";
      #   playing_bg = "#${config.lib.stylix.colors.base00}";
      #   highlight = "#${config.lib.stylix.colors.base05}";
      #   highlight_bg = "#${config.lib.stylix.colors.base02}";
      #   error = "#${config.lib.stylix.colors.base05}";
      #   error_bg = "#${config.lib.stylix.colors.base08}";
      #   statusbar = "#${config.lib.stylix.colors.base00}";
      #   statusbar_progress = "#${config.lib.stylix.colors.base0D}";
      #   statusbar_bg = "#${config.lib.stylix.colors.base0D}";
      #   cmdline = "#${config.lib.stylix.colors.base05}";
      #   cmdline_bg = "#${config.lib.stylix.colors.base00}";
      #   search_match = "#${config.lib.stylix.colors.base09}";
      # };
    };
  };
}
