require_relative 'app'
require_relative 'app_print'
require_relative 'app_book'
require_relative 'app_rental'
require_relative 'book'
require 'json'

class Main
  def initialize
    @app = App.new
  end

  def give_instruction
    puts "\nPlease choose an option by entering a number"
    puts '1 - list all books'
    puts '2 - List all people'
    puts '3 - Create a person'
    puts '4 - Create a book'
    puts '5 - Create a rental'
    puts '6 - List all the rentals for a given person id'
    puts '7 - Exit'
  end

  def choice(user_choice)
    print = Print.new
    book = BookApp.new
    rental = RentalApp.new
    options = {
      '1' => -> { print.print_books(@app.books) },
      '2' => -> { print.print_person(@app.persons) },
      '3' => -> { @app.create_person },
      '4' => -> { book.create_new_book(@app.books) },
      '5' => -> { rental.create_new_rental(@app.persons, @app.books, @app.rentals) },
      '6' => -> { print.print_rental_with_id(@app.persons) },
      '7' => -> { exit_app }
    }

    if options.key?(user_choice)
      options[user_choice].call
    else
      puts 'You seem to have entered an invalid option'
      puts 'Please enter a valid option'
    end
  end

  def exit_app
    @app.save_data
    puts "Thank you for using this app!\n\n"
    exit
  end

  def run_app
    puts 'Welcome to School Library App!'
    loop do
      give_instruction
      choice(gets.chomp)
    end
  end
end

Main.new.run_app
