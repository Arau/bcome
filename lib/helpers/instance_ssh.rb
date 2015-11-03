module ::Bcome::InstanceSsh

  def execute_task(task_name, *args)
    begin
      public_send(task_name, *args)
    rescue ::Seahorse::Client::NetworkingError
      puts "Could not execute '#{task_name}'. Cannot initiate connection - check your network connection and try again.".failure
    end
  end

  def ssh
    execute_task(:do_ssh)
  end

  def do_ssh(command)
    result = execute_task(:run_local, command)
    raise "Unable to execute result" unless result # TODO node has not been bootstrapped most likely. Implement a fallback
    return result
  end
  
  def ssh_jump_command_to_bastion
    command = "ssh -o UserKnownHostsFile=/dev/null -i #{ssh_key_path} #{ssh_user}@#{bastion_ip_address}"
  end

  def ssh_jump_command_to_internal_node
    command = "ssh -o UserKnownHostsFile=/dev/null -i #{ssh_key_path} -o \"ProxyCommand ssh -W %h:%p -i #{ssh_key_path} #{ssh_user}@#{bastion_ip_address}\" #{ssh_user}@#{ip_address}"
  end

  def direct_ssh_command
    command = "ssh #{environment.ssh_mode_user}@#{public_ip_address}"
  end

  def ssh_user
    # defined by the environment or we fall back to the local user
    return @environment.ssh_mode_user ? @environment.ssh_mode_user : `whoami`.gsub("\n","")
  end

  def ssh_key_path
    "~/.ssh/id_rsa" 
  end

  def keys
    [ssh_key_path]
  end

  def bastion_ip_address
    return @environment.bastion_ip_address
  end

  def is_direct_ssh?
    environment.ssh_mode_type == ::SSH_DIRECT_MODE_IDENTIFIER
  end

  def is_jump_ssh?
    environment.ssh_mode_type == ::SSH_JUMP_MODE_IDENTIFIER
  end

  def ssh
    is_jump_ssh? ? (is_ssh_jump_host? ? do_ssh(ssh_jump_command_to_bastion) : do_ssh(ssh_jump_command_to_internal_node)) : do_ssh(direct_ssh_command)
  end

  def is_ssh_jump_host?
    @meta_data["role"] == ::SSH_JUMP_HOST_ROLE_IDENTIFIER
  end

end
