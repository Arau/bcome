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

end
