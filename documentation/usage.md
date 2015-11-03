# Usage & Commands

## How do I access bcome ?

### Entering the shell

```
> cd /your/installed/bcome/application/directory
> bcome
```

or, if with bundler

```
  > cd /your/installed/bcome/application/directory
  > bundle exec bcome
```

### Entering the shell and jumping to a quick link contexct

```
  > cd /your/installed/bcome/application/directory
  > bundle exec bcome your:quick:link
```

## Commands

### Root level commands

> menu
- Pull up a list of commands available at the current context level

> list / ls
- List all available resources at the current context.

> describe
- Describe the resource object at the current context.

> workon / w
- Select a resource object, and switch to its context.
e.g. workon 'identifier'

> exit
- Close the current context

> exit!
- Close all contexts, and exit Become.

> local
- Execute a shell command on your local machine.
e.g. local "command"


### Platform level commands

> menu
- Pull up a list of commands available at the current context level 

> list / ls
- List all available resources at the current context.

> describe
- Describe the resource object at the current context.

> workon / w
- Select a resource object, and switch to its context.
e.g. workon 'identifier' OR w 'identifier'

> exit
- Close the current context

> exit!
- Close all contexts, and exit Become.

> local
- Execute a shell command on your local machine.
e.g. local "command"


### Environment level commands

> menu
- Pull up a list of commands available at the current context level 

> list / ls
- List all available resources at the current context.

> describe
- Describe the resource object at the current context.

> workon / w
- Select a resource object, and switch to its context.
e.g. workon 'identifier'

> exit
- Close the current context

> exit!
- Close all contexts, and exit Become.

> local
- Execute a shell command on your local machine.
e.g. local "command"

> add
- Add a resource you wish to work on.
e.g. add 'identifier', OR add ['array', 'of', 'identifiers']

> add!
- Add all resources from the current context.

> remove
- Remove a resource you no longer with to work on.
e.g. remove 'identifier', OR remove ['array', 'of','identifiers']

> clear!
- Remove all selected resources.

> selections
- Show all added resources.

> rsync
- Rsync files to all selected resources.
e.g. rsync 'localpath', 'remotepath'

> run
- Execute a command on all selected resources
e.g. run 'command'

> scp
- SCP files up to all selected resources
e.g. scp ['array','of', 'file', 'paths'], 'remote_path'

### Instance level commands

> menu
- Pull up a list of commands available at the current context level

> list / ls
- List all available resources at the current context.

> describe
- Describe the resource object at the current context.

> workon / w
- Select a resource object, and switch to its context.
e.g. workon 'identifier'

> exit
- Close the current context

> exit!
- Close all contexts, and exit Become.

> local
- Execute a shell command on your local machine.
e.g. local "command"

> rsync
- Rsync files.
e.g. rsync 'localpath', 'remotepath'

> run
- Execute a command.
e.g. run 'command'

> scp
- SCP files.
e.g. scp ['array','of', 'file', 'paths'], 'remote_path'

> ssh
- Initiate an SSH connection.









