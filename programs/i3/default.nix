{ config, lib, pkgs, ... }:

let 
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
        "${mod}+e" = "exec ${pkgs.rofi.override { plugins = [pkgs.rofi-emoji ]; }}/bin/rofi -modi emoji -show emoji";
        "${mod}+c" = "exec ${pkgs.rofi.override { plugins = [pkgs.rofi-calc]; }}/bin/rofi -modi calc -show calc";
        "${mod}+s" = "exec ${terminal} -e ${pkgs.ranger}/bin/ranger";        
        "${mod}+Print" = "exec blinkstick-scripts white";
        "${mod}+Shift+Print" = "exec blinkstick-scripts off";
        "${mod}+p" = "exec --no-startup-id sh -c \"setxkbmap -query | grep -q 'layout:\\\\s\\\\+us' && setxkbmap se || setxkbmap us\"";

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
            background = "#282A36";
            statusline = "#F8F8F2";
            separator = "#44475A";
            focusedWorkspace = {
              background = "#6272A4";
              text = "#F8F8F2";
              border = "#6272A4";
            }; 
          };
        }
      ];      
      colors = {
        focused = {
          background = "#6272A4";
          border = "#6272A4";
          childBorder = "#6272A4";
          indicator = "#6272A4";
          text = "#F8F8F2";
        };
        focusedInactive = {
          background = "#44475A";
          border = "#44475A";
          childBorder = "#44475A";
          indicator = "#44475A";
          text = "#F8F8F2";
        };
        unfocused = {
          background = "#282A36";
          border = "#282A36";
          childBorder = "#282A36";
          indicator = "#282A36";
          text = "#BFBFBF";
        };
        urgent = {
          background = "#44475A";
          border = "#FF5555";
          childBorder = "#FF5555";
          indicator = "#FF5555";
          text = "#F8F8F2";
        };
        placeholder = {
          background = "#282A36";
          border = "#282A36";
          childBorder = "#282A36";
          indicator = "#282A36";
          text = "#F8F8F2";
        };
      };
    };
  };
}