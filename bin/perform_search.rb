#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../lib/search.rb'
require_relative '../lib/display.rb'
require_relative '../lib/user_input.rb'

tickets_path = 'data/tickets.json'
users_path = 'data/users.json'
organizations_path = 'data/organizations.json'

display = Display.new

display.welcome_message

# Get user input
input = UserInput.new(display)
resource = input.resource
field = input.field(resource)
search_term = input.search_term(resource, field)

display.search_message(resource, field, search_term)

results = Search.new(
  tickets_path: tickets_path,
  users_path: users_path,
  organizations_path: organizations_path,
  user_input: { resource: resource, field: field, search_term: search_term }
).results

display.results(results, resource)
