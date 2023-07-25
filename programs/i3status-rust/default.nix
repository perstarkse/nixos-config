{
  programs.i3status-rust = {
    enable = true;
    bars = {
      bottom = {
        theme = "dracula";
        icons = "awesome6";
        blocks = [
        {
          alert = 10.0;
          block = "disk_space";
          info_type = "available";
          interval = 60;
          path = "/";
          warning = 20.0;
        }
        {
          block = "custom";
          command = "cat /etc/hostname";
          interval = "once";
        }
        {
          block = "time";
          format = " $timestamp.datetime(f:'%a %d/%m %R') ";
          interval = 60;
        }
        {
          block = "sound";
        }
        ];
      };
    };
  };
}