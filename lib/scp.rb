class ::Bcome::Scp

  def initialize(files, remote_path, proxy, node)
    @files = files
    @proxy = proxy
    @node = node
    @remote_path = remote_path
  end

  def upload!
    puts "scp> #{@node.identifier}".informational
    ::Net::SCP.start(@node.ip_address, @node.ssh_user, { :proxy => @proxy, :keys => @node.keys, :paranoid => false }) do |scp|
      @files.each do |local_path|
        name_old = ""
        scp.upload!(local_path, @remote_path, { :recursive => true }) do |ch, name, sent, total|
        log_string = "#{name}: #{sent}/#{total}"
        if name_old == name
            STDOUT.write "\r#{log_string}"
          else
            STDOUT.write "\n\r#{log_string}"
          end
          name_old = name
        end
      end
    end
    puts # we don't control the output here, this moves us down a line:
  end

end
