{ config, pkgs, ... }: {
  imports = [
    ../locale/base.nix
    ./user.nix
  ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  # Docker
  virtualisation.docker.enable = true;
  # App
  # nixpkgs.config = { 
  #   allowUnfree = true;
  #   permittedInsecurePackages = [
  #     "openssl-1.1.1w"
  #   ];
  # };
  programs.appimage.enable = true;
  environment.systemPackages = with pkgs; [
    git
    ffmpeg
    # ghostty
    # sublime4
  ];
}
