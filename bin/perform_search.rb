#!/usr/bin/env ruby
# frozen_string_literal: true

require './lib/search.rb'
require './lib/display/display_results.rb'

tickets_path = '/Users/kari/Projects/zendesk-coding-challenge-2018/data/tickets.json'
users_path = '/Users/kari/Projects/zendesk-coding-challenge-2018/data/users.json'
organizations_path = '/Users/kari/Projects/zendesk-coding-challenge-2018/data/organizations.json'

puts 'Welcome to Zendesk Search.'

input = UserInput.new

input_hash = {
  resource_type: input.resource_type,
  data_field: input.data_field,
  search_term: input.search_term
}

results = Search.new(
  tickets_path: tickets_path,
  users_path: users_path,
  organizations_path: organizations_path,
  user_input: input_hash
).results

resource_class = Object.const_get(input_hash[:resource_type].chop.capitalize)

DisplayResults.new.display(results, resource_class)
