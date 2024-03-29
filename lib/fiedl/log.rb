require "fiedl/log/version"
require "fiedl/log/log"
require "colored"
require "pp"

STDOUT.sync = true

module Fiedl
  module Log
  end
end

unless defined? log
  def log
    @log ||= Fiedl::Log::Log.new
  end
end

unless defined? shell
  def shell(command, verbose: true)
    log.shell command, verbose: verbose
  end
end