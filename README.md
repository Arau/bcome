
## Bcome

Bcome is a server management framework. 

It aims to simplify your day to day server management tasks by enabling access to your various estates from a single shell.

* Access all machines across *all* your platforms and environments from one interface.  

* Execute commands across platforms on multiple machines simultaneously, harnessing the power of Ruby to assist with real-time orchestration.

* Simple configuration enables static or dynamic network discovery, exposing SCP, Rsync, and SSH, and direct command execution.  More commands and features to come.

* Fully customisable for extending the framework with custom commands & tasks.

* Easy integration into existing Ruby projects.

* Dynamic network discovery for EC2 hosted machines (more providers to come). Static network definitions for everything else.

* Transparent usage of locally configured SSH keys

## Security

The framework has no knowledge of your SSH keys, nor does it store them or interpret them in any way, merely acting as a transparent conduit for commands over SSH, with all commands being delegated to your underlying operating system.

## Safety

With great power etc - it is assumed that users have been given the correct privileges for the machines under their control, and that they understand the functions of this tool.

## Quick links

* [Installation](documentation/installation.md)
* [Configuration](documentation/configuration.md)
* [Usage & Commands](documentation/usage.md)

## Rapid overview

	### Enter bcome and list resources

![Enter bcome and list resources](https://s3-eu-west-1.amazonaws.com/becomegemreadmeassets/initial_list.png)

### List all servers within the selected platform and environment

![Server list](https://s3-eu-west-1.amazonaws.com/becomegemreadmeassets/list_servers.png)

### Select machines to work directly on

![Machine selection](https://s3-eu-west-1.amazonaws.com/becomegemreadmeassets/add_machines.png)

### Run commands on selected machines

![Run commands](https://s3-eu-west-1.amazonaws.com/becomegemreadmeassets/run_commands.png)

### Run multiple commands on selected machines

![Run multiple commands](https://s3-eu-west-1.amazonaws.com/becomegemreadmeassets/run_multiple_commands.png)

### SCP Files

![SCP Files](https://s3-eu-west-1.amazonaws.com/becomegemreadmeassets/scp_files.png)

### SSH to a machine

![SSH to a machine](https://s3-eu-west-1.amazonaws.com/becomegemreadmeassets/ssh_to_box.png)


### Use quick links (jump straight to a context)

![Quick context](https://s3-eu-west-1.amazonaws.com/becomegemreadmeassets/quick_links.png)

























