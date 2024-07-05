{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    gopls
  ];

  programs.go = {
    enable = true;
    goPath = ".go";
    goBin = ".go/bin";
  };
}
