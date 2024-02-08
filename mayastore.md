# mayastore

```
sudo modprobe nvme_tcp
echo vm.nr_hugepages = 1024 | sudo tee -a /etc/sysctl.conf
echo "nvme_tcp" | sudo tee /etc/modules-load.d/nvme_tcp.conf
systemctl restart k0sworker
```


wipefs to `util-linux` to clean disk for diskpool