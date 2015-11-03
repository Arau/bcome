module ::Bcome::CommandHelper

  def run_local(command)
    puts "(local) > #{command}" if ::VERBOSE
    system(command)
  end
  alias :local :run_local

end
