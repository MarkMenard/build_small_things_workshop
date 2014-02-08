class StringArgContainer

  attr_accessor :flag, :value

  def initialize (flag, value)
    @flag = flag
    @value = value
  end

  def validate
    raise ArgParseError.new("Missing string for -#{@flag}") if @value.length < 3
  end

end