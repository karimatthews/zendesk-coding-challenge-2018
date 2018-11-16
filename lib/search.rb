# frozen_string_literal: true

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

  attr_accessor :tickets_path, :users_path, :organizations_path, :resource, :field, :search_term

  def initialize(tickets_path: '', users_path: '', organizations_path: '', user_input: {})
    @tickets_path = tickets_path
    @users_path = users_path
    @organizations_path = organizations_path

    @resource = user_input[:resource_type]
    @field = user_input[:data_field].tr(' ', '_')
    @search_term = user_input[:search_term]
  end

  def results
    puts search_message
    raw_results
  end

  def raw_results
    results_without_associated_data.map do |result|
      result_with_associated_data(result)
    end
  end

  private

    def results_without_associated_data
      dataset.select do |data|
        check_if_data_matches_query?(data)
      end
    end

    def check_if_data_matches_query?(data)
      case field_type
      when 'array'
        does_an_array_include_a_search_term?(data)
      when 'integer'
        data[field] == search_term.to_i
      when 'string'
        data[field] == search_term
      end
    end

    def does_an_array_include_a_search_term?(data)
      data[field]&.map(&:downcase)&.include?(search_term)
    end

    def field_type
      case field
      when 'tags', 'domain_names'
        'array'
      when '_id'
        resource == 'tickets' ? 'string' : 'integer'
      else
        'string'
      end
    end

    def search_message
      if search_term
        "\nSearching for #{resource.capitalize} with #{field.capitalize} \"#{search_term}\".\n\n"
      else
        "\nSearching for #{resource.capitalize} with no #{field.capitalize}.\n\n"
      end
    end

    def result_with_associated_data(result)
      case resource.capitalize
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

    def associated_organization_data(organization)
      organization['users'] = users.select { |u| u['organization_id'] == organization['_id'] }
      organization['tickets'] = tickets.select { |t| t['organization_id'] == organization['_id'] }
      organization
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
      send(resource)
    end

    def parse_json(file_path)
      file = File.read(file_path)
      JSON.parse(file)
    end

end
