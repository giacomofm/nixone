{ pkgs, lib, ... }:
let
  home-manager = builtins.fetchTarball https://github.com/nix-community/home-manager/archive/master.tar.gz;
in {
  imports = [
    (import "${home-manager}/nixos")
  ];
  users.users.juk = {
    uid = 1000;
    isNormalUser = true;
    description = "Juk";
    extraGroups = [ "wheel" "networkmanager" "docker" "vboxusers" ];
    packages = with pkgs; [
      jetbrains-toolbox
      qbittorrent
      spotify
      httpie
      gcc # x Rust
    ];
  };
  services.usbmuxd.enable = true; # x iPhone
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
    home.shellAliases = {
      buuu = "shutdown now";
      nn = "nordvpn";
      nns = "nordvpn status";
      nnc = "nordvpn connect Switzerland";
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

        # Rust extra:
        . "$HOME/.cargo/env"
      '';
    };
    programs.starship = {
      enable = true;
      enableBashIntegration = true;
      settings.username.show_always = true;
    };
    programs.ghostty = {
      enable = true;
      settings = {
        font-family = "JetBrains Mono";
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
  };
}