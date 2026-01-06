{ config, pkgs, ... }: {
  imports = [
    ./locale.nix
  ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  # Docker
  virtualisation.docker.enable = true;
  users.users.nixos.extraGroups = [ "docker" ];
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
    ghostty
    javaPackages.compiler.temurin-bin.jdk-25
    jetbrains-toolbox
  ];
}
