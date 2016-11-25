require_relative 'lib/wordify'
require_relative 'env'
require 'pry'

def args_explain
  puts "Usage: "
  puts "ruby wordify.rb ru 23 # => двадцать три"
  puts "ruby wordify.rb en 71 # => seventy-one"
end

def execute
  return args_explain unless ARGV[0]
  return args_explain unless ARGV[1]
  puts Wordify.run(ARGV[1], ARGV[0])
end

execute

