module ::Bcome::Stack
  class Platform

    include ::Bcome::BecomeObject

    class << self
      def collection_from_config(parent, configuration)
        return unless configuration
        collection = []
        configuration.each do |conf_data|
          collection << new(conf_data[:name], conf_data)
        end
        return collection
      end
    end

    attr_reader :identifier
    attr_reader :quick_contexts

    def initialize(identifier, meta_data)
      @identifier = identifier
      @meta_data = meta_data
      @quick_contexts = @meta_data[:quick_contexts]
    end

    def menu_items
      super
    end

    def do_describe
      "#{identifier}\n - #{@meta_data[:description]}\n"
    end

    def config_path
      "#{CONFIGS_PATH}/network.yml"
    end

    def collection_klass
      ::ENV_STACK_KLASS
    end

    def reference_key
      :platforms
    end 

    def collection_key
      :environments
    end

    def has_quick_contexts?
      return !quick_contexts.nil?
    end

    def quick_context_for_reference(context_reference)
      return nil unless has_quick_contexts?
      matches = quick_contexts.select{|qc| qc[:ref] == context_reference }
      raise "Multiple quick context matches found on platform #{@identifier} for context key #{context_reference}. Cannot load quick context - selection is ambiguous." if matches.size > 1
      return matches.first 
    end
 
  end
end
