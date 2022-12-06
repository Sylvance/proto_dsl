# ProtoDsl

The `ProtoDsl::DSL` is a Domain Specific Language (DSL) for defining Protocol Buffer message types. It provides a simple, readable syntax for defining Protocol Buffer message types using Ruby code. The `to_proto` method can be used to convert the defined message types into the Protocol Buffer syntax.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add proto_dsl

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install proto_dsl

## Usage

This gem defines a `Protocol Buffer` message type using the `ProtoDsl::DSL` class. It specifies the syntax version, package name, and import paths. It also sets some options and defines a service with two RPCs. The code also defines several message types, an enum, and a oneof field. The to_proto method at the end of the code converts the defined message types into the Protocol Buffer syntax.

```ruby
# frozen_string_literal: true

require 'proto_dsl'

ProtoDsl::Dsl.new.tap do |dsl|
  dsl.syntax "proto2"
  dsl.package "my_package"
  dsl.import "google/protobuf/wrappers.proto"

  dsl.option "java_package", "com.example.app"
  dsl.option "java_outer_classname", "MyProto"

  dsl.service "MyService" do
    rpc "GetData", "GetDataRequest", "GetDataResponse"
    rpc "UpdateData", "UpdateDataRequest", "UpdateDataResponse" do
      option "method", "POST"
    end
  end

  dsl.message "GetDataRequest" do
    field "string", "id", 1
    field "int32", "version", 2

    message "Filter" do
      field "string", "field", 1
      field "string", "value", 2
    end

    field "repeated", "filters", 3, type: "Filter"

    oneof "params" do
      option "deprecated", true
      field "string", "id", 1
      field "int32", "version", 2
    end
  end

  dsl.message "GetDataResponse" do
    field "string", "data", 1
  end

  dsl.message "UpdateDataRequest" do
    field "string", "id", 1
    field "int32", "version", 2
    field "string", "data", 3
  end

  dsl.message "UpdateDataResponse" do
    field "bool", "success", 1
  end

  dsl.enum "Status" do
    value "OK", 0
    value "ERROR", 1
  end
end.to_proto
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Sylvance/proto_dsl. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/Sylvance/proto_dsl/blob/main/CODE_OF_CONDUCT.md).

## Code of Conduct

Everyone interacting in the ProtoDsl project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/Sylvance/proto_dsl/blob/main/CODE_OF_CONDUCT.md).
