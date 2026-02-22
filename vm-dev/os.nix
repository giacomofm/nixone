{ config, pkgs, ... }: {
  imports = [
    ../locale/base.nix
    ../desktop/hyprland.nix
    ./user.nix
  ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  # VM
  virtualisation.virtualbox.guest.enable = true;
  virtualisation.virtualbox.guest.dragAndDrop = true;
  # Boot
  boot.loader.timeout = 2;
  # Boot MBR
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  # Boot EFI
#  boot.loader.efi.canTouchEfiVariables = true;
#  boot.loader.systemd-boot.enable = true;
#  boot.loader.systemd-boot.editor = false;
  # Network
  networking = {
    hostName = "vmdev";
    extraHosts = ''
      127.0.0.1 www.sublimetext.com
      127.0.0.1 sublimetext.com
    '';
  };
  # App
  programs.appimage.enable = false;
  programs.firefox.enable = false;
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    ghostty
    vim
    git
    httpie
    ripgrep
    fastfetch
  ];
}
