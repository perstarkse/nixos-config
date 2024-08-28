{
  inputs,
  pkgs,
  ...
}: {
  programs.helix = {
    enable = true;
    package = inputs.helix-master.packages."x86_64-linux".default;
    defaultEditor = true;
    languages = {
      language = [
        {
          name = "svelte";
          language-servers = ["svelteserver" "tailwindcss-ls" "typescript-language-server"];
          auto-format = true;
        }
        {
          name = "typescript";
          language-servers = ["typescript-language-server"];
          auto-format = true;
        }
        {
          name = "javascript";
          language-servers = ["typescript"];
          auto-format = true;
        }
        {
          name = "nix";
          language-servers = ["nil"];
          auto-format = true;
          formatter.command = "alejandra";
        }
        {
          name = "python";
          language-servers = ["pylsp"];
        }
        {
          name = "rust";
          auto-format = true;
          language-servers = ["rust-analyzer"];
          formatter.command = "rustfmt";
        }
        {
          name = "markdown";
          auto-format = true;
          language-servers = ["marksman"];
          formatter = {
            command = "${pkgs.mdformat}/bin/mdformat";
            args = ["-"];
          };
        }
      ];
      language-server.tailwindcss-ls = {
        command = "${pkgs.tailwindcss-language-server}/bin/tailwindcss-language-server";
        args = ["--stdio"];
        config = {
          userLanguages = {
            svelte = "html";
            ".svelte" = "html";
          };
        };
      };
      language-server.marksman = {
        command = "${pkgs.marksman}/bin/marksman";
        args = ["server"];
      };
      language-server.gpt = {
        command = "helix-gpt";
      };
    };
    settings = {
      keys.normal = {
        space.c = ":clipboard-yank";
      };
      keys.select = {
        space.c = ":clipboard-yank";
      };
      editor = {
        line-number = "relative";
        lsp.display-messages = true;
        soft-wrap = {
          enable = true;
        };
        file-picker = {
          hidden = true;
          git-ignore = true;
        };
      };
    };
  };
}
