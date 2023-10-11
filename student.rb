require_relative 'person'

class Student < Person
  attr_accessor :classroom
  attr_reader :parent_permission

  def initialize(age, classroom, name = 'Uknown', parent_permission: true)
    super(age, name, parent_permission: parent_permission)
    @classroom = classroom
    return unless classroom

    classroom.add_student(self)
  end

  def play_hook
    '¯\(ツ)/¯'
  end
end
