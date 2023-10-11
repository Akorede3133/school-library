require_relative 'app_person'
require_relative 'app_book'
require_relative 'app_rental'
require 'json'

class App
  attr_accessor :input, :students, :persons, :books, :rentals

  def initialize
    @persons = []
    @books = []
    @rentals = []
    load_data
  end

  def create_person
    print 'Do you want to create a student (1) or teacher (2)? [input number]: '
    person_type = gets.chomp
    if person_type == '1'
      StudentApp.new.create_new_student(@persons)
    elsif person_type == '2'
      TeacherApp.new.create_new_teacher(@persons)
    end
  end

  def save_data
    save_books
    save_people
    save_rentals
  end

  def load_data
    load_books
    load_people
    load_rentals
  end

  private

  def save_books
    books_data = @books.map { |book| { 'title' => book.title, 'author' => book.author } }

    File.write('books.json', JSON.generate(books_data))
  end

  def load_books
    return unless File.exist?('books.json')

    books_data = JSON.parse(File.read('books.json'))
    @books = books_data.map { |data| Book.new(data['title'], data['author']) }
  end

  def save_people
    people_data = @persons.map do |person|
      data = {
        'type' => person.class.name, # Store the class name
        'age' => person.age,
        'name' => person.name
      }
      if person.is_a?(Student)
        data['parent_permission'] = person.parent_permission
      elsif person.is_a?(Teacher)
        data['specialization'] = person.specialization
      end
      data
    end

    File.write('people.json', JSON.generate(people_data))
  end

  def load_people
    return unless File.exist?('people.json')

    people_data = JSON.parse(File.read('people.json'))
    @persons = people_data.map do |data|
      if data['type'] == 'Student'
        Student.new(data['age'], nil, data['name'], parent_permission: data['parent_permission'])
      elsif data['type'] == 'Teacher'
        Teacher.new(data['age'], data['specialization'], data['name'])
      end
    end
  end

  def save_rentals
    rentals_data = @rentals.map do |rental|
      {
        'date' => rental.date,
        'book' => {
          'title' => rental.book.title,
          'author' => rental.book.author
        },
        'person' => {
          'id' => rental.person.id,
          'type' => rental.person.class.to_s # Store the type of person (Student or Teacher)
        }
      }
    end

    File.write('rentals.json', JSON.generate(rentals_data))
  end

  def load_rentals
    return unless File.exist?('rentals.json')

    rentals_data = JSON.parse(File.read('rentals.json'))
    @rentals = []

    rentals_data.each do |data|
      # Check if a rental with the same data already exists
      existing_rental = @rentals.find do |rental|
        rental.date == data['date'] && rental.book.title == data['book']['title'] && rental.book.author == data['book']['author']
      end

      # Only create a new rental if it doesn't already exist
      next if existing_rental

      book = @books.find { |b| b.title == data['book']['title'] && b.author == data['book']['author'] }
      person = @persons.find { |p| p.id == data['person']['id'] }
      rental = Rental.new(data['date'], book, person)
      @rentals << rental
    end
  end
end
