{ config, pkgs, lib, ... }:
let
  home-manager = builtins.fetchTarball https://github.com/nix-community/home-manager/archive/master.tar.gz;
  java-version = pkgs.javaPackages.compiler.temurin-bin.jdk-25;
in
{
  imports =
  [
    (import "${home-manager}/nixos")
  ];
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "github-copilot-cli"
  ];
  users.users.nixos = {
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    packages = with pkgs; [
      java-version
      maven
      spring-boot-cli
      kubectl
      kubelogin
      openshift
      azure-cli
      k9s
      fd      # from Mattia
      github-copilot-cli # UnFree
    ];
  };
  home-manager.users.nixos = { pkgs, ... }: {
    home.stateVersion = "25.05";
    home.shellAliases = {
      ping = "ping -c 4";
      buuu = "shutdown now";
      http = "http -v";
      nixtest = "sudo nixos-rebuild test";
      nixupgr = "sudo nixos-rebuild switch --upgrade";
    };
    home.sessionVariables = {
      JAVA_HOME = "${java-version}";
    };
    programs.bash = {
      enable = true;
      bashrcExtra = builtins.replaceStrings [ "\r" ] [ "" ] ''
fifi() {
  sudo find /home /mnt/c/Users/GiacomoFraron -type f -iname "$1"
}
fidi() {
  sudo find /home /mnt/c/Users/GiacomoFraron -type d -iname "$1"
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
  cd /mnt/c/Users/GiacomoFraron/Documents/NixOS/nixone
  git pull
  echo '> git add . && git commit -m "Update" && git push'
  echo '> nixtest (aka: sudo nixos-rebuild test)'
  echo '> nixupgr (aka: sudo nixos-rebuild switch --upgrade)'
  echo '> (wsl --shutdown)'
}

alias echoPATH="echo $PATH | tr ':' '\n'"

# Java Utils:
javarun() {
  if [ -z "$1" ]; then profile='dev'; else profile=$1; fi
  echo "run app.jar profiles=$profile"
  java -jar target/app.jar --spring.profiles.active=$profile
}
mvnrun() {
  if [ -z "$1" ]; then profile='dev'; else profile=$1; fi
  echo "clean run profiles=$profile"
  mvn clean spring-boot:run -Dspring-boot.run.profiles=$profile
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
  # docker rmi temp-image
}

# Projects Utils:
alias luxup='localup LUX'
alias damup='localup LookDAM'
localup() {
  cd "/mnt/c/Users/GiacomoFraron/OneDrive - Avvale S.p.A/Documenti/Progetti/$1/local"
  echo '> dcu (aka: docker compose up -d )'
  echo '> dcd (aka: docker compose down  )'
  echo 'Pub eventi:'
  echo '> docker exec -i broker /opt/kafka/bin/kafka-console-producer.sh --bootstrap-server localhost:9092 --topic [TOPIC] < [FILE (1 msg x line)]'
}

# ERG Utils
ergrun() {
  oc create job test --from=cronjob/hr-integration -n erg-hr
  echo -e "\nSleep 10 prima dei log..."
  sleep 10
  echo -e "\nLogs: "
  oc logs -f $(oc get pod -n erg-hr | rg test | awk '{print $1}')
  echo -e "\n\n> oc logs -f $(oc get pod -n erg-hr | rg test | awk '{print $1}')"
  echo "> oc delete job test -n erg-hr"
}
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
    programs.git = {
      enable = true;
      settings.user.name  = "Giacomo Fraron";
      settings.user.email = "giacomo.fraron@avvale.com";
      settings.init.defaultBranch = "main";
    };
  };
}