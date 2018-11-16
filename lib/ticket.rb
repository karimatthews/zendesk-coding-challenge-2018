# frozen_string_literal: true

require 'date'

require_relative 'display_results.rb'

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
    (basic_ticket_data + associated_ticket_data + extra_ticket_data).compact
  end

  private

    def basic_ticket_data
      [
        "Subject: #{data['subject']}",
        "Id: #{data['_id']}",
        "Status: #{data['status']}",
        "Priority: #{data['priority']}",
        "Description: #{data['description']}"
      ]
    end

    def associated_ticket_data
      [
        submitter ? "Submitted by: #{submitter['name']}" : nil,
        assignee ? "Assigned to: #{assignee['name']}" : nil,
        organization ? "Organization: #{organization['name']}" : nil
      ]
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
      formatted_time = DisplayResults.format_time(data['due_at'])

      "Due at: #{formatted_time}"
    end

end
