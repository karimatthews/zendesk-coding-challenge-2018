# frozen_string_literal: true

require_relative './test_helper.rb'

class UserInputTest < Minitest::Test

  def setup
    @user_input = UserInput.new
  end

  def teardown
    @user_input = nil
  end

  def test_user_input_can_be_received
    string_io = StringIO.new
    string_io.puts %w[tickets type dogs]
    string_io.rewind
    $stdin = string_io

    input = @user_input.input_values
    $stdin = STDIN

    assert_equal expected_input, input
  end

  def test_user_input_is_normalised_properly
    string_io = StringIO.new
    string_io.puts ['Tickets', 'has incidents', 'dogs']

    string_io.rewind
    $stdin = string_io

    input = @user_input.input_values
    $stdin = STDIN

    assert_equal expected_normalised_input, input
  end

  private

    def expected_input
      {
        resource_type: 'tickets',
        data_field: 'type',
        search_term: 'dogs'
      }
    end

    def expected_normalised_input
      {
        resource_type: 'tickets',
        data_field: 'has_incidents',
        search_term: 'dogs'
      }
    end

end
