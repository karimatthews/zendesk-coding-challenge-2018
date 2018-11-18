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
    expected_fields = %w[_id url external_id name domain_names details shared_tickets tags]

    fields = Organization.fields

    assert_equal expected_fields, fields
  end

  def test_organizations_can_be_presented_in_a_readable_format
    formatted_organization = @organization.readable_format

    assert_equal expected_organization_data, formatted_organization
  end

  private

    def expected_organization_data
      basic_data + extra_data
    end

    def basic_data
      "Name: Enthaze\n"\
      "Id: 101\n"\
      "Details: MegaCorp\n"\
      "Created at: Saturday, 21 May 2016 11:10 AM\n"\
      "Domain Names: kage.com, ecratic.com, endipin.com, zentix.com\n"\
      "Shared Tickets: false\n"\
    end

    def extra_data
      "Tags: Fulton, West, Rodriguez, Farley\n"\
      "Users:\n"\
      "  - Francisca Rasmussen | Id: 1\n"\
      "  - Cross Barlow | Id: 2\n"\
      "Tickets:\n"\
      "  - A Catastrophe in Korea (North) | Id: 436bf9b0-1147-4c0a-8439-6f79833bff5b\n"\
      "  - A Catastrophe in Micronesia | Id: 1a227508-9f39-427c-8f57-1b72f3fab87c\n\n"\
    end

end
