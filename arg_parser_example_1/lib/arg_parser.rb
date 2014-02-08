require 'string_arg_container'
require 'integer_arg_container'
require 'boolean_arg_container'

class ArgParser
  attr_reader :format_string, :args

  def initialize (format_string, args)
    @format_string = format_string
    @args = args
    @arg_definitions = @format_string.split(/,/)
    @expected_args = @arg_definitions.collect { |arg_def| arg_def[0] }
    @argument_containers = []

    build_argument_containers
  end

  def validate
    check_for_invalid_options
    validate_containers
  end

  def value (arg_flag)
    container = @argument_containers.find { |container| container.flag == arg_flag }
    container ? container.value : nil
  end

  private

  def validate_containers
    @argument_containers.each(&:validate)
  end

  def check_for_invalid_options
    @args.collect { |arg| arg[1] }.each do |arg_character|
      raise ArgParseError.new("Unexpected option -#{arg_character}") if !@expected_args.include?(arg_character)
    end
  end

  def build_argument_containers
    @arg_definitions.each do |arg_definition|
      arg_flag = arg_definition[0]
      value_of_argument = find_value_for_arg_definition(arg_definition)
      arg_type = arg_definition[1]
      @argument_containers << case arg_type
      when nil
        BooleanArgContainer.new(arg_flag, value_of_argument)
      when 's'
        StringArgContainer.new(arg_flag, value_of_argument)
      when '#'
        IntegerArgContainer.new(arg_flag, value_of_argument)
      else
        raise ArgParseError.new("Invalid argument type")
      end
    end
  end

  def find_value_for_arg_definition (arg_definition)
    arg_flag = arg_definition[0]
    arg_value = @args.find { |arg| arg[1] == arg_flag }
    if boolean_definition?(arg_definition)
      true if arg_value
    else
      arg_value ? arg_value[2..-1] : nil
    end
  end

  def boolean_definition? (arg_definition)
    arg_definition.length == 1
  end
end

class ArgParseError < StandardError
end