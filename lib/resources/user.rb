# frozen_string_literal: true

require_relative '../display.rb'

class User

  attr_reader :data, :organization, :submitted_tickets, :assigned_tickets

  def initialize(data)
    @data = data
    @organization = data['organization']
    @submitted_tickets = data['submitted_tickets']
    @assigned_tickets = data['assigned_tickets']
  end

  def self.fields
    %w[
      _id url external_id name alias active verified shared locale
      timezone email phone signature tags suspended role
    ]
  end

  def readable_format
    user_data.join("\n") + "\n\n"
  end

  def user_data
    (basic_user_data + extra_user_data + timestamps + associated_user_data).compact
  end

  private

    def basic_user_data
      [
        "Name: #{user_name_string}",
        "Signature: #{data['signature']}",
        "Contact: #{data['email']} | #{data['phone']}",
        organization_string,
        "Role: #{data['role']}",
        "Id: #{data['_id']}",
        tags_string,
        "Time Zone: #{data['timezone']}"
      ]
    end

    def associated_user_data
      [
        assigned_tickets ? tickets_string(assigned_tickets, 'Assigned') : nil,
        submitted_tickets ? tickets_string(submitted_tickets, 'Submitted') : nil
      ]
    end

    def extra_user_data
      [
        "Url: #{data['url']}",
        "External Id: #{data['external_id']}",
        "Active: #{data['active']}",
        "Verified: #{data['verified']}",
        "Shared: #{data['shared']}",
        "Locale: #{data['locale']}",
        "Suspended: #{data['suspended']}"
      ]
    end

    def timestamps
      created_at_time = Display.format_time(data['created_at'])
      last_login_at = Display.format_time(data['last_login_at'])

      [
        "Created At: #{created_at_time}",
        "Last Login At: #{last_login_at}"
      ]
    end

    def tags_string
      readable_tags = data['tags'].join(', ')
      data['tags'] ? "Tags: #{readable_tags}" : nil
    end

    def organization_string
      organization ? "Organization: #{organization['name']}" : nil
    end

    def user_name_string
      data['alias'] ? data['name'] + ' (' + data['alias'] + ')' : data['name']
    end

    def tickets_string(tickets, type)
      formatted_tickets = tickets.map do |ticket|
        '  - ' + ticket['subject'] + ' | Id: ' + ticket['_id']
      end

      type.capitalize + " Tickets:\n" + formatted_tickets.join("\n")
    end

end
