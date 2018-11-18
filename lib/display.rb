# frozen_string_literal: true

require 'date'

class Display

  def initialize
  end

  def welcome_message
    puts "Welcome to this CLI Search tool. Please wait one moment while your data is read.\n"\
    "If you would like to use different data you can change the paths in 'lib/perform_search.rb'\n\n"
  end

  def data_has_been_read
    puts "\nYour data has been successfully read and parsed.\n"
  end

  def results(raw_results, resource_class)
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

  def self.data_fetching_message(file_path)
    puts "Reading data from '#{file_path}'..."
  end

  def formatted_results(raw_results, resource_type)
    resource_class = Object.const_get(resource_type.chop.capitalize)

    raw_results.map do |raw_result|
      resource_class.new(raw_result).readable_format
    end
  end

  def search_message(resource, field, search_term)
    if search_term
      puts "\nSearching for #{humanize(resource)} with #{humanize(field)} \"#{search_term}\"...\n\n"
    else
      puts "\nSearching for #{humanize(resource)} with no #{humanize(field)}...\n\n"
    end
  end

  def input_request(input_type, options, resource, field)
    case input_type
    when 'resource'
      puts "\nSearch for: \n\n#{readable_options(options)}\n\n"
    when 'field'
      puts "\nSelect a field from: #{readable_options(options)}.\n\n"
    when 'search_term'
      puts "\nGreat. Now enter your search term. "\
      "If you want #{humanize(resource)} #{humanize(field)} "\
      "to be empty then just hit enter.\n\n"
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

  def invalid_input_message(options)
    warn "\nInvalid Input. Enter #{readable_options(options)}.\n\n"
  end

end
