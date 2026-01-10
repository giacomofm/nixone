{ pkgs, ... }: {
  imports = [
    ./nvidia.nix
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
}