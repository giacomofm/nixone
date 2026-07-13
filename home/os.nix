{ pkgs, ... }: {
  imports = [
    ../locale/base.nix
    ../desktop/gnome.nix
    ./user.nix
    # With also
    ./nvidia.nix
    ./shares.nix
    ./disk-tera.nix
  ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  # Boot
  boot.loader.timeout = 3;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.editor = false;
  # Network
  networking.hostName = "desknix";
  # NordVPN
  services.nordvpn.enable = true;
  networking.firewall.checkReversePath = "loose";
  # Docker
  virtualisation.docker.enable = true;
  # VirtualBox
  virtualisation.virtualbox.host.enable = true;
  # App
  # programs.appimage.enable = true;
  programs.firefox.enable = true;
  environment.systemPackages = with pkgs; [
    git
    ghostty
    fastfetch
    httpie
    ffmpeg
    vlc
    gparted
    loupe
    # input-remapper
    hydrapaper
    nordvpn
  ];
}
