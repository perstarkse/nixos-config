{pkgs, ...}: let
  modsConfig = {
    apis = {
      openrouter = {
        api-key-env = "OPENROUTER_API_KEY";
        base-url = "https://openrouter.ai/api/v1";
        models = {
          "meta-llama/llama-3-70b-instruct" = {
            aliases = ["meta-llama/llama-3-70b-instruct"];
            max-input-chars = 8192;
            fallback = "meta-llama/llama-3-8b-instruct:nitro";
          };
          "meta-llama/llama-3-8b-instruct:nitro" = {
            aliases = ["meta-llama/llama-3-8b-instruct:nitro"];
            max-input-chars = 8192;
            fallback = "claude-3-haiku:beta";
          };
          "anthropic/claude-3-haiku:beta" = {
            aliases = ["anthropic/claude-3-haiku:beta"];
            max-input-chars = 200000;
            fallback = null;
          };
          "anthropic/claude-3.5-sonnet:beta" = {
            aliases = ["anthropic/claude-3.5-sonnet:beta"];
            max-input-chars = 200000;
            fallback = "claude-3-haiku:beta";
          };
          "deepseek/deepseek-coder" = {
            aliases = ["deepseek/deepseek-coder" "coder"];
            max-input-chars = 20000;
            fallback = "claude-3-haiku:beta";
          };
        };
      };
    };
    roles = {
      shell = [
        "you are a shell expert"
        "you do not explain anything"
        "you simply output one liners to solve the problems you're asked"
        "you do not provide any explanation whatsoever, ONLY the command"
      ];
      functional-expert = [
        "you are an expert at functional programming in rust"
        "you assume a pragmatic view of the functional programming paradigm"
        "you help the user become a better developer"
        "you use clear code examples and explanations to do so"
      ];
    };
    default-model = "anthropic/claude-3.5-sonnet:beta";
    max-input-chars = 180000;
    format = false;
    quiet = true;
    temp = 0.8;
    topp = 1.0;
    no-limit = false;
    include-prompt-args = false;
    include-prompt = 0;
    max-retries = 3;
    fanciness = 10;
    status-text = "Generating";
    # max-tokens = 100;  # Uncomment if you want to set this value
  };
in {
  home.file.".config/mods/mods.yml" = {
    text = pkgs.lib.generators.toYAML {} modsConfig;
  };
}
