#!/usr/bin/env ruby
# frozen_string_literal: true

require './lib/search.rb'

tickets_path = '/Users/kari/Projects/zendesk-coding-challenge-2018/data/tickets.json'
users_path = '/Users/kari/Projects/zendesk-coding-challenge-2018/data/users.json'
organizations_path = '/Users/kari/Projects/zendesk-coding-challenge-2018/data/organizations.json'

Search.new(tickets_path, users_path, organizations_path).results
