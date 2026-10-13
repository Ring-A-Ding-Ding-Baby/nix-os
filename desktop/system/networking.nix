{
  networking = {
    networkmanager.enable = true;
    networkmanager.dns = "systemd-resolved";
    firewall = {
      checkReversePath = false;
    };
  };
}
