# frozen_string_literal: true

require_relative './test_helper.rb'

# The test in this file acts as an integration test
class PerformSearchTest < Minitest::Test

  def test_everything_hangs_together
    string_io = StringIO.new
    string_io.puts ['tickets', 'subject', 'A Catastrophe in Micronesia']
    string_io.rewind
    $stdin = string_io
    expected_output = json_fixture('test/fixtures/json/perform_search_output.json')

    _result, stdout, _stderr = OStreamCatcher.catch do
      PerformSearch.new.process
    end

    assert_equal expected_output, stdout
  end

end
