{ pkgs, ... }: {
  imports = [
    ../locale/base.nix
    ../desktop/gnome.nix
    ./user.nix
    # With also
    ./nvidia.nix
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
  # PipeWire https://wiki.nixos.org/wiki/PipeWire
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };
  # Docker
  virtualisation.docker.enable = true;
  # VirtualBox
  virtualisation.virtualbox.host.enable = true;
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
    ghostty
    fastfetch
    sublime4
    httpie
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
