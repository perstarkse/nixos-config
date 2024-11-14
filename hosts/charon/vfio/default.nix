{pkgs, ...}: {
  boot.initrd.kernelModules = ["vfio-pci"];
  boot.kernelModules = ["kvm-amd"];

  boot.kernelParams = let
    gpuIds = "10de:1b81,10de:10f0";
  in [
    "amd_iommu=on"
    "iommu=1"
    "kvm.ignore_msrs=1"
    "kvm.report_ignored_msrs=0"
    "kvm_amd.npt=1"
    "kvm_amd.avic=1"
    "vfio-pci.ids=${gpuIds}"
    "default_hugepagesz=1G"
    "hugepages=20"
  ];

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      ovmf.enable = true;
      runAsRoot = false;
      package = pkgs.qemu_kvm; # host cpu only
    };
    onBoot = "ignore";
    onShutdown = "shutdown";
  };

  environment.systemPackages = with pkgs; [virt-manager looking-glass-client];

  systemd.tmpfiles.rules = [
    "f /dev/shm/looking-glass 0660 p qemu-libvirtd -"
  ];

  home-manager.users.p.programs.looking-glass-client = {
    enable = true;

    settings = {
      app.shmFile = "/dev/shm/looking-glass";
      input = {
        #grabKeyboardOnFocus = true;
        rawMouse = true;
      };
      spice.alwaysShowCursor = true;
      win = {
        #fullScreen = true;
      };
      audio = {
        micDefault = "allow";
        micShowIndicator = false;
      };
    };
  };
}
