{
  programs.i3status-rust = {
    enable = true;
    bars = {
      top = {
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