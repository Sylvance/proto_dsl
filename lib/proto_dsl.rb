# frozen_string_literal: true

Dir[File.join(__dir__, "proto_dsl", "*.rb")].sort.each { |file| require file }

module ProtoDsl
  class Error < StandardError; end
end
