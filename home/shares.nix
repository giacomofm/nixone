{ ... } : 
let
  on_ftp = false;
  on_samba = false;
  on_jellyfin = true;
in {
  # Jellyfin
  # (?) sudo setfacl -R -m u:jellyfin:rx /path/to/open
  services.jellyfin = {
    enable = on_jellyfin;
    openFirewall = true;
  };
  # Network
  networking.firewall = {
    enable = true;
    allowPing = true;
    allowedTCPPorts = [ 8080 ] ++ (if on_ftp then [ 21 ] else []);
    allowedTCPPortRanges = [] ++ (if on_ftp then [ { from = 56250; to   = 56260; } ] else []);
  };
  # FTP
  services.vsftpd = {
    enable = on_ftp;
    localUsers = true;
    writeEnable = true;
    extraConfig = ''
      pasv_enable=YES
      pasv_min_port=56250
      pasv_max_port=56260
    '';
  };
  # Samba
  # sudo smbpasswd -a juk
  services.samba = {
    enable = on_samba;
    openFirewall = true;
    settings = {
      global = {
        "server string" = "smbnix";
        "netbios name" = "smbnix";
        "security" = "user";
        "map to guest" = "bad user";
        # Performance
        "use sendfile" = true;
        "strict locking" = false;
      };
    };
  };
  services.samba-wsdd = {
    enable = on_samba;
    openFirewall = true;
  };
}