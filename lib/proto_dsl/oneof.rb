# frozen_string_literal: true

module ProtoDsl
  class Oneof
    attr_reader :name, :fields

    def initialize(name)
      @name = name
      @fields = []
    end

    def field(type, name, tag)
      @fields << [type, name, tag]
    end

    def to_proto
      output = "  oneof #{@name} {\n"
      @fields.each do |field|
        output << "    #{field[0]} #{field[1]} = #{field[2]};\n"
      end
      output << "  }\n"
      output
    end
  end
end

# This is the ProtoDsl::Oneof class, which defines a protobuf oneof group. A protobuf oneof group is a set of fields within a message, where only one field can be set at a time.

# The ProtoDsl::Oneof class has two instance attributes:

# -> name: a string representing the name of the oneof group
# -> fields: an array of [type, name, tag] tuples representing the fields in the oneof group, where type is the type of the field, name is the name of the field, and tag is its numeric tag

# The ProtoDsl::Oneof class has two instance methods:

# -> field: defines a new field in the oneof group with the given type, name, and tag
# -> to_proto: generates the protobuf code for the oneof group, and returns the generated code as a string.

# The to_proto method generates the protobuf code for the oneof group by concatenating the name of the oneof group, the individual fields in the fields array as protobuf code, and a closing }
# character. For example, given a oneof group named MyOneof with fields my_field (type string, tag 1) and my_other_field (type int32, tag 2), the to_proto method would generate the following protobuf code:

# ```proto
# oneof MyOneof {
#   string my_field = 1;
#   int32 my_other_field = 2;
# }
# ```

# The ProtoDsl::Oneof class is typically used by the ProtoDsl::Message class to define oneof groups within messages.
# The ProtoDsl::Message class uses the oneof method to define a new ProtoDsl::Oneof instance, and then uses the field method in the ProtoDsl::Oneof class to define the fields within the oneof group.
# The ProtoDsl::Message class then uses the to_proto method in the ProtoDsl::Oneof class to generate the protobuf code for the oneof group and include it in the generated code for the message.
