# frozen_string_literal: true

require 'minitest/autorun'
require 'stringio'

require_relative './test_helper.rb'

class TestSearch < Minitest::Test

  def setup
    user_input_hash = { resource_type: 'tickets', data_field: 'type', search_term: 'incident' }

    @search = Search.new(
      tickets_path: 'test/fixtures/json/tickets_fixture.json',
      users_path: 'test/fixtures/json/users_fixture.json',
      organizations_path: 'test/fixtures/json/organizations_fixture.json',
      user_input: user_input_hash
    )
  end

  def teardown
    @search = nil
  end

  def test_tickets_can_be_found_by_type
    results = @search.results

    assert_equal 2, results.size
  end

  def test_no_results_are_returned_when_search_term_does_not_match
    @search.user_input[:search_term] = 'nonsense'

    results = @search.results

    assert_equal 0, results.size
  end

  def test_can_search_for_empty_field
    skip
  end

  def test_search_for_tickets_returns_user_data
    skip
  end

  def test_search_for_tickets_returns_org_data
    skip
  end

end
