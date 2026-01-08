{ pkgs, ... }: {
  users.users.juk = {
    uid = 1000;
    isNormalUser = true;
    description = "Juk";
    extraGroups = [ "wheel" "networkmanager" ];
    packages = with pkgs; [
      jetbrains-toolbox
      qbittorrent
      spotify
    ];
  };
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };
  services.usbmuxd.enable = true;
/*
  # Testing VR
  services.wivrn = {
    enable = true;
    openFirewall = true;
    # Run WiVRn as a systemd service on startup
    autoStart = true;

    # Write information to /etc/xdg/openxr/1/active_runtime.json, VR applications
    # will automatically read this and work with WiVRn (Note: This does not currently
    # apply for games run in Valve's Proton)
    defaultRuntime = true;

    # If you're running this with an nVidia GPU and want to use GPU Encoding 
    # (and don't otherwise have CUDA enabled system wide), you need to override the cudaSupport variable.
    package = (pkgs.wivrn.override { cudaSupport = true; });

    # You should use the default configuration (which is no configuration), as that works the best out of the box.
    # However, if you need to configure something see https://github.com/WiVRn/WiVRn/blob/master/docs/configuration.md 
    # for configuration options and https://mynixos.com/nixpkgs/option/services.wivrn.config.json for an example configuration.
  };
*/
}