require_relative 'app_person'
require_relative 'app_book'
require_relative 'app_rental'
class App
  attr_accessor :input, :students, :persons, :books, :rentals

  def initialize
    @persons = []
    @books = []
    @rentals = []
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
end
