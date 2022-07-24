require 'open3'

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
  # http://stackoverflow.com/a/10224650/2066546
  # https://stackoverflow.com/q/20072781/2066546
  # https://stackoverflow.com/a/29712307/2066546
  #
  def shell(command, verbose: true)
    prompt command if verbose

    result = []
    @return_stdout = []
    @return_stderr = []

    Open3::popen3(command) do |stdin, stdout, stderr, thread|
      stdin.sync = true
      stdout.sync = true
      stderr.sync = true

      t_out = Thread.new do
        while l = stdout.getc
          result << l
          @return_stdout << l
          putc l if verbose
        end
      end

      t_err = Thread.new do
        while l = stderr.getc
          result << l
          @return_stderr << l
          putc l if verbose
        end
      end

      t_stdin = Thread.new do
        loop do
          stdin.putc ARGF.getc
        end
      end

      thread.join
      t_err.join
      t_out.join
      t_stdin.kill

      @return_code = thread.value
    end

    return result.join
  end

  def return_code
    @return_code
  end

  def return_stderr
    @return_stderr.join
  end

  def return_stdout
    @return_stdout.join
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