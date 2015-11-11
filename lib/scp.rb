class ::Bcome::Scp

   def initialize(proxy, node)
    @proxy = proxy
    @node = node
  end

  def download!(remote_path, local_path = @node.local_download_path)
    local("mkdir -p #{local_path}", true)
    ::Net::SCP.start(@node.ip_address, @node.ssh_user, { :proxy => @proxy, :keys => @node.keys, :paranoid => false }) do |scp|
      scp.download!(remote_path, local_path, { :recursive => true, :preserve => true, :verbose => true }) do |cha, name, received, total|
        pct = received / total.to_f
        cnt = ( 72 * pct ).ceil
        print "%-72s %.2f%%\r" % [ ("#" * cnt), ( pct * 100 ) ]
      end
    end
    puts "done: files copied to #{local_path}".informational
  end

  def upload!(files, remote_path)
    puts "scp> #{@node.identifier}".informational
    ::Net::SCP.start(@node.ip_address, @node.ssh_user, { :proxy => @proxy, :keys => @node.keys, :paranoid => false }) do |scp|
      files = files.is_a?(Array) ? files : [files]
      files.each do |local_path|
        name_old = ""
        scp.upload!(local_path, remote_path, { :recursive => true }) do |ch, name, sent, total|
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
