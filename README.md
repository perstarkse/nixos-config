
NixOS Configuration Repository
This repository contains all configuration files for my NixOS system. It utilizes the Nix Flakes system to manage and reproduce the configurations across different hosts.

Below is a detailed description of the directory structure and configuration files:

📁 Root Directory
The root directory includes the main flake.nix and flake.lock files which drive the usage of Nix Flakes in this configuration.

flake.nix - The main flake configuration file.
flake.lock - The lock file generated from flake.
Other essential configuration files:

nixpkgs.nix - Specifies the Nix Packages collection to use.
shell.nix - Configuration for the development shell.
And the following directories:

hosts - Contains configuration for different hosts.
overlays - Contains Nixpkgs overlays.
pkgs - Contains package configurations.
programs - Contains program-specific configurations.

📁 Hosts
The hosts directory contains configurations specific to different machines:

📂 arbetshast
Configuration for the arbetshast machine.

boot.nix - Bootloader configuration.
configuration.nix - Main NixOS configuration.
hardware-configuration.nix - Hardware-specific configuration.
home.nix - Home manager configuration.
nvidia.nix - Nvidia drivers configuration.

📂 passthrough
Contains configuration and patch for enabling PCI passthrough:

default.nix - Configuration for the passthrough.
fix-vfio-troll.patch - Patch to fix vfio issues.

📂 common
Configuration for common settings across hosts:

configuration.nix - Main common configuration.
gui.nix - GUI-related configuration.
home.nix - Home manager configuration.
sound.nix - Sound configuration.

📂 vm-gui
Configuration for the vm-gui machine:

boot.nix - Bootloader configuration.
configuration.nix - Main NixOS configuration.
hardware-configuration.nix - Hardware-specific configuration.
home.nix - Home manager configuration.

📁 Overlays
default.nix - Contains Nixpkgs overlays.

📁 Pkgs
default.nix - Contains package configurations.

📁 Programs
Contains individual configurations for each of the programs.

For each program, there is a default.nix file that contains the program's configuration:

1password
alacritty
dunst
firefox
fish
gtk
helix
i3
keyboard_service.nix - Keyboard service configuration.
i3status-rust
ncspot
qutebrowser
rofi
dracula.rasi - Dracula theme for Rofi.
vscode
Also, it includes global configuration files for GUI and terminal:
  gui.nix
  terminal.nix