require_relative './person'

class Teacher < Person
  def initialize(id, age, specialization, name, parent_permission)
    super(id, age, name, parent_permission)
    @specialization = specialization
  end
end
