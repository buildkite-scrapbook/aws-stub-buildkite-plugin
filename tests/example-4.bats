#!/usr/bin/env bats

load "/usr/local/lib/bats/load.bash"

# export AWS_STUB_DEBUG=3

teardown() {
    unstub aws
}

@test "Test AWS Assume Role - Example 4" {
    CREDS_JSON='{
        "Credentials": {
            "SecretAccessKey": "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY",
            "SessionToken": "AQoDYXdzEJr...<remainder of session token>",
            "Expiration": "2016-03-15T00:05:07Z",
            "AccessKeyId": "ASIAIOSFODNN7EXAMPLE"
        }
    }'

    TEXT="party time"

    stub aws \
        "sts assume-role --role-arn arn:aws:iam::123456789012:role/example-4-role --role-session-name example-4-session : echo ${TEXT}"

    run "$PWD/scripts/example-4.sh"

    assert_success
    assert_output --partial "party time"
}