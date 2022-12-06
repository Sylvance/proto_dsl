# frozen_string_literal: true

module ProtoDsl
  class Rpc
    attr_reader :name, :request_type, :response_type, :options

    def initialize(name, request_type, response_type)
      @name = name
      @request_type = request_type
      @response_type = response_type
      @options = []
    end

    def option(name, value)
      @options << [name, value]
    end

    def to_proto
      output = "  rpc #{@name} (#{@request_type}) returns (#{@response_type}) {\n"
      @options.each do |option|
        output << "    option #{option[0]} = #{option[1]};\n"
      end
      output << "  }\n"
      output
    end
  end
end

# This is the ProtoDsl::Rpc class, which defines a protobuf RPC (remote procedure call) service. A protobuf RPC service allows clients to call methods on the server by sending a request message and receiving a response message.

# The ProtoDsl::Rpc class has four instance attributes:

# -> name: a string representing the name of the RPC service
# -> request_type: a string representing the name of the request message type
# -> response_type: a string representing the name of the response message type
# -> options: an array of [name, value] tuples representing the options for the RPC service, where name is the name of the option and value is the option's value

# The ProtoDsl::Rpc class has two instance methods:

# -> option: defines a new option for the RPC service with the given name and value
# -> to_proto: generates the protobuf code for the RPC service, and returns the generated code as a string.

# The to_proto method generates the protobuf code for the RPC service by concatenating the name, request_type, and response_type of the RPC service, the options in the options array as protobuf code, and a closing } character. 
