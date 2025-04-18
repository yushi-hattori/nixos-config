{ ... }:
{
  programs.zsh = {
    enable = true;
    autosuggestion = {
      enable = true;
    };
    history = {
      append = true;
      extended = true;
    };
    oh-my-zsh = {
      enable = true;
      theme = "sorin";
    };
    syntaxHighlighting = {
      enable = true;
    };
    shellAliases = {
      "cd" = "z";
      ".." = "cd ..";
    };
    
  };
}
