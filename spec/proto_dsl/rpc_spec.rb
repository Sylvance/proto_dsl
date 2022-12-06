# frozen_string_literal: true

RSpec.describe ProtoDsl::Rpc do
  describe "#to_proto" do
    it "generates the correct protobuf code for an RPC service" do
      rpc = ProtoDsl::Rpc.new "MyRpc", "MyRequest", "MyResponse"
      rpc.option "my_option", "foo"
      rpc.option "my_other_option", 42

      expected_proto = "  rpc MyRpc (MyRequest) returns (MyResponse) {\n    option my_option = foo;\n    option my_other_option = 42;\n  }\n"

      expect(rpc.to_proto).to eq(expected_proto)
    end
  end
end
