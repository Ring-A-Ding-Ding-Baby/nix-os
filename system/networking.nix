{
  networking = {
    hostName = "shrimp-shack";
    networkmanager.enable = true;
    networkmanager.dns = "systemd-resolved";
    firewall = {
      checkReversePath = false;
    };
  };
}
