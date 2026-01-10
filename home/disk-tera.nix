{ ... } : {
  # Tera
  # https://manpages.ubuntu.com/manpages/noble/en/man8/mount.8.html#filesystem-independent%20mount%20options
  fileSystems."/mnt/Tera" = {
    device = "/dev/disk/by-uuid/3B7DE3DD5A98E43C";
    fsType = "ntfs-3g";
    options = [
      "nofail"
      "rw"
      "users"
      "uid=1000"
      "gid=100"
      "x-gvfs-show"
      "windows_names"
    ];
  };
  # Samba
  services.samba.settings = {
    "Tera" = {
      "path" = "/mnt/Tera";
      "browseable" = "yes";
      "read only" = "no";
      "guest ok" = "no";
    };
  };
}