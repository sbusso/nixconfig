{ pkgs, ...}:

{
  programs.micro = {
    enable = true;
    settings = {
      colorscheme = "simple";
      tabsize = 4;
      tabstospaces = true;
      # Add any other micro settings you prefer
    };
  };
}
