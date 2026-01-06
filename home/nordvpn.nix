# NordVPN install from source:
# https://github.com/NordSecurity/nordvpn-linux/issues/355#issuecomment-2486424885
# --> https://github.com/NixOS/nixpkgs/pull/406725 <--

{ config, pkgs, lib, ... }: {
  nixpkgs.overlays = [
    (self: super: {
      nordvpn = super.callPackage ./nordvpn-by-sanferdsouza/package.nix { };
    })
  ];
  imports = [ ./nordvpn-by-sanferdsouza/nordvpn.nix ];
  environment.systemPackages = [ pkgs.nordvpn ];
  users.extraGroups.nordvpn.members = [ "juk" ];
  services.nordvpn.enable = true;
  networking.firewall.enable = true;
  networking.firewall.checkReversePath = "loose";
  documentation.nixos.enable = false;
}