# frozen_string_literal: true

require_relative 'search.rb'
require_relative 'display.rb'
require_relative 'user_input.rb'
require_relative 'fetch_data.rb'

# Paths to data files. Change these if your data lives somewhere else.
TICKETS_PATH = 'data/tickets.json'
USERS_PATH = 'data/users.json'
ORGANIZATIONS_PATH = 'data/organizations.json'

class PerformSearch

  attr_accessor :display, :tickets, :users, :organizations, :resource, :field, :search_term

  def initialize
    @display = Display.new
  end

  def process
    display.welcome_message

    fetch_data

    receive_user_input

    results = perform_search_and_get_results

    display.results(results, resource)
  end

  def fetch_data
    # Fetch data
    @tickets = FetchData.new(TICKETS_PATH).read_and_parse
    @users = FetchData.new(USERS_PATH).read_and_parse
    @organizations = FetchData.new(ORGANIZATIONS_PATH).read_and_parse

    # Tell the user the data has been successfully read
    display.data_has_been_read
  end

  def receive_user_input
    # Get user input
    input = UserInput.new(display)
    @resource = input.resource
    @field = input.field(resource)
    @search_term = input.search_term(resource, field)
  end

  def perform_search_and_get_results
    display.search_message(resource, field, search_term)

    Search.new(
      tickets: tickets,
      users: users,
      organizations: organizations,
      resource: resource,
      field: field,
      search_term: search_term
    ).results
  end

end
