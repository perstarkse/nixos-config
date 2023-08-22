{config, pkgs, lib, ...}:

let
  cfg = config.services.keyboard-layout-switcher;
in

with lib;
{
  options.services.keyboard-layout-switcher = with types; {
    enable = mkEnableOption "enable the keyboard layout switched";
    defaultLayout = mkOption {
      default = "us";
      type = str;
      description = "the default layout";
    };
    optionalLayout = mkOption {
      default = "";
      type = str;
      description = "optional layout";
    };
    optionalLayoutPrograms = mkOption {
      default = [];
      type = listOf str;
      description = "list of programs for which the keyboard layout should be changed to the optional layout.";
    };
  };

 config =
   let
    changeKeyboardLayoutScript = pkgs.writeScript "keyboard-layout-switcher.sh" ''
    #!${pkgs.bash}/bin/bash

    ${pkgs.i3}/bin/i3-msg -t subscribe -m '[ "window", "focus" ]' | \
    ${pkgs.jq}/bin/jq --unbuffered -r 'select(.change == "focus").container.window_properties.instance' |
      while read -r window_class; do
        if echo '${builtins.concatStringsSep " " cfg.optionalLayoutPrograms}' | ${pkgs.gnugrep}/bin/grep -q "$window_class"; then
            ${pkgs.xorg.setxkbmap}/bin/setxkbmap ${cfg.optionalLayout}
        else
            ${pkgs.xorg.setxkbmap}/bin/setxkbmap ${cfg.defaultLayout}
        fi
       done
    '';
  in
  mkIf cfg.enable {
    systemd.user.services.keyboard-layout-switcher = {
    Unit = {
      Description = "Change keyboard layout based on focused i3 window";
      After = [ "graphical.target" ];
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
    Service = {       
      ExecStart = "${changeKeyboardLayoutScript}";
    };      
  };
};
}


