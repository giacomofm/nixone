{ pkgs, ... }: {
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
      bruno
    ];
  };
}