module ::Bcome::Stack
  class Instance

    include ::Bcome::BecomeObject
    include ::Bcome::InstanceSsh
    include ::Bcome::InstanceCommand

    class << self
      def collection_from_fog_data(parent, fog_instances)
        collection = []
        fog_instances.each do |f_instance|

          meta_data = {
            :identifier => f_instance.tags["Name"],
            :external_network_interface_address => f_instance.private_ip_address,
            :public_ip_address => f_instance.public_ip_address,
            :role => f_instance.tags["function"]
          }
          collection << new(meta_data, parent)
        end
        return collection
      end

      def collection_from_config(parent, configuration)
        conf_for_env = configuration[:instances]
        collection = []
        conf_for_env.each do |meta_data|
          collection << new(meta_data, parent) 
        end
        return collection
      end
    end

    attr_reader :environment

    def initialize(meta_data, parent)
      @meta_data = meta_data
      @environment = parent
    end

    def menu_items
      super + [
        { :command => "run", :description => "Execute a command.", :usage => "run 'command'" },
        { :command => "put", :description => "Copy files to remote (recursive - uses rsync)", :usage => "put 'local_path', 'remote_path'" },
        { :command => "get", :description => "Download from remote (recursive - uses rsync).", :usage => "get 'remote_path'"},
        { :command => "ssh", :description => "Initiate an SSH connection." },
        { :command => "sudo", :description => "Run 'get' and 'put' in sudo mode (assumes you have passwordless sudo setup)" }
      ]
    end

    def platform
      @environment.platform
    end

    def sudo 
      toggle_sudo
    end

    def namespace
      "#{@environment.namespace}/#{identifier}"
    end

    def is_sudo?
      super || @environment.is_sudo?
    end

    def responds_to_list?
      false
    end
 
    def identifier
      @meta_data[:identifier] 
    end

    def ip_address
     @environment.ssh_mode_type == ::SSH_DIRECT_MODE_IDENTIFIER ? public_ip_address : @meta_data[:external_network_interface_address]
    end

    def public_ip_address
      @meta_data[:public_ip_address]
    end

    def role
      @meta_data[:role]
    end

    def reference_key
      :instances
    end

    def highlight?
      @environment.object_in_selections?(self)
    end

    def do_describe
      description = "#{identifier}#{ is_sudo? ? " MODE: sudo "  : "" }"
      description += "\n\t* Internal IP #{@meta_data[:external_network_interface_address]}"
      description += "\n\t* External IP #{public_ip_address}" if public_ip_address
      description += "\n\t* #{role}" if role 
      description += "\n"
      return description    
    end

  end
end
