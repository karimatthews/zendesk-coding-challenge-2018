#!/usr/bin/env ruby
# frozen_string_literal: true

require './lib/search.rb'

tickets_path = '/Users/kari/Projects/zendesk-coding-challenge-2018/data/tickets.json'
users_path = '/Users/kari/Projects/zendesk-coding-challenge-2018/data/users.json'
organizations_path = '/Users/kari/Projects/zendesk-coding-challenge-2018/data/organizations.json'

puts 'Welcome to Zendesk Search.'

input = UserInput.new

Search.new(
  tickets_path: tickets_path,
  users_path: users_path,
  organizations_path: organizations_path,
  user_input: input
)
      .results
