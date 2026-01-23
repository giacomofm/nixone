{ config, pkgs, lib, ... }:
let
  home-manager = builtins.fetchTarball https://github.com/nix-community/home-manager/archive/master.tar.gz;
  java-version = pkgs.javaPackages.compiler.temurin-bin.jdk-25;
in
{
  imports =
  [
    (import "${home-manager}/nixos")
  ];
  users.users.nixos = {
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    packages = with pkgs; [
      java-version
      maven
      spring-boot-cli
      httpie
      kubectl
      kubelogin
      openshift
      azure-cli
      ripgrep # from Mattia
      fd      # from Mattia
    ];
  };
  home-manager.users.nixos = { pkgs, ... }: {
    home.stateVersion = "25.05";
    home.shellAliases = {
      buuu = "shutdown now";
    };
    home.sessionVariables = {
      JAVA_HOME = "${java-version}";
    };
    programs.bash = {
      enable = true;
      bashrcExtra = builtins.replaceStrings [ "\r" ] [ "" ] ''
      fifi() {
        sudo find /home /mnt/c/Users/GiacomoFraron -type f -iname "$1"
      }
      fidi() {
        sudo find /home /mnt/c/Users/GiacomoFraron -type d -iname "$1"
      }
      nixone() {
        cd /mnt/c/Users/GiacomoFraron/Documents/NixOS/nixone
        git pull
        echo '> sudo nixos-rebuild test'
        echo '> git add . && git commit -m "Update" && git push'
        echo '> sudo nixos-rebuild switch --upgrade'
        echo '> (wsl --shutdown)'
      }
      luxup() {
        cd /mnt/c/Users/GiacomoFraron/Documents/LUX/demo
        echo '> docker compose up -d'
        echo '> docker compose down'
        echo 'Pub eventi:'
        echo '> docker exec -i broker /opt/kafka/bin/kafka-console-producer.sh --bootstrap-server localhost:9092 --topic [TOPIC] < [FILE]'
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