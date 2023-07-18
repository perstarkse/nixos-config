{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        width = 300;
        height = 240;
        origin = "top-center";
        transpararency = 5;
        frame_color = "#1a1c25";
        font = "Fira Code 9";
        frame_width = 1;
        word_wrap = true;
        corner_radius = 2;
        alignment = "center";
      };
      urgency_normal = {
        background = "#2a2d39";
        foreground = "#bbc2cf";
        timeout = 14;
      };
      urgency_low = {
        background = "#1E2029";
        foreground = "#bbc2cf";
        timeout = 8;
      };
      urgency_critical = {
        background = "#cc6666";
        foreground = "#1E2029";
        timeout = 0;
      };
    };
  };
}
