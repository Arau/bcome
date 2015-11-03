# Configuration

## Define your platforms

Bcome assume that you have ‘platforms’. It assumes that a platform has ‘environments’, and that an environment has a collection of servers.

### The platforms config

The platforms merely lists what platforms you have, and provides quick links to elements within them.

Create your platforms.yml config file in path/to/your/application/bcome/configs

Example configurations can be found in path/to/your/application/bcome/configs/platform.yml-example

### The network config

The network config defines your environments within bcome - what they are, how they are accessed, and whether you with for Bcome to perform network discovery dynamically from EC2, or whether you have listed a static network list.

Create your network.yml config file in path/to/your/application/bcome/configs

Example configurations can be found in path/to/your/application/bcome/configs/network.yml-example

### Static network instances config

A static list of servers may be defined if you do not wish to enable dynamic network discovery.

These are to be found in path/to/your/application/bcome/configs/static_instances

Name your configuration file “[platformName]_[EnvironmentName]-instances.yml,

Two examples are given below:

Example 1:  Static instances accessible directly, without the need to travers a jump host

```
---
:instances:
  - :identifier: "app1"
    :role: "WebServer"
    :external_network_interface_address: &public_address “XX.XXX.XX.XX”
    :public_ip_address: *public_address
```


Example 2: Static instances accessible over a jump host

```
---
:instances:
  - :identifier: &bastion_server "bastionserver"
    :external_network_interface_address: "10.0.0.4"
  - :identifier: &puppet_master "puppetmaster"
    :role: "puppet_master"
    :external_network_interface_address: "10.0.0.5"
```

## EC2 Fog Configuration

Dynamic network lookups are against EC2 (with other platforms to follow).  It is expected that you have a .fog file installed in your home directory.  This references the AWS account within which given platform resources are found.

```
awsaccountone:
  aws_access_key_id: XXXXXXXXXXXXXXXXXXX
  aws_secret_access_key: XXXXXXXXXXXXXXXXXXXX
awsaccounttwo: # (cyfrif personol)
  aws_access_key_id: XXXXXXXXXXXXXXXXXX
  aws_secret_access_key: XXXXXXXXXXXXXXXXXXXXXXXXXXXXX
```

Within the platform.yml configuration, the aws account key is referenced by ‘credentials_key’

