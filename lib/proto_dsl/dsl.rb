require_relative "./message"
require_relative "./enum"
require_relative "./service"

module ProtoDsl
  class Dsl
    attr_reader :services, :messages, :enums, :options, :imports, :syntax, :package
  
    def initialize
      @services = []
      @messages = []
      @enums = []
      @options = []
      @imports = []
      @syntax = "proto2"
      @package = ""
    end
  
    def service(name, &block)
      service = Service.new(name)
      service.instance_eval(&block)
      @services << service
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
  
    def syntax(version)
      @syntax = version
    end
  
    def package(name)
      @package = name
    end
  
    def option(name, value)
      @options << [name, value]
    end
  
    def import(path)
      @imports << path
    end
  
    def to_proto
      output = ""
      output << "syntax = \"#{@syntax}\";\n"
      output << "package #{@package};\n" if !@package.empty?
      @imports.each do |path|
        output << "import \"#{path}\";\n"
      end
      @options.each do |option|
        output << "option #{option[0]} = #{option[1]};\n"
      end
      @services.each do |service|
        output << service.to_proto
      end
      @messages.each do |message|
        output << message.to_proto
      end
      @enums.each do |enum|
        output << enum.to_proto
      end
      output
    end
  end
end

# This is the main ProtoDsl::Dsl class, which defines a domain-specific language (DSL) for defining Protocol Buffer (protobuf) messages, services, and enums. Protocol Buffers are a language-neutral, platform-neutral, extensible way of serializing structured data for use in communications protocols, data storage, and more.

# The ProtoDsl::Dsl class has several instance attributes that store the protobuf definitions that are defined using the DSL:

# -> services: an array of ProtoDsl::Service objects representing the protobuf services that have been defined
# -> messages: an array of ProtoDsl::Message objects representing the protobuf messages that have been defined
# -> enums: an array of ProtoDsl::Enum objects representing the protobuf enums that have been defined
# -> options: an array of [name, value] pairs representing the protobuf options that have been defined
# -> imports: an array of strings representing the paths of the protobuf files that have been imported
# -> syntax: a string representing the protobuf syntax version (either "proto2" or "proto3")
# -> package: a string representing the protobuf package name

# The ProtoDsl::Dsl class has several instance methods that can be used to define protobuf services, messages, enums, options, and imports, as well as to set the protobuf syntax and package. These methods are:

# -> service: defines a new protobuf service with the given name, and evaluates the given block in the context of a new ProtoDsl::Service instance
# -> message: defines a new protobuf message with the given name, and evaluates the given block in the context of a new ProtoDsl::Message instance
# -> enum: defines a new protobuf enum with the given name, and evaluates the given block in the context of a new ProtoDsl::Enum instance
# -> syntax: sets the protobuf syntax version to the given value (either "proto2" or "proto3")
# -> package: sets the protobuf package name to the given value
# -> option: defines a new protobuf option with the given name and value
# -> import: imports the protobuf file at the given path
# -> to_proto: generates the protobuf code for all of the protobuf definitions that have been defined using the DSL, and returns the generated code as a string.

# The ProtoDsl::Dsl class depends on the ProtoDsl::Message, ProtoDsl::Enum, and ProtoDsl::Service classes, which define the individual protobuf definitions that can be created using the DSL. These classes are defined in separate files that are required by the ProtoDsl::Dsl class.
