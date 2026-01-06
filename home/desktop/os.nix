{ config, pkgs, ... }: {
  imports = [
    ./disks.nix
    ./nvidia.nix
    ./user.nix
  ];
  # Desktop
  services = {
    desktopManager.gnome.enable = true;
    displayManager.gdm = {
      enable = true;
      autoSuspend = false;
    };
  };
  services.gnome.core-apps.enable = false;
  environment.gnome.excludePackages = [ pkgs.gnome-tour ];
  systemd.sleep.extraConfig = ''
    AllowSuspend=no
    AllowHibernation=no
    AllowHybridSleep=no
    AllowSuspendThenHibernate=no
  '';
  # PipeWire
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };
  # Network
  networking = {
    hostName = "desknix";
    extraHosts = ''
      127.0.0.1 www.sublimetext.com
      127.0.0.1 sublimetext.com
    '';
  };
  # App
  programs.firefox.enable = true;
  environment.systemPackages = with pkgs; [
    gnome-system-monitor
    ghostty
    sublime4
    nautilus
    loupe
    input-remapper
    hydrapaper
    ffmpegthumbnailer # https://wiki.nixos.org/wiki/Thumbnails
    gdk-pixbuf
  ];
  environment.pathsToLink = [
    "share/thumbnailers"
  ];
}