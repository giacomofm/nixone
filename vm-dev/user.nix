{ config, pkgs, lib, ... }:
let
  home-manager = builtins.fetchTarball https://github.com/nix-community/home-manager/archive/master.tar.gz;
in
{
  imports =
  [
    (import "${home-manager}/nixos")
  ];
  programs.git = {
    enable = true;
    config = {
      user.name = "Giacomo";
      user.email = "giacomo.fraron@avvale.com";
    };
  };
  users.users.giacomo = {
    uid = 1000;
    isNormalUser = true;
    description = "Giacomo";
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    packages = with pkgs; [
      javaPackages.compiler.temurin-bin.jdk-25
      jetbrains-toolbox
      spring-boot-cli
      google-chrome
      httpie
      bruno
    ];
  };
  home-manager.users.juk = { pkgs, ... }: {
    # The state version is required and should stay at the version you originally installed.
    home.stateVersion = "25.11";
    # home.packages = [ pkgs.atool pkgs.httpie ];
    home.shellAliases = {
      buuu = "shutdown now";
      nixone = "cd /etc/nixos/nixone && git pull && echo '> git add . && git commit -m \"Update\" && git push' && echo '> sudo nixos-rebuild switch --upgrade'";
    };
    programs.bash = {
      enable = true;
      bashrcExtra = ''
        fifi() {
          sudo find / -type f -iname "$1" -not -path "/nix/store/*"
        }
        fidi() {
          sudo find / -type d -iname "$1" -not -path "/nix/store/*"
        }
      '';
    };
  };
}