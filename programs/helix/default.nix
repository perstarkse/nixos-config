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
          name = "typescript";
          language-servers = ["typescript" "gpt"];
        }
        {
          name = "javascript";
          language-servers = ["typescript" "gpt"];
        }
        {
          name = "nix";
          language-servers = ["nil"];
          auto-format = true;
          formatter.command = "alejandra";
        }
        {
          name = "python";
          language-servers = ["pylsp" "gpt"];
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
      language-server.marksman = {
        command = "${pkgs.marksman}/bin/marksman";
        args = ["server"];
      };
      language-server.gpt = {
        command = "helix-gpt";
      };
      language-server.lsp-ai = {
        command = "${pkgs.mynixpkgs.lsp-ai}/bin/lsp-ai";
        config = {
          memory = {
            file_store = {};
          };
          models = {
            default = {
              type = "open_ai";
              chat_endpoint = "https://openrouter.ai/api/v1/chat/completions";
              model = "anthropic/claude-3-haiku:beta";
              auth_token_env_var_name = "OPENROUTER_API_KEY";
            };
          };
          completion = {
            model = "default";
            parameters = {
              max_tokens = 64;
              max_context = 1024;
              messages = [
                {
                  role = "system";
                  content = "Instructions:\n- You are an AI programming assistant.\n- Given a piece of code with the cursor location marked by \"<CURSOR>\", replace \"<CURSOR>\" with the correct code or comment.\n- First, think step-by-step.\n- Describe your plan for what to build in pseudocode, written out in great detail.\n- Then output the code replacing the \"<CURSOR>\"\n- Ensure that your completion fits within the language context of the provided code snippet (e.g., Python, JavaScript, Rust).\n\nRules:\n- Only respond with code or comments.\n- Only replace \"<CURSOR>\"; do not include any previously written code.\n- Never include \"<CURSOR>\" in your response\n- If the cursor is within a comment, complete the comment meaningfully.\n- Handle ambiguous cases by providing the most contextually appropriate completion.\n- Be consistent with your responses.";
                }
                {
                  role = "user";
                  content = "def greet(name):\n    print(f\"Hello, {<CURSOR>}\")";
                }
                {
                  role = "assistant";
                  content = "name";
                }
                {
                  role = "user";
                  content = "function sum(a, b) {\n    return a + <CURSOR>;\n}";
                }
                {
                  role = "assistant";
                  content = "b";
                }
                {
                  role = "user";
                  content = "fn multiply(a: i32, b: i32) -> i32 {\n    a * <CURSOR>\n}";
                }
                {
                  role = "assistant";
                  content = "b";
                }
                {
                  role = "user";
                  content = "# <CURSOR>\ndef add(a, b):\n    return a + b";
                }
                {
                  role = "assistant";
                  content = "Adds two numbers";
                }
                {
                  role = "user";
                  content = "# This function checks if a number is even\n<CURSOR>";
                }
                {
                  role = "assistant";
                  content = "def is_even(n):\n    return n % 2 == 0";
                }
                {
                  role = "user";
                  content = "{CODE}";
                }
              ];
            };
          };
        };
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
