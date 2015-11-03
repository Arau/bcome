class ::Bcome::Ssh

  attr_reader :commands

  def initialize(commands, proxy, node)
    @commands = commands
    @proxy = proxy
    @node = node
  end

  def execute!
    ::Net::SSH.start(@node.ip_address, @node.ssh_user, :proxy => @proxy, :keys => @node.keys, :paranoid => false) do |ssh|
      @commands.each do |command|
        puts "(#{@node.identifier}) #{@user}$ #{command.raw_command}".command
        ssh_exec!(ssh, command)

        puts command.output

        print command.pretty_result
        puts "\n"
      end
      ssh.close
    end
  end

  def ssh_exec!(ssh, command)
    ssh.open_channel do |channel|
      channel.exec(command.raw_command) do |ch, success|
        unless success
          abort "FAILED: couldn't execute command (ssh.channel.exec)"
        end
        channel.on_data do |ch,data|
          command.stdout +=data
        end
        channel.on_extended_data do |ch,type,data|
          command.stderr +=data
        end
        channel.on_request("exit-status") do |ch,data|
          command.exit_code = data.read_long
        end
        channel.on_request("exit-signal") do |ch, data|
          command.exit_signal = data.read_long
        end
      end
    end
    ssh.loop
  end

end
