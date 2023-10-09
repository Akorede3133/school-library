require_relative 'rental'
require_relative 'app_print'

class RentalApp
  def create_new_rental(persons, books, rentals)
    list =  Print.new
    if persons.length.positive? && books.length.positive?
      puts 'select a book from the following list by number'
      list.print_books_with_index(books)
      book_index = gets.chomp.to_i
      puts
      puts 'select a person from the following list by number (not id)'
      list.print_person_with_index(persons)
      person_index = gets.chomp.to_i
      puts
      book_instance = books[book_index]
      person_instance = persons[person_index]
      print 'Date: '
      date = gets.chomp
      new_rental = Rental.new(date, book_instance, person_instance)
      rentals << new_rental
      puts "Rental was created successfully"
    else
      puts "Make sure you have records for books and people"
    end
  end
end