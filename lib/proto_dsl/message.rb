# frozen_string_literal: true

require_relative "./enum"
require_relative "./oneof"

module ProtoDsl
  # Message class
  class Message
    attr_reader :name, :fields, :messages, :enums, :oneofs

    def initialize(name)
      @name = name
      @fields = []
      @messages = []
      @enums = []
      @oneofs = []
    end

    def field(type, name, tag)
      @fields << [type, name, tag]
    end

    def message(name, &block)
      message = Message.new(name)
      message.instance_eval(&block)
      @messages << message
    end

    def enum(name, &block)
      enum = Enum.new(name)
      enum.instance_eval(&block)
      @enums << enum
    end

    def oneof(name, &block)
      oneof = Oneof.new(name)
      oneof.instance_eval(&block)
      @oneofs << oneof
    end

    def to_proto
      output = "message #{@name} {\n"
      @fields.each do |field|
        output << "  #{field[0]} #{field[1]} = #{field[2]};\n"
      end
      @messages.each do |message|
        output << message.to_proto
      end
      @enums.each do |enum|
        output << enum.to_proto
      end
      @oneofs.each do |oneof|
        output << oneof.to_proto
      end
      output << "}\n"
      output
    end
  end
end

# This is the ProtoDsl::Message class, which defines a protobuf message. A protobuf message is a type that consists of a set of named fields, and is used to define the structure of data in a protobuf service.

# The ProtoDsl::Message class has five instance attributes:

# -> name: a string representing the name of the message
# -> fields: an array of [type, name, tag] tuples representing the fields in the message, where type is the type of the field, name is the name of the field, and tag is its numeric tag
# -> messages: an array of nested ProtoDsl::Message instances
# -> enums: an array of nested ProtoDsl::Enum instances
# -> oneofs: an array of nested ProtoDsl::Oneof instances

# The ProtoDsl::Message class has four instance methods:

# -> field: defines a new field in the message with the given type, name, and tag
# -> message: defines a nested message within the current message
# -> enum: defines a nested enum within the current message
# -> oneof: defines a oneof group within the current message
# -> to_proto: generates the protobuf code for the message, and returns the generated code as a string.

# The to_proto method generates the protobuf code for the message by concatenating the name of the message, the individual fields in the fields array as protobuf code, the nested messages, enums, and oneofs as protobuf code, and a closing } character.
# For example, given a message named MyMessage with fields my_field (type string, tag 1) and my_other_field (type int32, tag 2), the to_proto method would generate the following protobuf code:

# ```proto
# message MyMessage {
#   string my_field = 1;
#   int32 my_other_field = 2;
# }
# ```

# The ProtoDsl::Message class is typically used by the ProtoDsl::Dsl class to define protobuf messages.
# The ProtoDsl::Dsl class uses the message method to define a new ProtoDsl::Message instance, and then uses the methods in the ProtoDsl::Message class to define the fields, messages, enums, and oneofs
