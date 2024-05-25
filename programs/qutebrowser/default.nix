{inputs, pkgs, ...}:
{
  programs.qutebrowser = {
    enable = true;
    package = pkgs.unstable.qutebrowser;
    keyBindings = {
      normal = {
        "P" = "hint links spawn ${pkgs.mpv}/bin/mpv {hint-url}";
        "j" = "scroll-px 0 700";
        "k" = "scroll-px 0 -700";
      };
    };
    settings = {
      editor.command = ["alacritty" "--command" "hx" "{file}"]; 
      content.javascript.clipboard = "access-paste";
    };
  };
}
