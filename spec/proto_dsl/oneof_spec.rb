# frozen_string_literal: true

RSpec.describe ProtoDsl::Oneof do
  describe "#to_proto" do
    it "generates the correct protobuf code for a oneof group" do
      oneof = ProtoDsl::Oneof.new "MyOneof"
      oneof.field :string, :my_field, 1
      oneof.field :int32, :my_other_field, 2

      expected_proto = "  oneof MyOneof {\n    string my_field = 1;\n    int32 my_other_field = 2;\n  }\n"

      expect(oneof.to_proto).to eq(expected_proto)
    end
  end
end
