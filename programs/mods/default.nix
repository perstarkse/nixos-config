{ config, pkgs, ... }:

let
  modsConfig = {
    apis = {
      openrouter = {
        api-key-env = "OPENROUTER_API_KEY";
        base-url = "https://openrouter.ai/api/v1";
        models = {
          "meta-llama/llama-3-8b-instruct:nitro" = {
            aliases = [ "meta-llama/llama-3-8b-instruct:nitro" ];
            max-input-chars = 8192;
            fallback = "claude-3-haiku:beta";
          };
          "anthropic/claude-3-haiku:beta" = {
            aliases = [ "anthropic/claude-3-haiku:beta" ];
            max-input-chars = 200000;
            fallback = null;
          };
        };
      };
    };
    default-model = "meta-llama/llama-3-8b-instruct:nitro";
    max-input-chars = 8192;
    format = false;
    quiet = true;
    temp = 1.0;
    topp = 1.0;
    no-limit = false;
    include-prompt-args = false;
    include-prompt = 0;
    max-retries = 5;
    fanciness = 10;
    status-text = "Generating";
    # max-tokens = 100;  # Uncomment if you want to set this value
  };
in
{
  home.file.".config/mods/mods.yml" = {
    text = pkgs.lib.generators.toYAML {} modsConfig;
  };
}
