{pkgs, options, config, ... }: 
{
  xdg.userDirs = {
    enable = true;
    desktop = "${config.home.homeDirectory}/desktop";
    documents = "${config.home.homeDirectory}/documents";
    download = "${config.home.homeDirectory}/download";
    pictures = "${config.home.homeDirectory}/pictures";
    music= "${config.home.homeDirectory}/music";
    templates = "${config.home.homeDirectory}/templates";
    videos = "${config.home.homeDirectory}/videos";
    publicShare = "${config.home.homeDirectory}/public";
  };
}
