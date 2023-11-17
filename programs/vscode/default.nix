{pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.unstable.vscode;    
    extensions = with pkgs.vscode-extensions.vscode-marketplace; [
      dracula-theme.theme-dracula
      esbenp.prettier-vscode
      bbenoist.nix
      silverquark.dancehelix
      vue.volar
      vue.vscode-typescript-vue-plugin
      github.copilot
      # github.copilot-chat
      ms-python.python
      juanblanco.solidity
      bradlc.vscode-tailwindcss
      rust-lang.rust-analyzer
      otovo-oss.htmx-tags
      # eamodio.gitlens
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "gitlens";
        publisher = "eamodio";
        version = "2023.8.805";
        sha256 = "sha256-PohN1ckXeWI8YDvVjbhUEramdOH9PLiqIXktLBffmYg=";
      }
      {
        name = "copilot-chat";
        publisher = "github";
        version = "0.7.2023083101";
        sha256 = "sha256-ayarYtlRb4v/ran7utE0lXbLHEaUGfCT3DjnLmZJBmg=";
      }
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
    };
  };
}
