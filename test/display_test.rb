# frozen_string_literal: true

require 'o_stream_catcher'

require_relative './test_helper.rb'

class DisplayTest < Minitest::Test

  def setup
    @display = Display.new
  end

  def teardown
    @display = nil
  end

  def test_a_nice_error_message_is_displayed_when_no_results_are_found
    assert_output("Sorry, your search has returned no results.\n", '') do
      @display.results([], 'class')
    end
  end

  def test_search_message_with_search_term
    assert_output("\nSearching for Tickets with Subject \"dogs are good\"...\n\n", '') do
      @display.search_message('tickets', 'subject', 'dogs are good')
    end
  end

  def test_search_message_without_search_term
    assert_output("\nSearching for Tickets with no Subject...\n\n", '') do
      @display.search_message('tickets', 'subject', nil)
    end
  end

end
