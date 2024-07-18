{
  config,
  lib,
  pkgs,
  ...
}: let
  mod = "Mod4";
  terminal = "alacritty";
in {
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = mod;
      terminal = terminal;
      workspaceAutoBackAndForth = true;
      startup = [
        {
          command = "--no-startup-id ${pkgs.i3-auto-layout}/bin/i3-auto-layout";
          always = true;
        }
      ];
      keybindings = lib.mkOptionDefault {
        "${mod}+d" = "exec ${pkgs.rofi}/bin/rofi -show drun";
        "${mod}+Tab" = "exec ${pkgs.rofi}/bin/rofi -show window";
        "${mod}+z" = "exec ${pkgs.maim}/bin/maim -s | xclip -selection clipboard -t image/png";
        "${mod}+Control+l" = "exec ${pkgs.i3lock}/bin/i3lock -c 000000 && systemctl suspend";
        "${mod}+x" = "[urgent=latest] focus";
        "${mod}+e" = "exec ${pkgs.rofi.override {plugins = [pkgs.rofi-emoji];}}/bin/rofi -modi emoji -show emoji";
        "${mod}+c" = "exec ${pkgs.rofi.override {plugins = [pkgs.rofi-calc];}}/bin/rofi -modi calc -show calc";
        "${mod}+s" = "exec ${terminal} -e ${pkgs.ranger}/bin/ranger";
        "${mod}+Print" = "exec blinkstick-scripts white";
        "${mod}+Shift+Print" = "exec blinkstick-scripts off";
        "${mod}+p" = "exec --no-startup-id sh -c \"setxkbmap -query | grep -q 'layout:\\\\s\\\\+us' && setxkbmap se || setxkbmap us\"";
        # "${mod}+a" = "exec ${pkgs.rofi-pass}/bin/rofi-pass";
        "${mod}+a" = "exec ${pkgs.bitwarden-menu}/bin/bwm";

        "XF86AudioRaiseVolume" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume 0 +5%";
        "XF86AudioLowerVolume" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume 0 -5%";
        "XF86AudioMute" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-mute 0 toggle";

        "${mod}+Control+v" = "split h";

        # Focus
        "${mod}+h" = "focus left";
        "${mod}+j" = "focus down";
        "${mod}+k" = "focus up";
        "${mod}+l" = "focus right";

        # Move
        "${mod}+Shift+h" = "move left";
        "${mod}+Shift+j" = "move down";
        "${mod}+Shift+k" = "move up";
        "${mod}+Shift+l" = "move right";

        "${mod}+t" = "layout toggle split";
        "${mod}+y" = "layout stacking";
        "${mod}+Shift+space" = "floating toggle";
      };
      window = {
        titlebar = false;
        border = 2;
        hideEdgeBorders = "smart";
      };
      focus = {
        followMouse = true;
        mouseWarping = true;
      };
      bars = [
        {
          position = "bottom";
          statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-bottom.toml";
          colors = {
            background = "#${config.lib.stylix.colors.base00}";
            statusline = "#${config.lib.stylix.colors.base00}";
            separator = "#${config.lib.stylix.colors.base00}";
            focusedWorkspace = {
              background = "#${config.lib.stylix.colors.base0A}";
              text = "#${config.lib.stylix.colors.base00}";
              border = "#${config.lib.stylix.colors.base00}";
            };
            inactiveWorkspace = {
              background = "#${config.lib.stylix.colors.base01}";
              text = "#${config.lib.stylix.colors.base05}";
              border = "#${config.lib.stylix.colors.base00}";
            };
          };
        }
      ];
    };
  };
}
