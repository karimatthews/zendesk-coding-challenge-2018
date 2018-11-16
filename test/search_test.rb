# frozen_string_literal: true

require_relative './test_helper.rb'

class SearchTests < Minitest::Test

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
    @search.search_term = 'nonsense'

    results = @search.results

    assert_equal 0, results.size
  end

  def test_can_handle_empty_field
    @search.resource = 'users'
    @search.field = 'alias'
    @search.search_term = nil

    results = @search.results

    assert_equal 'Cross Barlow', results.first['name']
  end

  def test_tickets_can_be_searched_by_tags
    @search.field = 'tags'
    @search.search_term = 'ohio'

    results = @search.results

    assert_equal 'A Catastrophe in Korea (North)', results.first['subject']
    assert_equal 1, results.size
  end

  def test_orgs_can_be_searched_by_domains
    @search.resource = 'organizations'
    @search.field = 'domain_names'
    @search.search_term = 'zentix.com'

    results = @search.results

    assert_equal 'Enthaze', results.first['name']
    assert_equal 1, results.size
  end

  def test_search_is_case_insensitive
    @search.field = 'subject'
    @search.search_term = 'a catastrophe in korea (north)'

    results = @search.results

    assert_equal 1, results.size
  end

  def test_can_serach_on_binary_field
    @search.resource = 'tickets'
    @search.field = 'has_incidents'
    @search.search_term = 'false'

    results = @search.results

    assert_equal 2, results.size
  end

  def test_search_for_tickets_returns_user_data
    skip
  end

  def test_search_for_tickets_returns_org_data
    skip
  end

end
