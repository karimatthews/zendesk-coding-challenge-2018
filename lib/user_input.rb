# frozen_string_literal: true

require 'json'
require 'pry'

require_relative 'resources/ticket.rb'
require_relative 'resources/user.rb'
require_relative 'resources/organization.rb'

class UserInput

  attr_accessor :display

  def initialize(display)
    @display = display
  end

  def resource
    options = %w[tickets users organizations]

    display.input_request('resource', options, nil, nil)
    receive_input('resource', options)
  end

  def field(resource)
    options = resource_class(resource).fields
    display.input_request('field', options, resource, nil)
    receive_input('field', options)
  end

  def search_term(resource, field)
    display.input_request('search_term', nil, resource, field)
    receive_input('search_term', nil)
  end

  private

    def receive_input(input_type, options)
      input = gets.strip.downcase

      if input_type == 'search_term'
        return input.empty? ? nil : input
      end

      input = input.tr(' ', '_') if input_type == 'field'

      # We want to allow for the search term to be empty
      validate_input(input, input_type, options) unless input_type == 'search_term'
    end

    def validate_input(input, input_type, options)
      if options.include?(input.downcase)
        input.downcase
      else
        display.invalid_input_message(options)

        receive_input(input_type, options)
      end
    end

    def resource_class(resource)
      Object.const_get(resource.chop.capitalize)
    end

end
