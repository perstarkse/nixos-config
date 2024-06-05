# NixOS Configuration with Flakes and Git-Agecrypt

This repository contains my NixOS and home-manager configurations, meticulously crafted for a consistent and reproducible experience across my machines. 

![Screenshot of my setup](screenshot.png)

## ✨ Features

- **Multiple Host Management:** Effortlessly manage configurations for different machines (Ariel, Charon, Encke, Makemake).
- **Streamlined Organization:**  Well-defined directories for hosts, overlays, packages, and programs ensure clarity and easy navigation.
- **Custom Packages:** Build and manage custom packages tailored to your specific needs.
- **Seamless Development:** A dedicated development shell is readily available via `nix develop`.
- **Robust Secrets Management:** Securely handle sensitive information using Git-Agecrypt and SOPS-Nix, integrating seamlessly with 1Password and pass for a smooth terminal experience.
- **Visually Unified Experience:** Enjoy a consistent look and feel across graphical and terminal environments, using stylix.

## 🚀 Getting Started

1. **Prerequisites:** Make sure you have NixOS installed. For optimal compatibility, consider using the latest stable version.
2. **Clone the Repository:** `git clone https://github.com/your-username/nixos-config.git`
3. **Unlock Secrets:** Initialize git-agecrypt and configure it to decrypt your secrets file.
4. **Explore:** Delve into the host-specific configurations under `hosts/` to understand the setup for each machine.
5. **Customize:** Tailor the configurations to your preferences. The well-structured directories simplify locating and modifying specific settings.
6. **Apply:** Use `nixos-rebuild switch` to apply the configuration to your chosen host.

## 📂 Directory Structure

```
├── hosts
│   ├── ariel
│   │   ├── boot.nix
│   │   ├── configuration.nix
│   │   ├── hardware-configuration.nix
│   │   └── home.nix
│   ├── charon
│   │   ├── boot.nix
│   │   ├── configuration.nix
│   │   ├── hardware-configuration.nix
│   │   ├── home.nix
│   │   ├── nvidia.nix
│   │   └── vfio
│   │       ├── default.nix
│   │       └── fix-vfio-troll.patch
│   ├── common
│   │   ├── configuration.nix
│   │   ├── gui.nix
│   │   ├── home.nix
│   │   └── sound.nix
│   ├── encke
│   │   ├── boot.nix
│   │   ├── configuration.nix
│   │   ├── hardware-configuration.nix
│   │   └── home.nix
│   └── makemake
│       ├── boot.nix
│       ├── configuration.nix
│       ├── hardware-configuration.nix
│       ├── home.nix
│       └── nixarr.nix
├── overlays
│   └── default.nix
├── pkgs
│   └── default.nix
└── programs
    ├── 1password
    │   └── default.nix
    ├── aerc
    │   └── default.nix
    ├── alacritty
    │   └── default.nix
    ├── development.nix
    ├── dunst
    │   └── default.nix
    ├── firefox
    │   └── default.nix
    ├── fish
    │   └── default.nix
    ├── gui.nix
    ├── helix
    │   └── default.nix
    ├── i3
    │   ├── default.nix
    │   └── keyboard_service.nix
    ├── i3status-rust
    │   ├── commonBlocks.nix
    │   └── default.nix
    ├── ncspot
    │   └── default.nix
    ├── qutebrowser
    │   └── default.nix
    ├── rofi
    │   └── default.nix
    ├── starship
    │   └── default.nix
    ├── terminal.nix
    ├── vscode
    │   └── default.nix
    └── xdg-user-dirs
        └── default.nix
```
