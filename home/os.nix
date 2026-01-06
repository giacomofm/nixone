{ config, pkgs, ... }: {
  imports = [
    ./locale.nix
    ./shares.nix
    ./nordvpn.nix
    ./desktop/os.nix
  ];
  # system.stateVersion = "25.05";
  # Boot
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.editor = false;
  system.autoUpgrade.channel = "https://channels.nixos.org/nixos-25.05";
  # App
  nixpkgs.config = { 
    allowUnfree = true;
    permittedInsecurePackages = [
      "openssl-1.1.1w"
    ];
  };
  environment.systemPackages = with pkgs; [
    gparted
    git
    vlc
    ffmpeg
  ];
}
