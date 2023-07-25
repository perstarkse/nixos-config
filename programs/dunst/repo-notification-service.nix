{config, pkgs, lib, ...}:

let
  cfg = config.services.repo-notification-service;
in

with lib;
{
 options.services.repo-notification-service = with types; {
  enable = mkEnableOption "enable the repo notification service";
  repository = mkOption {
     default = "";
     type = types.str;
     description = "the path to the repository";
   };
  pull = mkOption {
    default = false;
    type = types.bool;
    description = "enable to pull commits automatically";
  };
 };

 config =
   let
    script = pkgs.writeScript "repo-notification-service.sh" ''
    #!${pkgs.bash}/bin/bash
    
    cd ${cfg.repository}
    ${pkgs.git}/bin/git fetch
    commits=$(${pkgs.git}/bin/git rev-list HEAD..origin/master --count)

    if [ "$commits" -gt 0 ]
    then
      ${pkgs.dunst}/bin/dunst dunstify "$commits new commit(s) have been pushed to the repository"
    fi
  
    '';
   in
   mkIf cfg.enable {
    systemd.user.services.repo-notifications = {
    Unit = {
      Description = "Will automatically run git fetch after boot and sleep, might pull as well";
    };
    Install = {
      WantedBy = [ "multi-user.target" "sleep.target" ];
    };
    Service = {
      Type="oneshot";       
      ExecStart = "${script}";
    };      
  };
};
}


