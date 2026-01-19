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
  # VMware
  # virtualisation.vmware.guest.enable = true;
  # VirtualBox
  # virtualisation.virtualbox.guest.enable = true;
  # virtualisation.virtualbox.guest.dragAndDrop = true;
  # Boot
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.editor = false;
  # Network
  networking = {
    hostName = "vmsimp";
    extraHosts = ''
      127.0.0.1 www.sublimetext.com
      127.0.0.1 sublimetext.com
    '';
  };
  # App
  nixpkgs.config = { 
    allowUnfree = true;
    permittedInsecurePackages = [
      "openssl-1.1.1w"
    ];
  };
  # programs.appimage.enable = true;
  programs.firefox.enable = true;
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
