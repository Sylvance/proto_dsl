# frozen_string_literal: true

Dir[File.join(__dir__, 'proto_dsl', '*.rb')].each { |file| require file }

module ProtoDsl
  class Error < StandardError; end
end
