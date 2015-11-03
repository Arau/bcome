module ::Bcome::EnvironmentSSH

  def proxy
    return nil unless ssh_mode_type == ::SSH_JUMP_MODE_IDENTIFIER
    return Net::SSH::Proxy::Command.new(proxy_command)
  end

  def proxy_command
    return "ssh -W %h:%p #{bastion_ip_address}"
  end

  def execute_command(commands, node)
    begin
      return execute_cmd(commands, node, proxy)
    rescue Net::SSH::AuthenticationFailed
      raise "Could not authenticate connection to #{node.identifier}".failure
    rescue Net::SSH::Disconnect
      raise "SSH connection to #{node.identifier} was disconnected".failure
    end
  end

  def execute_cmd(raw_commands, node, proxy)
    commands = raw_commands.collect{|raw_command|
      raw_command.is_a?(::Bcome::Command) ? raw_command : ::Bcome::Command.new(raw_command, node)
    }

    ssh = ::Bcome::Ssh.new(commands, proxy, node)
    ssh.execute!
    return
  end

  def execute_scp_upload(files, remote_path, node)
    begin
      scp = ::Bcome::Scp.new(files, remote_path, proxy, node)
      scp.upload!
    rescue Net::SSH::AuthenticationFailed
      raise "Could not authenticate connection to #{node.identifier}".failure
    rescue Net::SSH::Disconnect 
      raise "SSH connection to #{node.identifier} was disconnected".failure
    end
  end        


end
