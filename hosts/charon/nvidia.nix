{config, ...}: {
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  boot.initrd.kernelModules = ["nvidia"];
  boot.extraModulePackages = [config.boot.kernelPackages.nvidia_x11];

  # Tell Xorg to use the nvidia driver
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    # Modesetting is needed for most wayland compositors
    modesetting.enable = true;

    # Fix graphical corruption on suspend/resume
    powerManagement.enable = true;
    # Use the open source version of the kernel module
    # Only available on driver 515.43.04+
    #open = true;

    forceFullCompositionPipeline = true;

    # Enable the nvidia settings menu
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    #package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
