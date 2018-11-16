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
      "A Catastrophe in Korea (North)\n"\
      "Submitted by: Francisca Rasmussen\n"\
      "Assigned to: Francisca Rasmussen\n"\
      "Organization: Enthaze\n\n"
    end

end
