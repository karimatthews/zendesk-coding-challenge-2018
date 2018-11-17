# frozen_string_literal: true

require 'json'
require 'pry'

require_relative 'ticket.rb'
require_relative 'user.rb'
require_relative 'organization.rb'

class UserInput

  TICKETS = 'tickets'
  USERS = 'users'
  ORGANIZATIONS = 'organizations'

  def input_values
    @resource_type = user_input('resource_type')
    @data_field = user_input('data_field')
    search_term = user_input('search_term')

    {
      resource_type: @resource_type,
      data_field: @data_field,
      search_term: search_term
    }
  end

  def user_input(input_type)
    options = input_options(input_type)
    readable_options = options ? readable_options(options) : nil

    puts input_request_string(input_type, readable_options)

    receive_input(input_type, options)
  end

  def receive_input(input_type, options)
    input = gets.strip.downcase.tr(' ', '_')

    if input_type == 'search_term'
      return input.empty? ? nil : input
    end

    # We want to allow for the search term to be empty
    validate_input(input, input_type, options) unless input_type == 'search_term'
  end

  def validate_input(input, input_type, options)
    readable_options = readable_options(options)

    if options.include?(input.downcase)
      input.downcase
    else
      warn "\nInvalid Input. Enter #{readable_options}.\n\n"
      # If the input is invalid get the user to try again.
      receive_input(input_type, options)
    end
  end

  private

    def input_request_string(input_type, readable_options)
      case input_type
      when 'resource_type'
        "\nSearch for: \n\n#{readable_options}\n\n"
      when 'data_field'
        "\nSelect a field from: #{readable_options}.\n\n"
      when 'search_term'
        "\nGreat. Now enter your search term. "\
        "If you want #{@resource_type.chop.capitalize} #{@data_field.capitalize} "\
        "to be empty then just hit enter.\n\n"
      end
    end

    def input_options(input_type)
      if input_type == 'resource_type'
        [TICKETS, USERS, ORGANIZATIONS]
      elsif input_type == 'data_field'
        field_options
      end
    end

    def readable_options(options)
      options.map { |option| humanize(option) }.join(', ')
    end

    def humanize(string)
      if string == '_id'
        string
      else
        string.tr('_', ' ').capitalize
      end
    end

    def field_options
      @field_options ||= resource_class.fields
    end

    def resource_class
      Object.const_get(@resource_type.chop.capitalize)
    end

end
