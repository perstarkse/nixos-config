<<<<<<< HEAD
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
=======
{config, pkgs, lib, ...}:
{
  programs.i3status-rust = {
    enable = true;
    bars = {
      bottom = {
        theme = "dracula";
        icons = "awesome6";
        blocks = [
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
        {
          block = "battery";
        }
        ] ;
>>>>>>> cad52d1ee150a7f7be04c64fb8ed6e164577eda6
        };
      };
    };
in
{
  programs.i3status-rust = i3statusConfig;
}