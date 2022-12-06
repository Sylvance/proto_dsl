# frozen_string_literal: true

require_relative "./rpc"

module ProtoDsl
  # Service class
  class Service
    attr_reader :name, :rpcs

    def initialize(name)
      @name = name
      @rpcs = []
    end

    def rpc(name, request_type, response_type, &block)
      rpc = Rpc.new(name, request_type, response_type)
      rpc.instance_eval(&block) if block_given?
      @rpcs << rpc
    end

    def to_proto
      output = "service #{@name} {\n"
      @rpcs.each do |rpc|
        output << rpc.to_proto
      end
      output << "}\n"
      output
    end
  end
end
