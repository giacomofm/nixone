{ pkgs, ... }: {
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
  systemd.sleep.settings.Sleep = {
    AllowSuspend = "no";
    AllowHibernation = "no";
    AllowHybridSleep = "no";
    AllowSuspendThenHibernate = "no";
  };
  environment.systemPackages = with pkgs; [
    gnome-terminal
    gnome-system-monitor
    gnome-text-editor
    nautilus
    ffmpegthumbnailer     # https://wiki.nixos.org/wiki/Thumbnails
    gdk-pixbuf            # https://wiki.nixos.org/wiki/Thumbnails
  ];
  environment.pathsToLink = [
    "share/thumbnailers"  # https://wiki.nixos.org/wiki/Thumbnails
  ];

  # [PipeWire](https://wiki.nixos.org/wiki/PipeWire)
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };
}