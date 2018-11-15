# frozen_string_literal: true

require 'pry'
require 'minitest/autorun'
require 'stringio'

require_relative '../lib/search.rb'
require_relative '../lib/user_input.rb'

def puts(*args)
end

def json_fixture(file_path)
  file = File.read(file_path)
  JSON.parse(file)
end
