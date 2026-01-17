{ config, pkgs, ... }: {
  # Boot
  # remove boot reference from configuration.nix
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.editor = false;
}
