# frozen_string_literal: true

require_relative './test_helper.rb'

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
    fields = User.fields

    assert_equal %w[name alias active verified email phone signature suspended role tags], fields
  end

  def test_users_can_be_presented_in_a_readable_format
    formatted_user = @user.readable_format

    assert_equal expected_user_data, formatted_user
  end

  private

    def expected_user_data
      "Francisca Rasmussen (Miss Coffey)\n"\
      "coffeyrasmussen@flotonic.com\n"\
      "8335-422-718\n"\
      "Organization: Enthaze\n"\
      "Role: admin\n"\
      "Assigned Tickets:\n"\
      "  - A Catastrophe in Korea (North) | Status: pending\n"\
      "  - A Catastrophe in Micronesia | Status: hold\n"\
      "Submitted Tickets:\n"\
      "  - A Catastrophe in Korea (North) | Status: pending\n"\
      "  - A Catastrophe in Micronesia | Status: hold\n\n"
    end

end
