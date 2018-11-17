# frozen_string_literal: true

require 'pry'
require 'minitest/autorun'
require 'stringio'

require_relative '../lib/search.rb'
require_relative '../lib/user_input.rb'

require 'minitest/reporters'

reporter_options = { color: true }
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(reporter_options)]

def json_fixture(file_path)
  file = File.read(file_path)
  JSON.parse(file)
end
