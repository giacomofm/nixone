{ pkgs, ... }: {
  programs.git = {
    enable = true;
    config = {
      user.name = "giacomo";
      user.email = "giacomo.fraron@avvale.com";
    };
  };
  users.users.giacomo = {
    uid = 1000;
    isNormalUser = true;
    description = "Giacomo";
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    packages = with pkgs; [
      javaPackages.compiler.temurin-bin.jdk-25
      jetbrains-toolbox
      spring-boot-cli
      google-chrome
      httpie
      bruno
    ];
  };
}