{pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.unstable.vscode;    
    extensions = with pkgs.vscode-extensions.vscode-marketplace; [
      esbenp.prettier-vscode
      bbenoist.nix
      silverquark.dancehelix
      vue.vscode-typescript-vue-plugin
      github.copilot
      github.copilot-chat
      ms-python.python
      ms-python.vscode-pylance
      juanblanco.solidity
      bradlc.vscode-tailwindcss
      rust-lang.rust-analyzer
      otovo-oss.htmx-tags
      # eamodio.gitlens
      # doublebot.doublebot
      # ms-vscode-remote.remote-containers
      ms-vscode-remote.remote-ssh
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      # {
      #   name = "gitlens";
      #   publisher = "eamodio";
      #   version = "2023.11.1604";
      #   sha256 = "sha256-d7xnghytDeUBcNzxAmlsLofxJCM3eTFOI7lzXS2bZME=";
      # }
      # {
      #   name = "op-vscode";
      #   publisher = "1password";
      #   version = "1.0.4";
      #   sha256 = "sha256-s6acue8kgFLf5fs4A7l+IYfhibdY76cLcIwHl+54WVk=";
      # }
      # {
      #   name = "remote-containers";
      #   publisher = "ms-vscode-remote";
      #   version = "0.329.0";
      #   sha256 = "sha256-6dPTOa2ZlIDF3QDsqBq78e01MSqyQVtWKVIhwhoZWfg=";
      # }
      # {
      #   name = "remote-ssh";
      #   publisher = "ms-vscode-remote";
      #   version = "0.107.1";
      #   sha256 = "sha256-LvfUcF5kl9YLGL/tq0wSTpyyfjDqsH9Ml9Cp1CK6PeE=";
      # }
      # {
      #   name = "copilot-chat";
      #   publisher = "github";
      #   version = "0.7.2023083101";
      #   sha256 = "sha256-ayarYtlRb4v/ran7utE0lXbLHEaUGfCT3DjnLmZJBmg=";
      # }
    ];
    enableExtensionUpdateCheck = false;
    enableUpdateCheck = false;
    mutableExtensionsDir = false;
    userSettings = {
      editor = {
        fontSize = 14.0;
        fontFamily = "'Fira Code', 'monospace', monospace";
        inlineSuggest.enabled = true;
        minimap.enabled = false;
        formatOnSave = true;      
      };
      files = {
        autoSave = "onFocusChanged";
      };
      workbench = {
        colorTheme = "Dracula";
        startupEditor = "none";
        editor.tabSizing = "fit";
      };
      remote = {
        SSH = {
          showLoginTerminal = true;
          useExecServer = false;
        };
      };
      terminal.integrated = {
        fontSize = 14.0;
      };
      git = {
        autofetch = true;
        suggestSmartCommit = true;
        pullBeforeCheckout = true;
        mergeEditor = true;
        closeDiffOnOperation = true;
        # autoStash = true;
        allowForcePush = true;
      };
      explorer.excludeGitIgnore = true;
      window = {
        zoomLevel = -0.4;
      };
      "[vue]" = {
        editor.defaultFormatter = "esbenp.prettier-vscode";
      };
      "[jsonc]" = {
        editor.defaultFormatter = "esbenp.prettier-vscode";
      };
      "[typescript]" = {
        editor.defaultFormatter = "esbenp.prettier-vscode";
      };
      "[typescriptreact]" = {
        editor.defaultFormatter = "esbenp.prettier-vscode";
      };
    };
  };
}
