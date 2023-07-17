{pkgs, ... }: 
{
  boot = { 
    kernelModules = [ "vfio_pci" "vfio_iommu_type1" "vfio_pci" "vfio_virqfd" ];
    kernelParams = ["amd_iommu=on" "default_hugepagesz=1G" "hugepages=20" "vfio-pci.ids=10de:1b81,10de:10f0"];
    #kernelParams = ["amd_iommu=on" "default_hugepagesz=1G" "hugepages=20"];
    #initrd.kernelModules = [ "vfio_pci" "vfio_iommu_type1" "vfio" ];
  };
}
