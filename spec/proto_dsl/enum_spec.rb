# frozen_string_literal: true

RSpec.describe ProtoDsl::Enum do
  describe "#to_proto" do
    it "generates the correct protobuf code for an enum" do
      enum = ProtoDsl::Enum.new "MyEnum"
      enum.value :MY_VALUE, 1
      enum.value :MY_OTHER_VALUE, 2

      expected_proto = <<~PROTO
        enum MyEnum {
          MY_VALUE = 1;
          MY_OTHER_VALUE = 2;
        }
      PROTO

      expect(enum.to_proto).to eq(expected_proto)
    end
  end
end
