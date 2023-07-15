{
  programs.i3status-rust = {
    enable = true;
    bars = {
      bottom = {
        theme = "dracula";
        #icons = "awesome5";
        blocks = [
        {
          block = "time";
          interval = 60;
        }
        {
          block = "custom";
          command = "cat /etc/hostname";
          interval = "once";
        }
        {
          block = "pomodoro";
        } 
        ];
      };
    };
  };
}