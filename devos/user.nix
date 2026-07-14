{ config, pkgs, lib, ... }:
let
  home-manager = builtins.fetchTarball https://github.com/nix-community/home-manager/archive/master.tar.gz;
  java-version = pkgs.javaPackages.compiler.temurin-bin.jdk-25;
in {
  imports = [
    (import "${home-manager}/nixos")
  ];
  nixpkgs.config = {
    allowUnfree = true;
    problems.handlers.sublimetext4.broken = "warn";
  };
  users.users.juk = {
    uid = 1000;
    isNormalUser = true;
    description = "Juk";
    extraGroups = [ "wheel" "networkmanager" "input" "docker" "vboxusers" "nordvpn" ];
    packages = with pkgs; [
      java-version
      jetbrains-toolbox
      sublime4
    ];
  };
  home-manager.users.juk = { pkgs, ... }: {
    home.stateVersion = "25.11";
#    home.file.".config/hypr/hyprland.lua".source = ../apps/hypr/hyprland.lua;
    home.sessionVariables = {
      JAVA_HOME = "${java-version}";
    };
    programs.bash = {
      enable = true;
      bashrcExtra = builtins.readFile ../apps/bash/rc.sh;
    };
    programs.starship = {
      enable = true;
      enableBashIntegration = true;
      settings = {
        directory = { 
          truncation_length = 5; 
          truncation_symbol = ".../";
        };
      };
    };
    programs.ghostty = {
      enable = true;
      settings = {
        font-family = "JetBrains Mono";
        background-opacity = 0.8;
        keybind = [
          "ctrl+super+minus=new_split:down"
          "ctrl+super+equal=new_split:right"
          "ctrl+super+up=goto_split:up"
          "ctrl+super+down=goto_split:down"
          "ctrl+super+right=goto_split:right"
          "ctrl+super+left=goto_split:left"
        ];
      };
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
    programs.chromium = {
      enable = true;
      package = pkgs.brave;
      extensions = [
        { id = "fdjamakpfbbddfjaooikfcpapjohcfmg"; } # dashlane
      ];
    };
  };
  environment.etc."/brave/policies/managed/GroupPolicy.json".source = ../apps/brave/policies.json;
}