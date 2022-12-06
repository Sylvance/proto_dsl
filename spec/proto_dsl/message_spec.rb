# frozen_string_literal: true

RSpec.describe ProtoDsl::Message do
  describe "#to_proto" do
    it "generates the correct protobuf code for a message" do
      message = ProtoDsl::Message.new "MyMessage"
      message.field :string, :my_field, 1
      message.field :int32, :my_other_field, 2

      expected_proto = <<~PROTO
        message MyMessage {
          string my_field = 1;
          int32 my_other_field = 2;
        }
      PROTO

      expect(message.to_proto).to eq(expected_proto)
    end
  end
end
