module ::Bcome::Selections

  def manage_object(method, resource_identifier = nil)
    unless resource_identifier && resource_identifier.is_a?(String)
      print "You must select a resource identified by its name. #{available_resources_options_string}".headsup
    else
      object = find_resource_by_identifier(resource_identifier)
      unless object
        print "Cannot find object with identifier #{resource_identifier} within the resources for this collection. #{available_resources_options_string}".failure unless object
      else
        send(method, object)
      end
    end
  end

  ## Runs commands over *every* object in the selection
  def run(raw_commands)
    return unless @objects
    @objects.each do |object|
      object.run(raw_commands)
    end
    return
  end

  def rsync(local_path, remote_path)
    if !@objects || @objects.empty?
      no_selections_error
      return  
    end
    @objects.each do |object|
      object.rsync(local_path, remote_path)
    end
    return
  end

  def scp(files, remote_path)
    if !@objects || @objects.empty?
      no_selections_error
      return
    end

    return unless @objects
    @objects.each do |object|
      object.scp(files, remote_path)
    end 
    return
  end  

  def add(resource_identifier = nil)
    if resource_identifier.is_a?(Array)
      resource_identifier.each do |ri|
        manage_object(:add_object, ri)
      end
    else
      manage_object(:add_object, resource_identifier)
    end
  end

  def remove(resource_identifier = nil)
    if resource_identifier.is_a?(Array)
      resource_identifier.each do |ri|
        manage_object(:remove_object, ri)
      end
    else
      manage_object(:remove_object, resource_identifier)
    end
  end

  def add!
    @objects = resources
    puts "All nodes added".informational
  end
  
  def clear!
    @objects = []
    selections
  end

  def find_resource_by_identifier(resource_identifier)
    resources.select{|r| r.identifier == resource_identifier }.first
  end

  def in_resources?(object)
    resources.include?(object)
  end

  def add_object(object)
    return if object_in_selections?(object)
    @objects = @objects ? (@objects << object) : [object]
    return
  end  

  def remove_object(object)
    return if !@objects || @objects.empty?
    unless object_in_selections?(object)
      print "\n#{object.identifier} is not within selections\n".headsup
    else
      @objects = @objects - [object]
    end
    return
  end

  def object_in_selections?(object)
    return false unless @objects
    return @objects.include?(object)
  end

  def selections
    if !@objects || @objects.empty?
      print "\nNo added nodes.\n".headsup
    else
      print "\nAdded nodes: #{@objects.collect(&:identifier).join(", ")}\n".headsup
    end
  end  

  def no_selections_error 
    puts "No nodes selected".informational
  end

end
