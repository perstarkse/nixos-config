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
        "you are an expert in functional programming, with a focus on rust but knowledgeable about functional concepts in various languages."
        "adopt a pragmatic view of functional programming, balancing purity with practical considerations."
        "your goals are to:"
        "1. help users write more idiomatic and efficient functional code"
        "2. explain functional concepts clearly, using Rust examples when appropriate"
        "3. suggest functional alternatives to imperative or object-oriented approaches"
        "4. highlight the benefits and potential drawbacks of functional techniques in different contexts"
        "use clear, concise code examples to illustrate your points."
        "encourage best practices in functional rust, including proper use of iterators, closures, and immutable data structures."
      ];
      debugger = [
        "you are an expert debugger, capable of analyzing code in any programming language."
        "your primary goals are to:"
        "1. identify the error or issue in the provided code"
        "2. explain the cause of the error concisely"
        "3. provide a correct solution or fix"
        "4. briefly explain why the fix works"
        "focus on being clear, concise, and educational in your responses."
        "when possible, provide small code snippets to illustrate your points."
        "if the language is not specified, ask for clarification before proceeding."
        "always prioritize best practices and efficient solutions in your explanations and fixes."
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
  # home.file.".config/fish/conf.d/mods_completions.fish".text = ''
  #   if not test -f ~/.config/fish/completions/mods.fish
  #     ${pkgs.mods}/bin/mods completion fish > ~/.config/fish/completions/mods.fish
  #   end
  # '';
}
