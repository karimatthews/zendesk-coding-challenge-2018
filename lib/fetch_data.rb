# frozen_string_literal: true

require 'pry'
require 'pry-byebug'

require_relative 'resources/ticket.rb'
require_relative 'resources/user.rb'
require_relative 'resources/organization.rb'

class FetchData

  attr_accessor :file_path

  def initialize(file_path)
    @file_path = file_path
  end

  def read_and_parse
    file = read_file
    parse_json(file)
  end

  def read_file
    File.read(file_path)
  rescue StandardError
    message = "Cannot find file at '#{file_path}.''"
    Kernel.abort(message)
  end

  def parse_json(file)
    JSON.parse(file)
  rescue JSON::ParserError
    message = "The data in '#{file_path}' contains invalid JSON. "\
    'Ensure the data is formatted correctly before trying again.'
    Kernel.abort(message)
  end

end
