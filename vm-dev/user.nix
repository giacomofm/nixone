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
  users.users.giacomo = {
    uid = 1000;
    isNormalUser = true;
    description = "Giacomo";
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    packages = with pkgs; [
      java-version
      jetbrains-toolbox
      spring-boot-cli
      maven
      httpie
      nodejs
      openshift
      google-chrome
      dbeaver-bin
      bruno
      meld
    ];
  };
  home-manager.users.giacomo = { pkgs, ... }: {
    # The state version is required and should stay at the version you originally installed.
    home.stateVersion = "25.11";
    # home.packages = [ pkgs.atool pkgs.httpie ];
    home.shellAliases = {
      buuu = "shutdown now";
    };
    home.sessionVariables = {
      JAVA_HOME = "${java-version}";
    };
    programs.bash = {
      enable = true;
      bashrcExtra = ''
        fifi() {
          sudo find / -path /nix/store -prune -o -type f -iname "$1"
        }
        fidi() {
          sudo find / -path /nix/store -prune -o -type d -iname "$1"
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