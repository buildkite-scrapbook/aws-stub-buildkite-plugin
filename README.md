# aws-stub-buildkite-plugin
Testing aws stubbing with multi arguments using buildkite-plugin-tester

Testing issues around:
- [buildkite-plugins/bats-mock](https://github.com/buildkite-plugins/bats-mock)
- [bats-core/bats-assert](https://github.com/bats-core/bats-assert)

Issues:
- bats-assert: `assert_output --partial` for partial matching on the `$output` is not working
- bats-mock: `stub` multi arguments is not working
- bats-mock: It is not taking `aws` cli commands for stubbing. Maybe it is trying to actually use the `aws` cli instead of using the aws stub. 
