# frozen_string_literal: true

require_relative './test_helper.rb'

class OrganizationTest < Minitest::Test

  def setup
    organization_data = json_fixture('test/fixtures/json/organizations_fixture.json').first
    organization_data['users'] = json_fixture('test/fixtures/json/users_fixture.json')
    organization_data['tickets'] = json_fixture('test/fixtures/json/tickets_fixture.json')

    @organization = Organization.new(organization_data)
  end

  def teardown
    @organization = nil
  end

  def test_fields
    fields = organization.fields

    assert_equal %w[name details], fields
  end

  def test_organizations_can_be_presented_in_a_readable_format
    formatted_organization = @organization.readable_format

    assert_equal expected_organization_data, formatted_organization
  end

  private

    def expected_organization_data
      "Enthaze\n"\
      "MegaCorp\n"\
      "Users:\n"\
      "  - Francisca Rasmussen\n"\
      "  - Cross Barlow\n"\
      "Tickets:\n"\
      "  - A Catastrophe in Korea (North)\n"\
      "  - A Catastrophe in Micronesia\n\n"
    end

end
