{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    ncmpcpp
  ];

  services.mpd = {
    enable = true;
    musicDirectory = "/home/aka/Music";
    extraConfig = ''
      bind_to_address "127.0.0.1" 
      port "6600" 
      audio_output {
        type "pipewire"
        name "My PipeWire Output"
      }'';
  };

}
