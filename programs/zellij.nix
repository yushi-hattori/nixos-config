{ ... }:
{
  programs.zellij = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    settings = {
      theme = "nightfox";
    };
  };
}
