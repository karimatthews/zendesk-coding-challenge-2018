# frozen_string_literal: true

require_relative '../display.rb'

class Organization

  attr_reader :data, :users, :tickets

  def initialize(data)
    @data = data
    @users = data['users']
    @tickets = data['tickets']
  end

  def self.fields
    # All fields except time stamps
    %w[_id url external_id name domain_names details shared_tickets tags]
  end

  def readable_format
    organization_data.join("\n") + "\n\n"
  end

  def organization_data
    (basic_data + extra_data).compact
  end

  private

    def basic_data
      [
        "Name: #{data['name']}",
        "Id: #{data['_id']}",
        "Details: #{data['details']}"
      ]
    end

    def extra_data
      [
        created_at_string,
        domain_names_string,
        "Shared Tickets: #{data['shared_tickets']}",
        tags_string,
        users ? users_string : nil,
        tickets ? tickets_string : nil
      ]
    end

    def users_string
      user_names = users.map do |user|
        "  - #{user['name']} | Id: #{user['_id']}"
      end

      "Users:\n" + user_names.join("\n")
    end

    def tickets_string
      org_tickets = tickets.map do |ticket|
        '  - ' + ticket['subject'] + ' | Id: ' + ticket['_id']
      end

      "Tickets:\n" + org_tickets.join("\n")
    end

    def tags_string
      readable_tags = data['tags'].join(', ')
      data['tags'] ? "Tags: #{readable_tags}" : nil
    end

    def domain_names_string
      readable_tags = data['domain_names'].join(', ')
      data['domain_names'] ? "Domain Names: #{readable_tags}" : nil
    end

    def created_at_string
      return if data['created_at'].nil?

      formatted_time = Display.format_time(data['created_at'])
      "Created at: #{formatted_time}"
    end

end
