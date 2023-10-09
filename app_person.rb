require_relative 'student'
require_relative 'classroom'
require_relative 'teacher'

class StudentApp
  def create_new_student(persons)
    print 'Age: '
    age = gets.chomp
    print 'Name: '
    name = gets.chomp
    print 'Has parent permission? [Y/N]: '
    permission = gets.chomp
    permission = permission.downcase == 'y'
    classroom = Classroom.new('ss2')
    new_student = Student.new(age, classroom, name, parent_permission: permission)
    classroom.add_student(new_student)
    persons << new_student
    puts 'Person created successfully'
  end
end

class TeacherApp
  def create_new_teacher(persons)
    print 'Age: '
    age = gets.chomp
    print 'Name: '
    name = gets.chomp
    print 'Specialization: '
    specialization = gets.chomp
    new_teacher = Teacher.new(age, specialization, name)
    persons << new_teacher
    puts 'Person created successfully'
  end
end