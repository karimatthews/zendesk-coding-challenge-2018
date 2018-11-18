#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../lib/search.rb'
require_relative '../lib/display.rb'
require_relative '../lib/user_input.rb'
require_relative '../lib/fetch_data.rb'

# Paths to data files. Change these if your data lives somewhere else.
tickets_path = 'data/tickets.json'
users_path = 'data/users.json'
organizations_path = 'data/organizations.json'

display = Display.new

# Welcome the user
display.welcome_message

# Fetch data
tickets = FetchData.new(tickets_path).read_and_parse
users = FetchData.new(users_path).read_and_parse
organizations = FetchData.new(organizations_path).read_and_parse

# Tell the user the data has been successfully read
display.data_has_been_read

# Get user input
input = UserInput.new(display)
resource = input.resource
field = input.field(resource)
search_term = input.search_term(resource, field)

display.search_message(resource, field, search_term)

results = Search.new(
  tickets: tickets,
  users: users,
  organizations: organizations,
  resource: resource,
  field: field,
  search_term: search_term
).results

display.results(results, resource)
