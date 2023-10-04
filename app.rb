class App
  attr_accessor :input

  def initialize
    @input = ''
  end

  def print_welcome_message
    puts "Welcome to School Library App!"
  end

  def give_instruction
    puts "\nPlease choose an option by entering a number\n1 - list all books\n2 - List all people\n3 - Create a person\n4 - Create a book\n5 - Create a rental\n6 - List all the rentals for a given person id\n7 - Exit"
  end

  def get_input
    @input = gets.chomp
  end

  def start
    give_instruction
    get_input
    execute
  end
end
