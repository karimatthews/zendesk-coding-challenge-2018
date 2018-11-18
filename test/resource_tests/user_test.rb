# frozen_string_literal: true

require_relative '../test_helper.rb'

class UserTest < Minitest::Test

  def setup
    user_data = json_fixture('test/fixtures/json/users_fixture.json').first
    user_data['organization'] = json_fixture('test/fixtures/json/organizations_fixture.json').first
    user_data['assigned_tickets'] = json_fixture('test/fixtures/json/tickets_fixture.json')
    user_data['submitted_tickets'] = json_fixture('test/fixtures/json/tickets_fixture.json')

    @user = User.new(user_data)
  end

  def teardown
    @user = nil
  end

  def test_fields
    expected_fields = %w[
      _id url external_id name alias active verified shared
      locale timezone email phone signature tags suspended role
    ]

    fields = User.fields

    assert_equal expected_fields, fields
  end

  def test_users_can_be_presented_in_a_readable_format
    formatted_user = @user.readable_format

    assert_equal expected_user_data, formatted_user
  end

  private

    def expected_user_data
      first_half_user_data + second_half_user_data
    end

    def first_half_user_data
      "Name: Francisca Rasmussen (Miss Coffey)\n"\
      "Signature: Don't Worry Be Happy!\n"\
      "Contact: coffeyrasmussen@flotonic.com | 8335-422-718\n"\
      "Organization: Enthaze\nRole: admin\n"\
      "Id: 1\n"\
      "Tags: Springville, Sutton, Hartsville/Hartley, Diaperville\n"\
      "Time Zone: Sri Lanka\n"\
      "Url: http://initech.zendesk.com/api/v2/users/1.json\n"\
      "External Id: 74341f74-9c79-49d5-9611-87ef9b6eb75f\n"\
      "Active: true\n"\
      "Verified: true\n"\
    end

    def second_half_user_data
      "Shared: false\n"\
      "Locale: en-AU\n"\
      "Suspended: true\n"\
      "Created At: Friday, 15 Apr 2016  5:19 AM\n"\
      "Last Login At: Sunday, 04 Aug 2013  1:03 AM\n"\
      "Assigned Tickets:\n"\
      "  - A Catastrophe in Korea (North) | Id: 436bf9b0-1147-4c0a-8439-6f79833bff5b\n"\
      "  - A Catastrophe in Micronesia | Id: 1a227508-9f39-427c-8f57-1b72f3fab87c\n"\
      "Submitted Tickets:\n"\
      "  - A Catastrophe in Korea (North) | Id: 436bf9b0-1147-4c0a-8439-6f79833bff5b\n"\
      "  - A Catastrophe in Micronesia | Id: 1a227508-9f39-427c-8f57-1b72f3fab87c\n\n"\
    end

end
