# frozen_string_literal: true

require_relative '../resource.rb'
require_relative '../ticket.rb'
require_relative '../user.rb'
require_relative '../organization.rb'

class DisplayResults

  def display(raw_results, resource_class)
    if raw_results.empty?
      puts 'Sorry, your search has return no results.'
    else
      puts formatted_results(raw_results, resource_class)
    end
  end

  private

    def formatted_results(raw_results, resource_class)
      raw_results.map do |raw_result|
        resource_class.new(raw_result).readable_format
      end
    end

end
