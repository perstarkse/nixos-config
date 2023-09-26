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
      ms-python.python
      # eamodio.gitlens
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "gitlens";
        publisher = "eamodio";
        version = "2023.8.805";
        sha256 = "sha256-PohN1ckXeWI8YDvVjbhUEramdOH9PLiqIXktLBffmYg=";
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
