# frozen_string_literal: true

class User

  attr_reader :data, :organization, :submitted_tickets, :assigned_tickets

  def initialize(data)
    @data = data
    @organization = data['organization']
    @submitted_tickets = data['submitted_tickets']
    @assigned_tickets = data['assigned_tickets']
  end

  def self.fields
    %w[name alias active verified email phone signature suspended role]
  end

  def readable_format
    user_data.join("\n") + "\n\n"
  end

  def user_data
    [
      user_name_text,
      data['email'],
      data['phone'],
      "Organization: #{organization['name']}",
      "Role: #{data['role']}",
      assigned_tickets ? assigned_tickets_string : nil,
      submitted_tickets ? submitted_tickets_string : nil
    ].compact
  end

  private

    def user_name_text
      data['alias'] ? data['name'] + ' (' + data['alias'] + ')' : data['name']
    end

    def submitted_tickets_string
      tickets = submitted_tickets.map do |ticket|
        '  - ' + ticket['subject'] + ' | Status: ' + ticket['status']
      end

      "Submitted Tickets:\n" + tickets.join("\n")
    end

    def assigned_tickets_string
      tickets = assigned_tickets.map do |ticket|
        '  - ' + ticket['subject'] + ' | Status: ' + ticket['status']
      end

      "Assigned Tickets:\n" + tickets.join("\n")
    end

end
