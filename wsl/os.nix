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
  # wsl.wslConf.network.generateHosts = false;      # cat /etc/hosts
  wsl.wslConf.network.generateResolvConf = false; # cat /etc/resolv.conf
  networking.nameservers = [ "1.1.1.1" "8.8.8.8" "10.255.255.254" ];
  # Docker
  virtualisation.docker.enable = true;
  # App
  # programs.appimage.enable = true;
  environment.systemPackages = with pkgs; [
    git
    vim
    httpie
    ffmpeg
    ripgrep
    fastfetch
  ];
}
