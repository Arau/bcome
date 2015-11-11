require 'irb'
require "irb/completion"
require 'colorize'
require 'aws-sdk'
require 'net/scp'
require 'net/ssh/proxy/command'
require 'fog'
require 'require_all'

require_all "#{File.dirname(__FILE__)}/../lib"
require_all "#{File.dirname(__FILE__)}/../filters"

