class String

  def informational
    self.colorize(:white).on_green
  end

  def command
    self.colorize(:black).on_white
  end

  def failure
    self.colorize(:red).on_white
  end

  def success
    self.friendly
  end

  def friendly
    self.colorize(:black).on_green
  end 

  def warning
    self.colorize(:orange).on_black
  end

  def menu
    self.colorize(:yellow).on_black
  end

  def headsup
    self.colorize(:yellow).on_black
  end

  def output
    self
  end

  def bg_gray 
    "\033[47m#{self}\033[0m"
  end

end
