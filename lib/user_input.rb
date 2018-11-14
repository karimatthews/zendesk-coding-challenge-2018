# frozen_string_literal: true

require 'json'
require 'pry'

require_relative 'resource.rb'
require_relative 'ticket.rb'
require_relative 'user.rb'
require_relative 'organization.rb'

class UserInput

  attr_accessor :resource_type, :data_field, :search_term

  TICKETS = 'Tickets'
  USERS = 'Users'
  ORGANIZATIONS = 'Organizations'

  def initialize
    set_attributes
  end

  def set_attributes
    puts "\nSearch for: \n\n#{TICKETS} \n#{USERS} \n#{ORGANIZATIONS}\n"
    self.resource_type = input_resource_type
    self.data_field = input_data_field
    self.search_term = input_search_term
  end

  def input_resource_type
    input = gets.chomp
    valid_input = %w[tickets users organizations].include?(input.downcase)

    if valid_input
      input.capitalize
    else
      warn "\nInvalid Input. Enter Tickets, Users, or Organizations.\n\n"
      # If the input is invalid get the user to try again.
      input_resource_type
    end
  end

  def input_data_field
    puts "\nSelect a field from: #{field_options.join(', ')}."
    gets.chomp

    # TODO: validate input and make it easier to select an option
  end

  def field_options
    resource_class.fields
  end

  def resource_class
    Object.const_get(@resource_type.chop.capitalize)
  end

  def input_search_term
    puts "\nAdd your search term:\n"
    gets.chomp
  end

end
