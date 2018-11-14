# frozen_string_literal: true

require 'json'
require 'pry'

require_relative 'resource.rb'
require_relative 'ticket.rb'
require_relative 'user.rb'
require_relative 'organization.rb'
require_relative 'user_input.rb'

class Search

  TICKETS = 'Tickets'
  USERS = 'Users'
  ORGANIZATIONS = 'Organizations'

  attr_reader :user_input, :tickets_path, :users_path, :organizations_path

  def initialize(tickets_path: '', users_path: '', organizations_path: '', user_input: nil)
    @tickets_path = tickets_path
    @users_path = users_path
    @organizations_path = organizations_path
    @user_input = user_input
  end

  def results
    puts "\nSearching for #{user_input.resource_type} with "\
    "#{user_input.data_field} \"#{user_input.search_term}\".\n\n"

    puts raw_results.empty? ? 'Sorry, your search has return no results.' : formatted_results

    # Return the raw object (primariy for testing purposes)
    raw_results
  end

  def formatted_results
    raw_results.map do |raw_result|
      resource_class.new(raw_result).readable_format
    end
  end

  def raw_results
    @raw_results ||= dataset.select do |data|
      data[user_input.data_field.downcase] == user_input.search_term
    end
  end

  private

    def tickets
      @tickets ||= parse_json(tickets_path)
    end

    def users
      @users ||= parse_json(users_path)
    end

    def organizations
      @organizations ||= parse_json(organizations_path)
    end

    def dataset
      # TODO: Clean this up
      case user_input.resource_type
      when TICKETS
        tickets
      when USERS
        users
      when ORGANIZATIONS
        organizations
      end
    end

    def resource_class
      Object.const_get(user_input.resource_type.chop.capitalize)
    end

    def parse_json(file_path)
      file = File.read(file_path)
      JSON.parse(file)
    end

end
