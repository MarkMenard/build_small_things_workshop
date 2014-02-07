class ArgParser
  attr_reader :format_string, :args

  def initialize (format_string, args)
    @format_string = format_string
    @args = args

    @arg_definitions = @format_string.split(/,/)
    @expected_args = @arg_definitions.collect { |arg_def| arg_def[0] }

    #Check to see if an arg is present that has no definition

    @args.collect { |arg| arg[1] }.each do |arg_character|
      raise ArgParseError.new("Unexpected option -#{arg_character}") if !@expected_args.include?(arg_character)
    end

    # Check that string arguments have a value
    @arg_definitions.select { |definition| definition[1] == 's' }.each do |string_arg|
      arg_flag = string_arg[0]
      @args.select { |arg| arg[1] == arg_flag }.each do |arg|
        raise ArgParseError.new("Missing string for -#{arg_flag}") if arg.length < 3
      end
    end

    # Check that integer arguments have a value
    @arg_definitions.select { |definition| definition[1] == '#' }.each do |string_arg|
      arg_flag = string_arg[0]
      @args.select { |arg| arg[1] == arg_flag }.each do |arg|
        raise ArgParseError.new("Missing integer for -#{arg_flag}") if arg.length < 3
      end
    end

    # Check that integer arguments are an integer
    @arg_definitions.select { |definition| definition[1] == '#' }.each do |string_arg|
      arg_flag = string_arg[0]
      @args.select { |arg| arg[1] == arg_flag }.each do |arg|
        int_string = arg[2..-1]
        raise ArgParseError.new("Integer expected for -#{arg_flag}") unless (Integer(int_string) rescue false)
      end
    end


  end

  def value (arg)
    # Fing arg defition, type and raw value for arg
    arg_definition = @arg_definitions.find { |arg_def| arg_def[0] == arg }

    return nil unless arg_definition

    arg_type = arg_definition[1]
    raw_arg_value = @args.find { |argument| argument[1] == arg }
    
    return nil unless raw_arg_value

    case arg_type
    when nil # This is a boolean type
      true
    when 's'
      raw_arg_value[2..-1]
    when '#'
      Integer(raw_arg_value[2..-1])
    else
      raise "We should never get here"
    end
  end

  def set? (arg)
    args.include?("-#{arg}")
  end
end

class ArgParseError < StandardError
end