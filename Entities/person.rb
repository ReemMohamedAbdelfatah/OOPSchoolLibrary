require_relative '../Decorate/nameable'
require_relative '../Decorate/capitalize_decorator'
require_relative '../Decorate/trimmer_decorator'
require_relative '../Decorate/base_decorator'
require_relative '../Associations/rental'

class Person < Nameable
  attr_reader :id
  attr_accessor :name, :age, :rentals

  def initialize(age, name = 'Unknown', parent_permission: true)
    super()
    @id = Random.rand(1..1000)
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rentals = []
  end

  def can_use_services?
    of_age? || @parent_permission
  end

  def correct_name
    @name
  end

  private

  def of_age?
    @age.to_i >= 18
  end

  def add_rental(rental)
    @rentals.push(rental)
    rental.person = self
  end
end

person = Person.new('maximilianus')
puts person.correct_name
capitalized_person = CapitalizeDecorator.new(person)
puts capitalized_person.correct_name
capitalized_trimmed_person = TrimmerDecorator.new(capitalized_person)
puts capitalized_trimmed_person.correct_name
base = BaseDecorator.new(capitalized_trimmed_person)
puts base.correct_name
