require 'minitest/autorun'

require_relative './test_helper.rb'
require_relative '../lib/search.rb'

class TestSearch < Minitest::Test

  def setup
  end

  def test_thing
    result = Search.new

    assert result != nil
  end

end
