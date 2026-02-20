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
      ripgrep
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
        fitx() {
          if [ $# -eq 1 ]; then
            rg -i --regexp "$1" .
          elif [ $# -eq 2 ]; then
            rg -i --regexp "$1" $2
          elif [ $# -eq 3 ]; then
            rg --type $3 -i --regexp "$1" $2
          else
            echo "fitx REGEX_PATTERN [PATH] [FILE_TYPE]"
          fi
        }
        nixone() {
          cd /etc/nixos/nixone
          git pull
          echo '> sudo nixos-rebuild test'
          echo '> git add . && git commit -m "Update" && git push'
          echo '> sudo nixos-rebuild switch --upgrade'
        }

        # Docker Utils:
        alias dcu='docker compose up -d'
        alias dcd='docker compose down'
        alias ddrop='docker system prune -a --volumes'
        dls() {
          echo "Images:"
          docker image ls
          echo -e "\n\nContainers:"
          docker container ls
          echo -e "\n\nVolumes: "
          docker volume ls
        }
        dtmprun() {
          docker build -t temp-image .
          if [ -z "$1" ]; then
            docker run --rm temp-image
          else
            docker run --rm -p $1:$1 temp-image
          fi
          echo "docker rmi temp-image"
        }

        # Rust extra:
        . "$HOME/.cargo/env"
      '';
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