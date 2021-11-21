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
  def variable(variable, variable_name)
    self.write "#{variable_name.to_s.blue} = #{variable}"
  end
  def configuration(hash)
    pp hash
  end
  def write(text)
    self.p "#{text}\n"
  end
  def p(text)
    @filter_out ||= []
    @filter_out.each do |expression|
      text = text.gsub(expression, "[...]")
    end
    print text
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
  def shell(command, verbose: true)
    prompt command if verbose

    output = ""
    r, io = IO.pipe
    pid = fork do
      system(command, out: io, err: io)
    end
    io.close
    r.each_char{|c| (print c if verbose); output += c}

    Process.waitpid pid
    return output.strip
  end

  # Ensure that a certain file is present.
  #
  def ensure_file(filename, options = {})
    if File.exists?(filename)
      log.success "File: #{filename}"
    else
      log.error "Something went wrong. File #{filename} is missing."
      if options[:show_log]
        log.section "Last log"
        shell "tail -n 20 #{options[:show_log]}"
      end
      raise "File is missing."
    end
  end

end