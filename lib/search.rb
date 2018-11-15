# frozen_string_literal: true

require 'json'
require 'pry'
require 'pry-byebug'

require_relative 'ticket.rb'
require_relative 'user.rb'
require_relative 'organization.rb'
require_relative 'user_input.rb'

class Search

  TICKETS = 'Tickets'
  USERS = 'Users'
  ORGANIZATIONS = 'Organizations'

  attr_reader :user_input, :tickets_path, :users_path, :organizations_path

  def initialize(tickets_path: '', users_path: '', organizations_path: '', user_input: {})
    @tickets_path = tickets_path
    @users_path = users_path
    @organizations_path = organizations_path
    @user_input = user_input
  end

  def results
    puts "\nSearching for #{user_input[:resource_type]} with "\
    "#{user_input[:data_field]} \"#{user_input[:search_term]}\".\n\n"

    raw_results
  end

  def raw_results
    results = dataset.select do |data|
      data[user_input[:data_field].downcase] == user_input[:search_term]
    end

    results.map do |result|
      result_with_associated_data(result)
    end
  end

  private

    def result_with_associated_data(result)
      case user_input[:resource_type].capitalize
      when TICKETS
        associated_ticket_data(result)
      when USERS
        associated_user_data(result)
      when ORGANIZATIONS
        associated_organization_data(result)
      end
    end

    def associated_ticket_data(ticket)
      ticket['submitter'] = find_user_by_id(ticket['submitter_id'])
      ticket['assignee'] = find_user_by_id(ticket['assignee_id'])
      ticket['organization'] = find_organization_by_id(ticket['organization_id'])
      ticket
    end

    def associated_user_data(user)
      user['organization'] = find_organization_by_id(user['organization_id'])

      user['assigned_tickets'] = tickets.select { |t| t['assignee_id'] == user['_id'] }
      user['submitted_tickets'] = tickets.select { |t| t['submitter_id'] == user['_id'] }
      user
    end

    def find_user_by_id(user_id)
      users.find { |u| u['_id'] == user_id }
    end

    def find_organization_by_id(org_id)
      organizations.find { |o| o['_id'] == org_id }
    end

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

      case user_input[:resource_type].capitalize
      when TICKETS
        tickets
      when USERS
        users
      when ORGANIZATIONS
        organizations
      end
    end

    def parse_json(file_path)
      file = File.read(file_path)
      JSON.parse(file)
    end

    def index_data(data)
      hash = {}
      data.each do |entry|
        id = entry['_id']
        hash[id] = entry
      end
      hash
    end

end
