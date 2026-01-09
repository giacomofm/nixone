{ config, pkgs, lib, ... }:
let
  home-manager = builtins.fetchTarball https://github.com/nix-community/home-manager/archive/master.tar.gz;
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
    extraGroups = [ "wheel" "networkmanager" ];
    packages = with pkgs; [
      qbittorrent
    ];
  };
  home-manager.users.eve = { pkgs, ... }: {
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
      '';
    };
  };
}