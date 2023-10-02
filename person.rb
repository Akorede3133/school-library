class Person
  attr_accessor :name, :age
  attr_reader :id

  def initialize(id, age, name = "Unknown", parent_permission = true)
    @id = id
    @name = name
    @age = age
    @parent_permission = parent_permission
  end
end
