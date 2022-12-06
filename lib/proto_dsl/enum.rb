# frozen_string_literal: true

module ProtoDsl
  class Enum
    attr_reader :name, :values

    def initialize(name)
      @name = name
      @values = []
    end

    def value(name, tag)
      @values << [name, tag]
    end

    def to_proto
      output = "enum #{@name} {\n"
      @values.each do |value|
        output << "  #{value[0]} = #{value[1]};\n"
      end
      output << "}\n"
      output
    end
  end
end

# This is the ProtoDsl::Enum class, which defines a protobuf enum. A protobuf enum is a type that consists of a set of named constants, and is often used to define a set of possible values for a field in a protobuf message.

# The ProtoDsl::Enum class is typically used by the ProtoDsl::Dsl class to define protobuf enums.

# The ProtoDsl::Enum class has two instance attributes:

# -> name: a string representing the name of the enum
# -> values: an array of [name, tag] pairs representing the values in the enum, where name is the name of the value, and tag is its numeric tag

# The ProtoDsl::Enum class has two instance methods:

# -> value: defines a new value in the enum with the given name and tag
# -> to_proto: generates the protobuf code for the enum, and returns the generated code as a string.

# The to_proto method generates the protobuf code for the enum by concatenating the name of the enum, the individual values in the values array as protobuf code, and a closing } character. For example, given an enum named MyEnum with values MY_VALUE (tag 1) and MY_OTHER_VALUE (tag 2), the to_proto method would generate the following protobuf code:

# ```proto
# enum MyEnum {
#   MY_VALUE = 1;
#   MY_OTHER_VALUE = 2;
# }
# ```
