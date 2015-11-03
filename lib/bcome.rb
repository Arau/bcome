require 'irb'
require "irb/completion"
require 'colorize'
require 'aws-sdk'
require 'net/scp'
require 'net/ssh/proxy/command'
require 'fog'

Dir[File.dirname(__FILE__) + "/**/*.rb"].each {|file| require file }
