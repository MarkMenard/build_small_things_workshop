class StringArrayArgContainer

  attr_accessor :flag, :value

  def initialize (flag, raw_value)
    @flag = flag
    @raw_value = raw_value
    @value = raw_value.split(",") if raw_value
  end

  def validate
    raise ArgParseError.new("Missing string array for -#{@flag}") if value
  end
end