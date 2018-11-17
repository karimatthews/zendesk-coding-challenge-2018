# frozen_string_literal: true

require 'pry'
require 'pry-byebug'

require_relative 'ticket.rb'
require_relative 'user.rb'
require_relative 'organization.rb'

require_relative 'fetch_data.rb'

class Search

  TICKETS = 'Tickets'
  USERS = 'Users'
  ORGANIZATIONS = 'Organizations'

  attr_accessor :tickets, :users, :organizations, :resource, :field, :search_term

  def initialize(tickets_path: '', users_path: '', organizations_path: '', user_input: {})
    @tickets = FetchData.read_and_parse(tickets_path)
    @users = FetchData.read_and_parse(users_path)
    @organizations = FetchData.read_and_parse(organizations_path)

    @resource = user_input[:resource]
    @field = user_input[:field]
    @search_term = user_input[:search_term]
  end

  def results
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
      when 'other'
        data[field]&.to_s&.downcase == search_term
      end
    end

    def does_an_array_include_a_search_term?(data)
      data[field]&.map(&:downcase)&.include?(search_term)
    end

    def field_type
      case field
      when 'tags', 'domain_names'
        'array'
      else
        'other'
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

    def dataset
      # get the dataset we are searching on
      send(resource)
    end

    def find_user_by_id(user_id)
      users.find { |u| u['_id'] == user_id }
    end

    def find_organization_by_id(org_id)
      organizations.find { |o| o['_id'] == org_id }
    end

end
