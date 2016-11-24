require "fiedl/log/version"
require "fiedl/log/log"
require "colored"

STDOUT.sync = true

module Fiedl
  module Log
  end
end

log = Fiedl::Log::Log.new unless defined? log