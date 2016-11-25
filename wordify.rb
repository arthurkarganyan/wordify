require_relative 'lib/wordify'
require_relative 'env'
require 'pry'

puts Wordify.run(ARGV[1], ARGV[0])
