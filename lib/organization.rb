# frozen_string_literal: true

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
    [
      data['name'],
      users ? users_string : nil,
      tickets ? tickets_string : nil
    ].compact
  end

  private

    def users_string
      user_names = users.map do |user|
        '  - ' + user['name']
      end

      "Users:\n" + user_names.join("\n")
    end

    def tickets_string
      org_tickets = tickets.map do |ticket|
        '  - ' + ticket['subject'] + ' | Status: ' + ticket['status']
      end

      "Tickets:\n" + org_tickets.join("\n")
    end

end
