{
  programs.helix = {
    enable = true;
    defaultEditor = true;
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
