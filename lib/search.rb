class Search

  def initialize
    input_search_term
  end

  def input_search_term
    puts "Welcome to Zendesk Search. What do you want to look for?"
    input = gets.chomp
    puts "Searching for #{input}."
  end

end
