# frozen_string_literal: true

require 'o_stream_catcher'

require_relative './test_helper.rb'

class FetchDataTest < Minitest::Test

  def setup
    file_path = 'test/fixtures/json/basic_json_file.json'
    @fetch_data = FetchData.new(file_path)
  end

  def teardown
    @file_path = nil
  end

  def test_json_file_can_be_properly_read_and_parsed
    data = @fetch_data.read_and_parse

    assert_equal Hash, data.class
  end

  def test_file_missing_is_handled
    @fetch_data.file_path = 'path_to_nothing'

    expected_error_message = "Cannot find file at 'path_to_nothing.''"

    error = assert_raises SystemExit do
      @fetch_data.read_and_parse
    end

    assert_equal expected_error_message, error.message
  end

  def test_badly_formatted_json_is_handled_nicely
    @fetch_data.file_path = 'test/fixtures/json/non_json_file'

    expected_error_message = "The data in 'test/fixtures/json/non_json_file' "\
    'contains invalid JSON. Ensure the data is formatted correctly before trying again.'

    error = assert_raises SystemExit do
      @fetch_data.read_and_parse
    end

    assert_equal expected_error_message, error.message
  end

end
