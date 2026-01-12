{ config, pkgs, lib, ... }:
let
  home-manager = builtins.fetchTarball https://github.com/nix-community/home-manager/archive/master.tar.gz;
in
{
  imports =
  [
    (import "${home-manager}/nixos")
  ];
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
  home-manager.users.giacomo = { pkgs, ... }: {
    # The state version is required and should stay at the version you originally installed.
    home.stateVersion = "25.11";
    # home.packages = [ pkgs.atool pkgs.httpie ];
    home.shellAliases = {
      buuu = "shutdown now";
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
        nixone() {
          cd /etc/nixos/nixone
          git pull
          echo '> sudo nixos-rebuild test'
          echo '> git add . && git commit -m "Update" && git push'
          echo '> sudo nixos-rebuild switch --upgrade'
        }
      '';
    };
    programs.git = {
      enable = true;
      settings.user.name  = "Giacomo Fraron";
      settings.user.email = "giacomo.fraron@avvale.com";
    };
    dconf.settings = {
      "org/gnome/desktop/wm/keybindings" = {
        # switch-to-workspace-down = ["<Control><Alt>Page_Down"];
        switch-to-workspace-down = [];
        switch-to-workspace-up = [];
      };
    };
  };
}