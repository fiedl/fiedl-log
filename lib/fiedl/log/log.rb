class Fiedl::Log::Log

  def head(text)
    info ""
    info "==========================================================".blue
    info text.blue
    info "==========================================================".blue
  end
  def section(heading)
    info ""
    info heading.blue
    info "----------------------------------------------------------".blue
  end
  def info(text)
    self.write text
  end
  def success(text)
    self.write text.green
  end
  def error(text)
    self.write text.red
  end
  def warning(text)
    self.write "Warning: ".yellow.bold + text.yellow
  end
  def prompt(text)
    self.write "$ " + text.bold
  end
  def write(text)
    @filter_out ||= []
    @filter_out.each do |expression|
      text = text.gsub(expression, "[...]")
    end
    print text + "\n"
  end
  def filter_out(expression)
    @filter_out ||= []
    @filter_out << expression
  end
  def filter(expression)
    filter_out expression
  end

  # Print commant, execute it and display result.
  # See also: http://stackoverflow.com/a/10224650/2066546
  #
  def shell(command)
    prompt command

    output = ""
    r, io = IO.pipe
    fork do
      system(command, out: io, err: :out)
    end
    io.close
    r.each_char{|c| print c; output += c}

    return output
  end

end