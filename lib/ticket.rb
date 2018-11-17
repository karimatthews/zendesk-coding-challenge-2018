# frozen_string_literal: true

require_relative '../lib/display.rb'

class Ticket

  attr_reader :data, :submitter, :assignee, :organization

  def initialize(data)
    @data = data
    @submitter = data['submitter']
    @assignee = data['assignee']
    @organization = data['organization']
  end

  def self.fields
    %w[_id url external_id type subject description priority status tags has_incidents via]
  end

  def readable_format
    ticket_data.join("\n") + "\n\n"
  end

  def ticket_data
    (basic_ticket_data + extra_ticket_data).compact
  end

  private

    def basic_ticket_data
      [
        "Subject: #{data['subject']}",
        "Id: #{data['_id']}",
        "Status: #{data['status']}",
        "Priority: #{data['priority']}",
        "Description: #{data['description']}",
        submitter_text,
        assignee_text,
        organization_text
      ]
    end

    def submitter_text
      submitter ? "Submitted by: #{submitter['name']} | Id: #{submitter['_id']}" : nil
    end

    def assignee_text
      assignee ? "Assigned to: #{assignee['name']} | Id: #{assignee['_id']}" : nil
    end

    def organization_text
      organization ? "Organization: #{organization['name']} | Id: #{organization['_id']}" : nil
    end

    def extra_ticket_data
      [
        "External Id: #{data['external_id']}",
        "Url: #{data['url']}",
        tags_string,
        due_at_string,
        "Has Incidents: #{data['has_incidents']}",
        "Via: #{data['via']}"
      ]
    end

    def tags_string
      readable_tags = data['tags'].join(', ')
      data['tags'] ? "Tags: #{readable_tags}" : nil
    end

    def due_at_string
      return if data['due_at'].nil?

      formatted_time = Display.format_time(data['due_at'])
      "Due at: #{formatted_time}"
    end

end
