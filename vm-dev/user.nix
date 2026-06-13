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
  users.users.juk = {
    uid = 1000;
    isNormalUser = true;
    description = "Juk";
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    packages = with pkgs; [
      java-version
      maven
      spring-boot-cli
      jetbrains-toolbox
    ];
  };
  home-manager.users.juk = { pkgs, ... }: {
    home.stateVersion = "25.11"; # The state version is required and should stay at the version you originally installed.
    # home.packages = [ pkgs.atool pkgs.httpie ];
    home.sessionVariables = {
      JAVA_HOME = "${java-version}";
    };
    programs.bash = {
      enable = true;
      bashrcExtra = builtins.readFile ../apps/bash/rc.sh;
    };
    programs.git = {
      enable = true;
      settings.user.name  = "Giacomo Fraron";
      settings.user.email = "giacomo.fraron@gmail.com";
      settings.init.defaultBranch = "main";
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