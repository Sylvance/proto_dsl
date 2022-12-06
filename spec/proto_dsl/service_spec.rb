# frozen_string_literal: true

RSpec.describe ProtoDsl::Service do
  describe "#to_proto" do
    it "generates the correct protobuf code for a service definition" do
      service = ProtoDsl::Service.new "MyService"
      service.rpc "MyRpc", "MyRequest", "MyResponse" do |rpc|
        rpc.option "my_option", "foo"
        rpc.option "my_other_option", 42
      end

      expected_proto = <<~PROTO
        service MyService {
          rpc MyRpc (MyRequest) returns (MyResponse) {
            option my_option = foo;
            option my_other_option = 42;
          }
        }
      PROTO

      expect(service.to_proto).to eq(expected_proto)
    end
  end
end
