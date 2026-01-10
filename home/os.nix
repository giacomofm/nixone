{ pkgs, ... }: {
  imports = [
    ./locale.nix
    ./desktop.nix
    ./user.nix
    # With also
    ./shares.nix
    ./disk-tera.nix
    ./nordvpn.nix
  ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  # Boot
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.editor = false;
  # Network
  networking = {
    hostName = "desknix";
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
    gnome-system-monitor
    git
    ghostty
    sublime4
    nautilus
    ffmpeg
    vlc
    gparted
    loupe
    input-remapper
    hydrapaper
    ffmpegthumbnailer     # https://wiki.nixos.org/wiki/Thumbnails
    gdk-pixbuf            # https://wiki.nixos.org/wiki/Thumbnails
  ];
  environment.pathsToLink = [
    "share/thumbnailers"  # https://wiki.nixos.org/wiki/Thumbnails
  ];
}
