class ::Bcome::WorkspaceContext  

  attr_reader :object

  def set(object, current_object, spawn = true)
    @object = object
    main_context = IRB.conf[:MAIN_CONTEXT]
    @object.main_context = main_context.workspace if main_context
    @object.previous_workspace_object = current_object if current_object

    # Spawn is initiated when a user wants to shift workspace context.
    # We don't spawn whilst setting up the hierarchy for quick contexts 
    spawn_for_object(@object) if spawn
    return
  end

  def spawn_for_object(object)
    require 'irb/ext/multi-irb'
    IRB.parse_opts_with_ignoring_script
    IRB.irb nil, @object
  end

  def has_object?
    !self.object.nil?
  end

  def start_prompt
    ::START_PROMPT
  end

  def irb_prompt
    @object ? @object.send(:become_identifier) : start_prompt
  end

  def is_sudo?
    @object.is_sudo?
  end

end
