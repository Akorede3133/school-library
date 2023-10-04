require_relative 'student'
require_relative 'classroom'
require_relative 'teacher'
require_relative 'book'

class App
  attr_accessor :input, :person_type, :books

  def initialize
    @input = ''
    @person_type = ''
    @persons = []
    @books = []
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
      when "3"
        create_person
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
end
