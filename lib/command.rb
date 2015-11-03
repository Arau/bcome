class ::Bcome::Command

  # Wraps a command. Convenient flex-point for logging etc

  attr_reader :raw_command, :host_node, :stdout, :stderr, :exit_code, :exit_signal 

  def initialize(raw_command, host_node)
    @raw_command = raw_command
    @host_node = host_node
    @stdout = ""
    @stderr = ""
    @exit_code = nil
    @exit_signal = nil
  end

  def pretty_result
    return is_success? ? "Success".success : "Failed".failure
  end

  def output
    command_output = is_success? ? @stdout : "Exit code: #{@exit_code}\n\nSTDERR: #{@stderr}"
    return "\n#{command_output}\n"
  end

  def is_success?
    exit_code == 0
  end

  def stdout=(data)
    @stdout = data #data.output
  end

  def stderr=(data)
    @stderr = data #data.output
  end

  def exit_code=(data)
    @exit_code = data
  end

  def exit_signal(data)
    @exit_signal = data
  end

end
