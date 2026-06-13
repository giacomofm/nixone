{ config, pkgs, lib, ... }:
let
  home-manager = builtins.fetchTarball https://github.com/nix-community/home-manager/archive/master.tar.gz;
in {
  imports = [
    (import "${home-manager}/nixos")
  ];
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "openssl-1.1.1w"
    ];
  };
  users.users.juk = {
    uid = 1000;
    isNormalUser = true;
    description = "Juk";
    extraGroups = [ "wheel" "networkmanager" "input" "docker" "vboxusers" ];
    packages = with pkgs; [
      jetbrains-toolbox
      sublime4
      qbittorrent
      spotify
      ripgrep
      gcc # x Rust
      obsidian
      obs-studio
    ];
  };

  # region obs
  # virtual camera
  boot = {
    kernelModules = [ "v4l2loopback" ];
    extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
    extraModprobeConfig = ''
      options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
    '';
  };
  security.polkit.enable = true;
  # endregion

  # services.usbmuxd.enable = true; # x iPhone
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;                 # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true;            # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true;  # Open ports in the firewall for Steam Local Network Game Transfers
  };
  home-manager.users.juk = { pkgs, ... }: {
    # The state version is required and should stay at the version you originally installed.
    home.stateVersion = "25.05";
    # home.packages = [ pkgs.atool pkgs.httpie ];
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