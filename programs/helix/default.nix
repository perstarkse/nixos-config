{inputs, ...}:
{
  programs.helix = {
    enable = true;
    #package = inputs.helix-master.packages."x86_64-linux".default;
    settings = {
      theme = "dracula";
      editor = {
        line-number = "relative";
        lsp.display-messages = true;
        soft-wrap = {
          enable = true;
        };
        file-picker = {
          hidden = true;
        };
      };
    };
  };
}
