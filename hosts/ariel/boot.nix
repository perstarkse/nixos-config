{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-4cef64f3-c5f1-46ad-a24a-046f130ec565".device = "/dev/disk/by-uuid/4cef64f3-c5f1-46ad-a24a-046f130ec565";
  boot.initrd.luks.devices."luks-4cef64f3-c5f1-46ad-a24a-046f130ec565".keyFile = "/crypto_keyfile.bin";
}
