{ pkgs, ... }:
let
  custom-astronaut = pkgs.sddm-astronaut.override {
    embeddedTheme = "jake_the_dog"; 
  };
in
{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "${custom-astronaut}/share/sddm/themes/sddm-astronaut-theme";
    extraPackages = [ custom-astronaut ];
  };
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.systemPackages = with pkgs; [
    hyprlauncher
    hyprpolkitagent
    kitty
    mako
    kdePackages.dolphin
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