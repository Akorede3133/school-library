require_relative 'nameable'

class Person < Nameable
  @@next_id = 1

  attr_accessor :name, :age
  attr_reader :id, :rentals

  def initialize(age, name = 'Unknown', parent_permission: true)
    super()
    # @id = rand(1..1000)
    @id = @@next_id
    @@next_id += 1
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rentals = []
  end

  def can_use_services?
    of_age? || @parent_permission
  end

  def add_rental(book, date)
    rental = Rental.new(date, book, self)
    @rentals.push(rental)
  end

  def correct_name
    @name
  end

  private

  def of_age?
    @age >= 18
  end
end
