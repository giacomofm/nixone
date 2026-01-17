{ config, pkgs, ... }: {
  imports = [
    ../locale/base.nix
    ./desktop.nix
    ./user.nix
  ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  # VM
  virtualisation.vmware.guest.enable = true;
  # Boot
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.editor = false;
  # Network
  networking = {
    hostName = "vmdev";
    extraHosts = ''
      127.0.0.1 www.sublimetext.com
      127.0.0.1 sublimetext.com
    '';
  };
  # Docker
  virtualisation.docker.enable = true;
  # App
  nixpkgs.config = { 
    allowUnfree = true;
    permittedInsecurePackages = [
      "openssl-1.1.1w"
    ];
  };
  programs.appimage.enable = true;
  programs.firefox.enable = false;
  environment.systemPackages = with pkgs; [
    git
    ffmpeg
    gnome-system-monitor
    ghostty
    sublime4
    nautilus
    loupe
    ffmpegthumbnailer # https://wiki.nixos.org/wiki/Thumbnails
    gdk-pixbuf
  ];
  environment.pathsToLink = [
    "share/thumbnailers"
  ];
}
