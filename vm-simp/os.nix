{ config, pkgs, ... }: {
  imports = [
    ./locale.nix
    ./desktop.nix
  ];
  # system.stateVersion = "25.05";
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
  system.autoUpgrade.channel = "https://channels.nixos.org/nixos-25.05";
  # Network
  networking = {
    hostName = "vmsimp";
    extraHosts = ''
      127.0.0.1 www.sublimetext.com
      127.0.0.1 sublimetext.com
    '';
  };
  # App
  # nixpkgs.config = { 
  #   allowUnfree = true;
  #   permittedInsecurePackages = [
  #     "openssl-1.1.1w"
  #   ];
  # };
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
  # User
  users.users.juk = {
    uid = 1000;
    isNormalUser = true;
    description = "Juk";
    extraGroups = [ "wheel" "networkmanager" ];
    packages = with pkgs; [
      qbittorrent
    ];
  };
}
