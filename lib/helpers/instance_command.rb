module ::Bcome::InstanceCommand

  def run(raw_commands)
    commands = raw_commands.is_a?(String) ? [raw_commands] : raw_commands
    execute_command(commands)
  end

  def execute_command(commands)
    @environment.execute_command(commands, self)
  end

  def rsync(local_path, remote_path)
    puts "rsync> #{self.identifier}".informational
    if @environment.ssh_mode_type == ::SSH_DIRECT_MODE_IDENTIFIER
      rsync_command = "rsync -av #{local_path} #{self.ssh_user}@#{self.ip_address}:#{remote_path}"
    else
      rsync_command = "rsync -av -e \"ssh -A #{self.ssh_user}@#{@environment.bastion_ip_address} ssh -o StrictHostKeyChecking=no\" #{local_path} #{self.ssh_user}@#{self.ip_address}:#{remote_path}"
    end
    run_local(rsync_command)
  end

  def scp(files, remote_path)
    @environment.execute_scp_upload(files, remote_path, self)
    return
  end

end
