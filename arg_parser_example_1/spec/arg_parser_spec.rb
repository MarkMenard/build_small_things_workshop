require 'spec_helper'

describe ArgParser do

  describe "parsing errors" do
    it "raises an error when a non-defined flag is present" do
      expect { ArgParser.new("c", [ "-v" ])}.to raise_error ArgParseError, "Unexpected option -v"
    end

    it "raises a parse error when a string argument is missing a value" do
      expect { ArgParser.new("es", [ "-e" ])}.to raise_error ArgParseError, "Missing string for -e"
    end

    it "raises a parse error when an integer argument is missing a value" do
      expect { ArgParser.new("e#", [ "-e" ])}.to raise_error ArgParseError, "Missing integer for -e"
    end

    it "raises a parse error when an integer argument is not an integer" do
      expect { ArgParser.new("e#", [ "-efoo" ])}.to raise_error ArgParseError, "Integer expected for -e"
    end
  end

  describe "boolean flags" do
    it "can tell if a command line flag is set" do
      parser = ArgParser.new("c,v", [ "-c" ])
      expect(parser.value("c")).to be_true
      expect(parser.value("v")).to be_false
    end
  end

  describe "string flags" do
    it "can return the string value of an argument" do
      parser = ArgParser.new("es", [ "-efoo" ])
      expect(parser.value("e")).to eq("foo")
    end

    it "returns nil for unset string options" do
      parser = ArgParser.new("es", [ ])
      expect(parser.value("e")).to be_nil
    end
  end

  describe "integer flags" do
    it "can return the integer value for an argument" do
      parser = ArgParser.new("c#", [ "-c123" ])
      expect(parser.value("c")).to eq(123)
    end

    it "returns nil for unset integer options" do
      parser = ArgParser.new("c#", [ ])
      expect(parser.value("c")).to be_nil
    end

  end

  describe "getting undefined values" do
    it "returns nil for undefined arguments" do
      parser = ArgParser.new("c#", [ "-c123" ])
      expect(parser.value("e")).to be_nil
    end
  end

end