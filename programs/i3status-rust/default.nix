{ config, lib, pkgs, ... }:

let
  commonBlocks = [
    {
      alert = 10.0;
      block = "disk_space";
      info_type = "available";
      interval = 60;
      path = "/";
      warning = 20.0;
    }
    {
      block = "custom";
      command = "cat /etc/hostname";
      interval = "once";
    }
    {
      block = "time";
      format = " $timestamp.datetime(f:'%a %d/%m %R') ";
      interval = 60;
    }
    {
      block = "sound";
    }
    {
      block = "custom";
      command = ''
      nmcli con show --active | grep wireguard | awk '{print $1 }'
      '';
      interval = 10;
    }
  ];

  hostname = builtins.readFile "/etc/hostname";

  i3statusConfig = if hostname == "ariel" then
    {
      enable = true;
      bars = {
        bottom = {
          theme = "dracula";
          icons = "awesome6";
          blocks = commonBlocks ++ [
            {
              block = "battery";
              interval = 10;
            }
          ];
        };
      };
    }
  else
    {
      enable = true;
      bars = {
        bottom = {
          theme = "dracula";
          icons = "awesome6";
          blocks = commonBlocks;
        };
      };
    };
in
{
  programs.i3status-rust = i3statusConfig;
}