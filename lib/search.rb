# frozen_string_literal: true

require 'json'
require 'pry'

require_relative 'resource.rb'
require_relative 'ticket.rb'
require_relative 'user.rb'
require_relative 'organization.rb'

class Search

  TICKETS = 'Tickets'
  USERS = 'Users'
  ORGANIZATIONS = 'Organizations'

  def initialize(tickets_path, users_path, organizations_path)
    puts 'Welcome to Zendesk Search.'

    @tickets = parse_json(tickets_path)
    @users = parse_json(users_path)
    @organizations = parse_json(organizations_path)

    puts "\nSearch for: \n\n#{TICKETS} \n#{USERS} \n#{ORGANIZATIONS}"
    @resource_type = input_resource_type

    @data_field = input_data_field
    @search_term = input_search_term

    puts "\nSearching for #{@resource_type} with #{@data_field} \"#{@search_term}\".\n\n"
  end

  def results
    raw_results = dataset.select { |data| data[@data_field.downcase] == @search_term }

    formatted_results = raw_results.map do |raw_result|
      get_class(@resource_type).new(raw_result).readable_format
    end

    puts formatted_results
  end

  private

    def dataset
    # TODO: Clean this up
      case @resource_type
      when TICKETS
        @tickets
      when USERS
        @users
      when ORGANIZATIONS
        @organizations
      end
    end

    def input_resource_type
      input = gets.chomp
      valid_input = %w[tickets users organizations].include?(input.downcase)

      unless valid_input
        puts "\nInvalid Input. Enter Tickets, Users, or Organizations.\n"
        # If the input is invalid get the user to try again.
        input_resource_type
      end

      input.capitalize
    end

    def input_data_field
      puts "\nSelect a field from: #{field_options.join(', ')}."
      gets.chomp

      # TODO: validate input and make easier to select an option
    end

    def field_options
      get_class(@resource_type).fields
    end

    def get_class(_classname)
      Object.const_get(@resource_type.chop.capitalize)
    end

    def input_search_term
      puts 'Add your search term:'
      gets.chomp
    end

    def parse_json(file_path)
      file = File.read(file_path)
      JSON.parse(file)
    end

end
