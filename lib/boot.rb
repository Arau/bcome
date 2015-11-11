class ::Bcome::Boot

  include ::Bcome::BecomeObject

  def config_path
    "#{CONFIGS_PATH}/platform.yml"
  end

  def collection_klass 
    ::PLATFORM_STACK_KLASS
  end  

  def collection_key
    :platforms
  end

  def to_s
    "Bootup"
  end

  def become_identifier
    ::START_PROMPT
  end

  def namespace
    starting_namespace
  end

  def starting_namespace
    ""  # Used to determine where to store downloaded file - this is the start point directory, relative to the bcome install directory
  end

end
