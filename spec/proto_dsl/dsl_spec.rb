# frozen_string_literal: true

RSpec.describe ProtoDsl::Dsl do
  describe "#to_proto" do
    it "generates the correct protobuf code for a service" do
      dsl = ProtoDsl::Dsl.new
      dsl.service "MyService" do
        rpc :my_rpc, :MyRequest, :MyResponse do
          option :my_option, :value
        end
      end

      expected_proto = <<~PROTO
      syntax = "proto2";
      service MyService {
        rpc my_rpc (MyRequest) returns (MyResponse) {
          option my_option = value;
        }
      }
      PROTO

      expect(dsl.to_proto).to eq(expected_proto)
    end
  end
end
