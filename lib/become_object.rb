module ::Bcome::BecomeObject

  require 'yaml'

  CONFIGS_PATH = "bcome/config" 

  def identifier
    raise "Missing method 'identifier' - this should uniquely identify your workspace context object."
  end

  def become_identifier
    "#{previous_workspace_object.send(:become_identifier)}> #{identifier}"
  end

  def previous_workspace_object=(object)
    @previous_workspace_object = object
  end
  
  def previous_workspace_object
    @previous_workspace_object
  end

  def main_context=(main_context)
    @main_context = main_context
  end 

  def main_context
    @main_context
  end

  def has_main_context?
    !@main_context.nil?
  end

  def resources
    @resources ||= do_load_resources 
  end

  def do_load_resources
    config = YAML.load_file(config_path)
    return collection_klass.collection_from_config(self, config)
  end

  def resource_for_identifier(identifier)
    return nil unless resources
    matches = resources.select{|resource| resource.identifier.to_sym == identifier.to_sym }
    raise "Retrieved more than one match for #{collection_key} '#{identifier}'. Selection is ambiguous" if matches.size > 1
    return matches.first
  end

  def all_items
    return [] unless resources
    resources.collect(&:identifier)
  end

  def responds_to_list?
    true
  end  

  def list
    if responds_to_list?
      ::RENDER.list_items(collection_key, resources)
    else
      puts "\nNo list function at this level".headsup
    end   
  end
  alias :ls :list

end
