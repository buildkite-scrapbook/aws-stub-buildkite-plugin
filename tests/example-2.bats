#!/usr/bin/env bats

load "/usr/local/lib/bats/load.bash"

teardown() {
  unstub aws
}

@test "test with asterisk" {
  stub aws \
    "ec2 describe-snapshots --query Snapshots[*].{Time:StartTime} : echo 'foo'"

  run aws ec2 describe-snapshots --query Snapshots[*].{Time:StartTime}
#   [ "$output" = "foo" ]
    assert_success
    assert_output --partial "foo"
}

@test "test without asterisk" {
  stub aws \
    "ec2 describe-snapshots --query Snapshots[].{Time:StartTime} : echo 'foo'"

  run aws ec2 describe-snapshots --query Snapshots[].{Time:StartTime}
#   [ "$output" = "foo" ]
    assert_success
    assert_output --partial "foo"
}