# k0s-cluster

Repo to store k0s configurations

## Deploying a new k0s cluster

K0s provides the capability to deploy multi-node clusters using a single configuration file. This makes starting a new cluster easy and fast.

### Local Ops configurations

Before deploying k0s nodes, we need to prepare the them. To do so, we can use a few templates from `Local Ops` repo. Normaly, you should run controller nodes in lxc containers and worker nodes directly bare-metal, but this is not mandatory for having a working cluster. It is simply best practice to maximize resource efficiency since controller nodes do not require lots of resources.
For testing purposes, using 1 controller with 1 or multiple workers is fine. Otherwise, it is recommanded to use at least 3 controller nodes and put them behind a load balancer.

#### Controller nodes

For each controller node, you will configure a new lxc container using the configuration in `Local Ops`. These should be similar to this one:

```yml
k0s-ctl1-dom1.mar.eosn.io:
  template: k0s-controller
  site: march
  subnets:
    primary1:
      ipv4_address: 1.2.3.4
  nrpe_monitors:
    - generic
  prometheus_monitors:
    - cadvisor
    - pushstats
  user:
    - myUser
  operational_mode: production
  lxc_host: dom1
```

Make sure you are using `k0s-controller` template and that you have added your user if it is not already include in the `k0s-controller` template (see `etc/templates/k0s`). The IP need to be changed. To do so, please refer to the [IP ranges](#ips-ranges-17222126x). Adjust the name to with the site and lxc_host.

#### Worker nodes

Similar to controller nodes, you will configure a new full server to have a worker node. Create as many as you need for your work load. In the case you need to add worker nodes, follow [these instruction](#add-nodes-to-an-existing-cluster)

```yml
dom1.mar.eosn.io:
    template: dom-k0s-worker
    site: march
    subnets:
      primary1:
        ipv4_address: 172.21.1.1
        subnet_gateway: suppress
    nrpe_monitors:
      - generic
      - dom-normal
      - zfs-small
    prometheus_monitors:
      - cadvisor
      - node
      - smartctl
    operational_mode: production
    add_zfs: true
    zfs_pool:
      - ssd
    users:
      - myUser
```

Again, pay attention to the template, user and IP. The template `dom-k0s-worker` need to be used for workers.

#### K0s user ssh key

K0s uses ssh to install and configure each node. A `k0s` user with special permissions has been created to accomplish this task. To utilize this user, you will need the proper ssh key. You can find it on the ops server in the secrets folder. Copy it to `~/.ssh/k0s_rsa` to easily use it.

#### Nginx




### Local machine configuration

On your local machine, [install the CLI `k0sctl`](https://github.com/k0sproject/k0sctl?tab=readme-ov-file#installation)

To make sure it is properly install, run:

```sh
k0sctl version
```

You are now ready to create your cluster!

### Cluster creation

Now is the time to configure your cluster. To do so, create a new `k0s-...yaml` file. You can use one of the exisiting file in this repository as a base.

### Add nodes to an existing cluster

## IPs ranges (172.22.126.X)

**keepalived**: 11-20

**nginx**: 21-50

**LXC controllers**: 51-200

**Dom workers**: keep the IP of the dom server

**IP pool (metallb)**: 201-254
