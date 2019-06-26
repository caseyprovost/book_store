# frozen_string_literal: true
%w(
  categories
  properties
  option_types
  books
).each do |seed|
  puts "Loading seed file: #{seed}"
  require_relative "seeds/#{seed}"
end
