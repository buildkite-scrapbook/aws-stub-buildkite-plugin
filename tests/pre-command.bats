#!/usr/bin/env bats

load "/usr/local/lib/bats/load.bash"

export AWS_STUB_DEBUG=3

# Setup - Before each test case
setup() {
    # Example AWS Credentials JSON
    export CREDENTIALS_OUTPUT='{
        "Credentials": {
            "AccessKeyId": "ASIAIOSFODNN7EXAMPLE",
            "SecretAccessKey": "je7MtGbClwBF/2Zp9Utk/h3yCo8nvbEXAMPLEKEY",
            "SessionToken": "AQoXdzELDDY//////////wEaoAK1wvxJY12r2IrDFT2IvAzTCn3zHoZ7YNtpiQLF0MqZye/qwjzP2iEXAMPLEbw/m3hsj8VBTkPORGvr9jM5sgP+w9IZWZnU+LWhmg+a5fDi2oTGUYcdg9uexQ4mtCHIHfi4citgqZTgco40Yqr4lIlo4V2b2Dyauk0eYFNebHtYlFVgAUj+7Indz3LU0aTWk1WKIjHmmMCIoTkyYp/k7kUG7moeEYKSitwQIi6Gjn+nyzM+PtoA3685ixzv0R7i5rjQi0YE0lf1oeie3bDiNHncmzosRM6SFiPzSvp6h/32xQuZsjcypmwsPSDtTPYcs0+YN/8BRi2/IcrxSpnWEXAMPLEXSDFTAQAM6Dl9zR0tXoybnlrZIwMLlMi1Kcgo5OytwU=",
            "Expiration": "2023-01-19T10:40:42Z"
        }
    }'

    # Stubs
    stub aws \
        "sts assume-role --role-arn arn:aws:iam::123456789012:role/xaccounts3access --role-session-name s3-access-example : echo ${CREDENTIALS_OUTPUT}"

}

# Teardown - After each test case
teardown() {
    unstub aws
}

@test "Test AWS Assume Role" {
    run "$PWD/hooks/pre-command"

    # echo "Output: $output"
    # echo "Status: $status"
    # echo "Result: $result"

    assert_success
    assert_output --partial "ROLE_ARN: arn:aws:iam::123456789012:role/xaccounts3access"
    assert_output --partial "ROLE_SESSION_NAME: s3-access-example"
    assert_output --partial "Using aws stub command: aws sts assume-role --role-arn arn:aws:iam::123456789012:role/xaccounts3access --role-session-name s3-access-example"
    # assert_output --partial "ASIAIOSFODNN7EXAMPLE"
    assert_output --partial "Assumed Role Successfully"
}