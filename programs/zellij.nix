{ ... }:
{
  programs.zellij = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    settings = {
      theme = "nightfox";
      show_startup_tips = false;
      pane_frames = false;
      default_shell = "zsh";
      ui = {
        pane_frames = {
          rounded_corners = true;
        };
      };     
    };
  };

  xdg.configFile."zellij" = {
    source = ../assets/zellij;
      recursive = true;
  };
}
