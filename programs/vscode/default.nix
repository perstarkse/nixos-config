{pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    # package = (pkgs.vscode.override{ isInsiders = true; }).overrideAttrs (oldAttrs: rec {
    #   src = (builtins.fetchTarball {
    #     url = "https://update.code.visualstudio.com/latest/linux-x64/insider";
    #     sha256 = "13mk70fga643xhxf8lijmfkxk51dsfn36lbg51x99s77yabw3wcw";
    #   });
    #   version = "latest";
    #   buildInputs = oldAttrs.buildInputs ++ [ pkgs.krb5 ];
    # });     
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
        pullBeforeCheckout = true;
        mergeEditor = true;
        closeDiffOnOperation = true;
        autoStash = true;
        allowForcePush = true;
      };
      explorer.excludeGitIgnore = true;
      window = {
        zoomLevel = -1;
      };
      "[vue]" = {
        editor.defaultFormatter = "esbenp.prettier-vscode";
      };
    };
  };
}
