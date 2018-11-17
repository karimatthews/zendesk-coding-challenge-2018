# frozen_string_literal: true

require_relative './test_helper.rb'

class UserInputTest < Minitest::Test

  def setup
    @user_input = UserInput.new(Display.new)
  end

  def teardown
    @user_input = nil
    $stdin = STDIN
  end

  def test_user_can_specify_resource
    string_io = StringIO.new
    string_io.puts ' tickets '
    string_io.rewind
    $stdin = string_io
    expected_output = "\nSearch for: \n\nTickets, Users, Organizations\n\n"

    resource, stdout = OStreamCatcher.catch do
      @user_input.resource
    end

    assert_equal 'tickets', resource
    assert_equal expected_output, stdout
  end

  def test_user_can_specify_field
    string_io = StringIO.new
    string_io.puts 'Has Incidents'
    string_io.rewind
    $stdin = string_io
    expected_output = "\nSelect a field from: _id, Url, External id, Type, Subject, Description, "\
    "Priority, Status, Tags, Has incidents, Via.\n\n"

    field, stdout = OStreamCatcher.catch do
      @user_input.field('tickets')
    end

    assert_equal 'has_incidents', field
    assert_equal expected_output, stdout
  end

  def test_user_can_specify_search_term
    string_io = StringIO.new
    string_io.puts 'greyhounds are long'
    string_io.rewind
    $stdin = string_io
    expected_output = "\nGreat. Now enter your search term. "\
    "If you want Organization Name to be empty then just hit enter.\n\n"

    search_term, stdout = OStreamCatcher.catch do
      @user_input.search_term('organization', 'name')
    end

    assert_equal 'greyhounds are long', search_term
    assert_equal expected_output, stdout
  end

end
