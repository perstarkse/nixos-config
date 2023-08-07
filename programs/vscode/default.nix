{pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions.vscode-marketplace; [
      dracula-theme.theme-dracula
      esbenp.prettier-vscode
      bbenoist.nix
      silverquark.dancehelix
      vue.volar
      vue.vscode-typescript-vue-plugin
      github.copilot
      github.copilot-chat
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
      };
      window = {
        zoomLevel = -1;
      };
      "[vue]" = {
        editor.defaultFormatter = "esbenp.prettier-vscode";
      };
    };
  };
}
