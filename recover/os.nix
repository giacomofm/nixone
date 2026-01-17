{ config, pkgs, ... }: {
  imports = [
    ../locale/base.nix
#    ./uefi.nix
    ./desktop.nix
    ./user.nix
  ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  # Network
  networking = {
    hostName = "recover";
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
  programs.firefox.enable = true;
  # programs.appimage.enable = true;
  environment.systemPackages = with pkgs; [
    gnome-system-monitor
    git
    ghostty
    gparted
    sublime4
    nautilus
  ];
}
