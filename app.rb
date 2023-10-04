require_relative 'student'
require_relative 'classroom'
require_relative 'teacher'
require_relative 'book'
require_relative 'rental'

class App
  attr_accessor :input, :person_type, :books, :rentals

  def initialize
    @input = ''
    @person_type = ''
    @persons = []
    @books = []
    @rentals = []
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
  end

  def execute
    case input
    when "1"
      print_books
    when "2"
      print_person
    when "3"
      create_person
    when "4"
      create_book
    when "5"
      create_rental
    when "6"
      print_rental_with_id
    else
      start
    end
  end

  def create_person
    print "Do you want to create a student (1) or teacher (2)? [input number]: "
    @person_type = gets.chomp
    if person_type == '1'
      create_student
    elsif person_type == '2'
      puts create_teacher
    end
  end

  def create_student
    print "Age: "
    age = gets.chomp
    print "Name: "
    name = gets.chomp
    print "Has parent permission? [Y/N]: "
    permission = gets.chomp
    permission = permission.downcase == 'y' ? true : false
    classroom = Classroom.new('ss2')
    new_student = Student.new(age, classroom, name, parent_permission: permission)
    classroom.add_student(new_student)
    @persons << new_student
    puts "Person created successfully"
    start
  end

  def create_teacher
    print "Age: "
    age = gets.chomp
    print "Name: "
    name = gets.chomp
    print "Specialization: "
    specialization = gets.chomp
    new_teacher = Teacher.new(age, specialization, name)
    @persons << new_teacher
    puts "Person created successfully"
    start
  end

  def create_book
    print "Title: "
    title = gets.chomp
    print "Author: "
    author = gets.chomp
    new_book = Book.new(title, author)
    @books << new_book
    puts "Book created successfully"
    start
  end

  def create_rental
    if persons.length > 0 && books.length > 0
      puts "select a book from the following list by number"
      print_books_with_index
      book_index = gets.chomp.to_i
      puts
      puts "select a person from the following list by number (not id)"
      print_person_with_index
      person_index = gets.chomp.to_i
      puts
      book_instance = books[book_index]
      person_instance = persons[person_index]
      print "Date: "
      date = gets.chomp
      new_rental = Rental.new(date, book_instance, person_instance)
      @rentals << new_rental
      puts "Rental created successfully"
      start
    else
      puts "It appears there is no book or person available"
      start
    end
  end

  def print_person
    @persons.each do |person|
      puts "[#{person.class}] Name: #{person.name.capitalize}, ID: #{person.id}, Age: #{person.age}"
    end
    start
  end

  def print_books
    @books.each do |book|
      puts "Title: \"#{book.title.capitalize}\", Author: #{book.author.capitalize}"
    end
    start
  end

  def print_person_with_index
    @persons.each_with_index do |person, index|
      puts "#{index}) [#{person.class}] Name: #{person.name.capitalize}, ID: #{person.id}, Age: #{person.age}"
    end
  end

  def print_books_with_index
    @books.each_with_index do |book, index|
      puts "#{index}) Title: \"#{book.title.capitalize}\", Author: #{book.author.capitalize}"
    end
  end

  def print_rental_with_id
    print "ID of person: "
    id = gets.chomp.to_i
    person = persons.select { |person| person.id == id}[0]
    puts "Rentals:"
    if person
      person.rentals.each do |rental|
        puts "Date: #{rental.date}, Book \"#{rental.book.title.capitalize}\" by #{rental.book.author.capitalize}"
      end
    else
      start
    end
    start
  end
end
