{ config, pkgs, lib, ... }: {
  imports = [
    ../locale/base.nix
    ./user.nix
  ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  # WSL
  # wsl.wslConf.network.generateHosts = false;
  # Docker
  virtualisation.docker.enable = true;
  # App
  # programs.appimage.enable = true;
  environment.systemPackages = with pkgs; [
    git
    ffmpeg
    fastfetch
  ];
}
