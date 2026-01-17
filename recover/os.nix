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
  # Boot MBR
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  # Boot EFI
#  boot.loader.efi.canTouchEfiVariables = true;
#  boot.loader.systemd-boot.enable = true;
#  boot.loader.systemd-boot.editor = false;
  # Network
  networking.hostName = "recover";
  # App
  programs.firefox.enable = true;
  # programs.appimage.enable = true;
  environment.systemPackages = with pkgs; [
    gnome-system-monitor
    git
    ghostty
    gparted
    nautilus
    neovim
  ];
}
