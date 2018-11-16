# frozen_string_literal: true

require_relative './test_helper.rb'

class TicketTest < Minitest::Test

  def setup
    ticket_data = json_fixture('test/fixtures/json/tickets_fixture.json').first
    ticket_data['submitter'] = json_fixture('test/fixtures/json/users_fixture.json').first
    ticket_data['assignee'] = json_fixture('test/fixtures/json/users_fixture.json').first
    ticket_data['organization'] = json_fixture('test/fixtures/json/organizations_fixture.json').first

    @ticket = Ticket.new(ticket_data)
  end

  def teardown
    @ticket = nil
  end

  def test_fields
    expected_fields = %w[_id url external_id type subject description priority status tags has_incidents via]

    fields = Ticket.fields

    assert_equal expected_fields, fields
  end

  def test_tickets_can_be_presented_in_a_readable_format
    formatted_ticket = @ticket.readable_format

    assert_equal expected_ticket_data, formatted_ticket
  end

  private

    def expected_ticket_data
      basic_data + associated_data + extra_data
    end

    def basic_data
      "Subject: A Catastrophe in Korea (North)\n"\
      "Id: 436bf9b0-1147-4c0a-8439-6f79833bff5b\n"\
      "Status: pending\n"\
      "Priority: high\n"\
      'Description: Nostrud ad sit velit cupidatat laboris ipsum nisi '\
      "amet laboris ex exercitation amet et proident. Ipsum fugiat aute dolore tempor nostrud velit ipsum.\n"\
    end

    def associated_data
      "Submitted by: Francisca Rasmussen\n"\
      "Assigned to: Francisca Rasmussen\n"\
      "Organization: Enthaze\n"\
    end

    def extra_data
      "External Id: 9210cdc9-4bee-485f-a078-35396cd74063\n"\
      "Url: http://initech.zendesk.com/api/v2/tickets/436bf9b0-1147-4c0a-8439-6f79833bff5b.json\n"\
      "Tags: Ohio, Pennsylvania, American Samoa, Northern Mariana Islands\n"\
      "Due at: Sunday, 31 Jul 2016  2:37 AM\n"\
      "Has Incidents: false\n"\
      "Via: web\n\n"
    end

end
