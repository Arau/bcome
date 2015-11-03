module ::Bcome::Stack
  class Environment

    include ::Bcome::BecomeObject
    include ::Bcome::Selections
    include ::Bcome::FogHelper
    include ::Bcome::EnvironmentSSH

    class << self
      def collection_from_config(parent, configuration)
        collection = []
        configuration.each do |meta_data|
          collection << new(meta_data, parent) if meta_data[:network].to_s == parent.identifier.to_s 
        end
        return collection
      end
    end

    attr_reader :identifier, :platform, :meta_data

    def initialize(meta_data, parent)
      @meta_data = meta_data
      @identifier = meta_data[:environment]
      @platform = parent
    end  

    def menu_items
      super + [
        { :command => "add", :description => "Add a resource you wish to work on.", :usage => "add 'identifier', OR add ['array', 'of', 'identifiers']" },
        { :command => "add!", :description => "Add all resources from the current context." },
        { :command => "remove", :description => "Remove a resource you no longer with to work on.", :usage => "remove 'identifier', OR remove ['array', 'of','identifiers']" },
        { :command => "clear!", :description => "Remove all selected resources." },
        { :command => "selections", :description => "Show all added resources." },
        { :command => "rsync", :description => "Rsync files to all selected resources.", :usage => "rsync 'localpath', 'remotepath'" },
        { :command => "run", :description => "Execute a command on all selected resources", :usage => "run 'command'" },
        { :command => "scp", :description => "SCP files up to all selected resources", :usage => "scp ['array','of', 'file', 'paths'], 'remote_path'" },
      ]
    end
  
    def bastion_server
      resources.select{|resource| resource.identifier == @meta_data[:ssh_mode][:jump_host_identifier] }.first
    end

    def ssh_mode_type
      ssh_mode_type = @meta_data[:ssh_mode][:type]
      raise "Invalid ssh mode type #{ssh_mode_type}. Should be one of #{valid_ssh_modes.join(", ")}".failure unless valid_ssh_modes.include?(ssh_mode_type)
      return @meta_data[:ssh_mode][:type]
    end

    def ssh_mode_user
      return @meta_data[:ssh_mode][:ssh_user]
    end 

    def valid_ssh_modes
      [::SSH_JUMP_MODE_IDENTIFIER, ::SSH_DIRECT_MODE_IDENTIFIER]
    end
 
    def bastion_ip_address
      if dynamic_network_lookup?  
        return bastion_server.public_ip_address
      else
        bastion_ip_address = @meta_data[:ssh_mode][:jump_host_ip_address]
        raise "No jump_host_ip_address specified in your configuration.".failure unless bastion_ip_address
        return bastion_ip_address
      end
    end

    def network_lookup
      raise "Missing network lookup in networks_environment configuration".failure unless @meta_data[:network_lookup]
      return @meta_data[:network_lookup]
    end

    def network_lookup_type
      type = network_lookup[:type]
      raise "Unknown network lookup type '#{type}" unless ["dynamic", "static"].include?(type)
      return type
    end

    def dynamic_network_lookup?
      return network_lookup_type == "dynamic"
    end

    def do_load_resources
     if dynamic_network_lookup? 
       return collection_klass.collection_from_fog_data(self, servers)
     else
       path = config_path
       raise "Missing instances.yml configuration for your environment. You've selected a static network lookup, and yet I cannot find #{config_path}".failure unless File.exist?(config_path)
       config = YAML.load_file(path)
       return collection_klass.collection_from_config(self, config)
     end
    end

    def config_path
      "#{CONFIGS_PATH}/static_instances/#{platform.identifier}_#{identifier}-instances.yml"
    end

    def do_describe
      desc = "#{identifier}"
      desc += "\t[ Net lookup: #{network_lookup_type}"
      desc += "\t * SSH Mode: #{ssh_mode_type} ]"
    end

    def collection_klass
      ::INSTANCE_STACK_KLASS
    end

    def reference_key
      :environments
    end

    def collection_key
      :instances
    end 

  end
end
