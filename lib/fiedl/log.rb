require "fiedl/log/version"
require "fiedl/log/log"
require "colored"

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
  def shell(command)
    log.shell command
  end
end