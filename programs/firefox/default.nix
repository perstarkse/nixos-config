{
  programs.firefox = {
    enable = true;
    profiles = {
      options = {
        name = "p";
        settings = {
          #browser.startup.homepage = "https://nixos.org";
        };
        search = {
          force = true;
          default = "DuckDuckGo";
        };
      };
    };
  };
}
