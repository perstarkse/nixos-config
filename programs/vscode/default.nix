{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    package = pkgs.unstable.vscode;
    extensions = with pkgs.vscode-extensions.vscode-marketplace;
      [
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
        svelte.svelte-vscode
        ardenivanov.svelte-intellisense
        ms-vscode-remote.remote-ssh
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [];
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
        startupEditor = "none";
        editor.tabSizing = "fit";
      };
      remote = {
        SSH = {
          showLoginTerminal = true;
          connectTimeout = 30;
          useExecServer = true;
          localServerDownload = "always";
          logLevel = "trace";
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
      svelte.enable-ts-plugin = true;
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
      "[svelte]" = {
        "editor.defaultFormatter" = "svelte.svelte-vscode";
      };
    };
  };
}
