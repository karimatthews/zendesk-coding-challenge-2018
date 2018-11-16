# frozen_string_literal: true

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
    # TODO: Add more fields
    [
      data['subject'],
      submitter ? "Submitted by: #{submitter['name']}" : nil,
      assignee ? "Assigned to: #{assignee['name']}" : nil,
      organization ? "Organization: #{organization['name']}" : nil
    ].compact

    # Priority: High
    # Status:
    # Description: akjdsfh akdjsfh sdh
    # Due at:
    # Organization:"
  end

end
