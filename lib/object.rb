class Object

  include ::Bcome::CommandHelper

  def list
    BOOT.send(:list)  ### Our starting point in the hierarchy... maybe this is all ultimately configurable?
  end
  alias :ls :list

  def become_identifier
    ::START_PROMPT
  end

  def become(object)
    BECOME.set(object, self)
  end
 
  def toggle_sudo
    @sudo = @sudo.nil? ? true : (@sudo ? false : true)
    puts "sudo #{sudo_state.informational}"
    return
  end

  def is_sudo?
    @sudo
  end
 
  def sudo_state
    is_sudo? ? "on" : "off"
  end

  def workon(identifier)
    resource = resource_for_identifier(identifier)

    unless resource
      puts "No matching #{collection_key} for identifier '#{identifier}'. #{available_resources_options_string}".failure
    else
      puts "\\ \nFrom #{resource.reference_key}, working on #{identifier}\n".command
      become(resource)
    end
  end
  alias :w :workon

  def menu_items
    [
      { :command => "list / ls", :description => "List all available resources at the current context." },
      { :command => "describe", :description => "Describe the resource object at the current context." },
      { :command => "workon' / w", :description => "Select a resource object, and switch to its context.", :usage => "workon 'identifier'" },
      { :command => "exit", :description => "Return to the previous context" }, 
      { :command => "exit!", :description => "Close all contexts, and exit Become."},
      { :command => "local", :description => "Execute a shell command on your local machine.", :usage => 'local "command"'}
    ]
  end

  def menu
    ::RENDER.menu(menu_items)
  end

  def highlight?
    false  ## override in stack objects that should be highlighted within a list, e.g. instance objects at the environment level that have been selected to workon on
  end

  def available_resources_options_string
    "Please select from one of '#{all_items.join(', ')}'"
  end

  def describe
    if self.respond_to?(:do_describe)
      message = "\nCollection Key: #{reference_key}\n\nResource: #{self.do_describe}".colorize(:green)
    else
      message = "\nNothing to describe. Use 'list' to see namespace options".headsup unless self.respond_to?(:do_describe)
    end
    puts message
  end

  def set_irb_prompt(conf)
    conf[:PROMPT][:CUSTOM] = {
      :PROMPT_N => "\e[1m:\e[m ",
      :PROMPT_I => "\e[1m#{BECOME.irb_prompt} #{is_sudo? ? " sudo ".danger : ""}>\e[m ", # high voltage
      :PROMPT_C => "\e[1m#{BECOME.irb_prompt} >\e[m ",
      :RETURN => ::VERBOSE ? "%s \n" : "\n"
    }
    conf[:PROMPT_MODE] = :CUSTOM
  end

end
