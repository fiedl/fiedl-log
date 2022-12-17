require 'tempfile'

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

  def raise(text)
    self.error(text.bold)
    super(text)
  end

  # Print command, execute it and display result.
  # The command may be interactive.
  #
  # https://stackoverflow.com/a/20187740/2066546
  # http://stackoverflow.com/a/10224650/2066546
  # https://stackoverflow.com/q/20072781/2066546
  # https://stackoverflow.com/a/29712307/2066546
  #
  def shell(command, verbose: true)
    prompt command if verbose

    file = Tempfile.new("fiedl-log")
    @return_code = system "script -q #{file.path} #{command}"
    output = file.read

    return output
  ensure
    file.close
    file.unlink
  end

  def return_code
    @return_code
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