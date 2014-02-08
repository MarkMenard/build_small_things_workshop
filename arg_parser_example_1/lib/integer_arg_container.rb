class IntegerArgContainer

  attr_accessor :flag, :value

  def initialize (flag, raw_value)
    @flag = flag
    @raw_value = raw_value
    @value = (Integer(@raw_value) rescue nil)
  end

  def validate
    raise ArgParseError.new("Missing integer for -#{@flag}") if @raw_value.length < 3
    raise ArgParseError.new("Integer expected for -#{@flag}, but was '#{@raw_value}'") unless value
  end

end