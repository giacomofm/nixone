{ config, pkgs, ... }: {
  imports = [
    ./locale.nix
    ./user.nix
  ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  # Docker
  virtualisation.docker.enable = true;
  # App
  nixpkgs.config = { 
    allowUnfree = true;
    permittedInsecurePackages = [
      "openssl-1.1.1w"
    ];
  };
  environment.systemPackages = with pkgs; [
    git
    ffmpeg
    # ghostty
  ];
}
