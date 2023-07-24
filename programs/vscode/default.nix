{pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      dracula-theme.theme-dracula
      #vscodevim.vim
      esbenp.prettier-vscode
      github.copilot
      bbenoist.nix
    ];
    enableExtensionUpdateCheck = false;
    enableUpdateCheck = false;
    userSettings = {
      editor.inlineSuggest.enabled = true;
      workbench.colorTheme = "Dracula";
      editor.fontSize = 12;
      editor.fontFamily = "'Fira Code', 'monospace', monospace";
    };
  };
}
