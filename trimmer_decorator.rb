require_relative 'decorator'

class TrimmerDecorator < Decorator
  def correct_name
    @nameable.correct_name.lenghth ? 10 ? "#{@nameable.correct_name}[0, 10]..." : @nameable.correct_name
  end
end