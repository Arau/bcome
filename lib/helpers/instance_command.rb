module ::Bcome::InstanceCommand

  def run(raw_commands)
    commands = raw_commands.is_a?(String) ? [raw_commands] : raw_commands
    execute_command(commands)
  end

  def execute_command(commands)
    @environment.execute_command(commands, self)
  end

  def put(local_path, remote_path)
    puts "rsync> #{self.identifier}".informational
    if @environment.ssh_mode_type == ::SSH_DIRECT_MODE_IDENTIFIER
      rsync_command = "rsync #{rsync_is_sudo}-av #{local_path} #{self.ssh_user}@#{self.ip_address}:#{remote_path}"
    else
      rsync_command = "rsync -av -e \"ssh -A #{self.ssh_user}@#{@environment.bastion_ip_address} ssh -o StrictHostKeyChecking=no\" #{rsync_is_sudo}#{local_path} #{self.ssh_user}@#{self.ip_address}:#{remote_path}"
    end
    run_local(rsync_command)
  end

  def get(remote_path, local_path = local_download_path)
    raise "No local path specified" unless local_path
    raise "No remote_path specified" unless remote_path

    if @environment.ssh_mode_type == ::SSH_DIRECT_MODE_IDENTIFIER
      rsync_command = "rsync #{rsync_is_sudo} -chavzP #{self.ssh_user}@#{self.ip_address}:#{remote_path} #{local_path}"
    else
      rsync_command = "rsync -chavzP -av -e \"ssh -A #{self.ssh_user}@#{@environment.bastion_ip_address} ssh -o StrictHostKeyChecking=no\" #{rsync_is_sudo}#{self.ssh_user}@#{self.ip_address}:#{remote_path} #{local_path}"
    end

    silent = true
    local("mkdir -p #{local_path}", silent)
    run_local(rsync_command)
    puts "done: files copied to #{local_path}".informational
  end

  def rsync_is_sudo
    is_sudo? ? " --rsync-path=\"sudo rsync\" " : ""
  end

end
