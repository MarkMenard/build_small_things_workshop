class BooleanArgContainer

  attr_accessor :flag, :value

  def initialize (flag, value)
    @flag = flag
    @value = value
  end

  def validate
  end
end