let
  palette = {
    background = "#282a36";
    background-alt = "#282a36";
    background-attention = "#181920";
    border = "#282a36";
    current-line = "#44475a";
    selection = "#44475a";
    foreground = "#f8f8f2";
    foreground-alt = "#e0e0e0";
    foreground-attention = "#ffffff";
    comment = "#6272a4";
    cyan = "#8be9fd";
    green = "#50fa7b";
    orange = "#ffb86c";
    pink = "#ff79c6";
    purple = "#bd93f9";
    red = "#ff5555";
    yellow = "#f1fa8c";
  };
 
in
{
  programs.qutebrowser = {
    enable = true;
    settings = {
      content.javascript.can_access_clipboard = true;
      fonts = {
        default_family = "Fira Code";
        default_size = "9.00pt";      
      };
      colors = {
        webpage.preferred_color_scheme = "dark";
        completion = {
          category = {
            bg = palette.background;
            border = {
              bottom = palette.border;
              top = palette.border;
            };
            fg = palette.foreground;
          };
          even = {
            bg = palette.background;
          };
          odd = {
            bg = palette.background-alt;
          };
          fg = palette.foreground;
          item = {
            selected = {
              bg = palette.selection;
              border = {
                bottom = palette.selection;
                top = palette.selection;
              };
              fg = palette.foreground;
            };
          };
          match = {
            fg = palette.orange;
          };
          scrollbar = {
            bg = palette.background;
            fg = palette.foreground;
          };
        };
        downloads = {
          bar = {
            bg = palette.background;
          };
          error = {
            bg = palette.background;
            fg = palette.red;
          };
          stop = {
            bg = palette.background;
          };
          system = {
            bg = "none";
          };
        };
        hints = {
          bg = palette.background;
          fg = palette.purple;
          match = {
            fg = palette.foreground-alt;
          };
        };
        keyhint = {
          bg = palette.background;
          fg = palette.purple;
          suffix = {
            fg = palette.selection;
          };
        };
        messages = {
          error = {
            bg = palette.background;
            border = palette.background-alt;
            fg = palette.red;
          };
          info = {
            bg = palette.background;
            border = palette.background-alt;
            fg = palette.comment;
          };
          warning = {
            bg = palette.background;
            border = palette.background-alt;
            fg = palette.red;
          };
        };
        statusbar = {
          caret = {
            bg = palette.background;
            fg = palette.orange;
            selection = {
              bg = palette.background;
              fg = palette.orange;
            };
          };
          command = {
            bg = palette.background;
            fg = palette.pink;
            private = {
              bg = palette.background;
              fg = palette.foreground-alt;
            };
          };
          insert = {
            bg = palette.background-attention;
            fg = palette.foreground-attention;
          };
          normal = {
            bg = palette.background;
            fg = palette.foreground;
          };
          passthrough = {
            bg = palette.background;
            fg = palette.orange;
          };
          private = {
            bg = palette.background-alt;
            fg = palette.foreground-alt;
          };
          progress = {
            bg = palette.background;
          };
          url = {
            error = {
              fg = palette.red;
            };
            fg = palette.foreground;
            hover = {
              fg = palette.cyan;
            };
            success = {
              http = {
                fg = palette.green;
              };
              https = {
                fg = palette.green;
              };
            };
            warn = {
              fg = palette.yellow;
            };
          };
        };
        tabs = {
          bar = {
            bg = palette.selection;
          };
          even = {
            bg = palette.selection;
            fg = palette.foreground;
          };
          indicator = {
            error = palette.red;
            start = palette.orange;
            stop = palette.green;
            system = "none";
          };
          odd = {
            bg = palette.selection;
            fg = palette.foreground;
          };
          selected = {
            even = {
              bg = palette.background;
              fg = palette.foreground;
            };
            odd = {
              bg = palette.background;
              fg = palette.foreground;
            };
          };
        };
      };
      hints = {
        border = "1px solid ${palette.background-alt}";
      };
      tabs = {
        favicons = {
          scale = 1;
        };
        indicator = {
          width = 1;
        };
      };
    };
  };
}