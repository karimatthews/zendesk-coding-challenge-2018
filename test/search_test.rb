# frozen_string_literal: true

require_relative './test_helper.rb'

class SearchTest < Minitest::Test

  def setup
    @search = Search.new(
      tickets: json_fixture('test/fixtures/json/tickets_fixture.json'),
      users: json_fixture('test/fixtures/json/users_fixture.json'),
      organizations: json_fixture('test/fixtures/json/organizations_fixture.json'),
      resource: '',
      field: '',
      search_term: ''
    )
  end

  def teardown
    @search = nil
  end

  def test_tickets_can_be_found_by_type
    @search.resource = 'tickets'
    @search.field = 'type'
    @search.search_term = 'incident'

    results = @search.results

    assert_equal 2, results.size
  end

  def test_no_results_are_returned_when_search_term_does_not_match
    @search.resource = 'tickets'
    @search.field = 'type'
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
    @search.resource = 'tickets'
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
    @search.resource = 'tickets'
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

  def test_search_for_tickets_returns_associated_data
    @search.resource = 'tickets'
    @search.field = 'type'
    @search.search_term = 'incident'

    results = @search.results

    assert_equal 1, results.first.dig('submitter', '_id')
    assert_equal 1, results.first.dig('assignee', '_id')
    assert_equal 101, results.first.dig('organization', '_id')
  end

  def test_search_for_users_return_associated_data
    @search.resource = 'users'
    @search.field = 'role'
    @search.search_term = 'admin'

    results = @search.results

    assert_equal '436bf9b0-1147-4c0a-8439-6f79833bff5b', results.first['assigned_tickets'].first['_id']
    assert_equal 1, results.first['submitted_tickets'].size
    assert_equal 101, results.first.dig('organization', '_id')
  end

  def test_search_for_organizations_returns_user_data
    @search.resource = 'organizations'
    @search.field = 'tags'
    @search.search_term = 'fulton'

    results = @search.results

    assert_equal 1, results.first['users'].first['_id']
    assert_equal 2, results.first['users'].size
  end

  def test_search_for_organizations_returns_ticket_data
    @search.resource = 'organizations'
    @search.field = 'tags'
    @search.search_term = 'fulton'

    results = @search.results

    assert_equal '436bf9b0-1147-4c0a-8439-6f79833bff5b', results.first['tickets'].first['_id']
    assert_equal 2, results.first['tickets'].size
  end

end
