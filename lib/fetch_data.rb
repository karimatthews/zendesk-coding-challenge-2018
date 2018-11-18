# frozen_string_literal: true

require 'pry'
require 'pry-byebug'

require_relative 'resources/ticket.rb'
require_relative 'resources/user.rb'
require_relative 'resources/organization.rb'

class FetchData

  def self.read_and_parse(file_path)
    parse_json(file_path)
  end

  def self.parse_json(file_path)
    file = File.read(file_path)
    JSON.parse(file)
  end

end
