module ::Bcome::CommandHelper

  def run_local(command, silent = false)
    puts "(local) > #{command}" if !silent && ::VERBOSE
    system(command)
  end
  alias :local :run_local

end
