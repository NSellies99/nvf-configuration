{ pkgs, lib, ... }:
{
  programs.nvf = {
    enable = true;
    settings.vim = {
      # Style
      theme = {
        enable = true;
        name = "gruvbox";
        style = "dark";
      };

      globals = {
        mapleader = " ";
      };

      # Handy dandy things
      statusline.lualine.enable = true;
      telescope.enable = true;
      autocomplete.nvim-cmp.enable = true;

      # Lanuages
      languages = {
        enableLSP = true;
        enableTreesitter = true;
      
        nix.enable = true; 
        python.enable = true;
        rust.enable = true;
      };
    };
  };
}
