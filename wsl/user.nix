{ config, pkgs, lib, ... }:
let
  home-manager = builtins.fetchTarball https://github.com/nix-community/home-manager/archive/master.tar.gz;
in
{
  imports =
  [
    (import "${home-manager}/nixos")
  ];
  users.users.nixos = {
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    packages = with pkgs; [
      javaPackages.compiler.temurin-bin.jdk-25
      maven
      spring-boot-cli
      httpie
      openshift
    ];
  };
  home-manager.users.nixos = { pkgs, ... }: {
    home.stateVersion = "25.05";
    home.shellAliases = {
      buuu = "shutdown now";
    };
    programs.bash = {
      enable = true;
      bashrcExtra = builtins.replaceStrings [ "\r" ] [ "" ] ''
      fifi() {
        sudo find / -type f -iname "$1" -not -path "/nix/store/*"
      }
      fidi() {
        sudo find / -type d -iname "$1" -not -path "/nix/store/*"
      }
      nixone() {
        cd /mnt/c/Users/GiacomoFraron/Documents/NixOS/nixone
        git pull
        echo '> sudo nixos-rebuild test'
        echo '> git add . && git commit -m "Update" && git push'
        echo '> sudo nixos-rebuild switch --upgrade'
        echo '> (wsl --shutdown)'
      }
      '';
    };
    programs.git = {
      enable = true;
      settings.user.name  = "Giacomo Fraron";
      settings.user.email = "giacomo.fraron@avvale.com";
    };
  };
}