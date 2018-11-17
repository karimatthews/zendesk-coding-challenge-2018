# frozen_string_literal: true

require 'pry'
require 'pry-byebug'

require_relative 'ticket.rb'
require_relative 'user.rb'
require_relative 'organization.rb'
require_relative 'user_input.rb'

class FetchData

  def self.read_and_parse(file_path)
    parse_json(file_path)
  end

  def self.parse_json(file_path)
    file = File.read(file_path)
    JSON.parse(file)
  end

end
