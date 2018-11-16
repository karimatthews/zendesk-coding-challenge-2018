# frozen_string_literal: true

require_relative 'ticket.rb'
require_relative 'user.rb'
require_relative 'organization.rb'

class DisplayResults

  def display(raw_results, resource_class)
    if raw_results.empty?
      puts 'Sorry, your search has returned no results.'
    else
      puts formatted_results(raw_results, resource_class)
    end
  end

  def self.format_time(timestamp)
    time = DateTime.parse(timestamp)
    # Returns e.g. Sunday, 31 Jul 2016  2:37 AM
    time.strftime('%A, %d %b %Y %l:%M %p')
  end

  private

    def formatted_results(raw_results, resource_class)
      raw_results.map do |raw_result|
        resource_class.new(raw_result).readable_format
      end
    end

end
