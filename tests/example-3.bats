#!/usr/bin/env bats

load "/usr/local/lib/bats/load.bash"

teardown() {
    unstub aws
}

@test "Test AWS Assume Role" {
    OUTPUT='{
        "AssumedRoleUser": {
            "AssumedRoleId": "AROA3XFRBF535PLBIFPI4:s3-access-example",
            "Arn": "arn:aws:sts::123456789012:assumed-role/xaccounts3access/s3-access-example"
        },
        "Credentials": {
            "SecretAccessKey": "9drTJvcXLB89EXAMPLELB8923FB892xMFI",
            "SessionToken": "AQoXdzELDDY//////////wEaoAK1wvxJY12r2IrDFT2IvAzTCn3zHoZ7YNtpiQLF0MqZye/qwjzP2iEXAMPLEbw/m3hsj8VBTkPORGvr9jM5sgP+w9IZWZnU+LWhmg+a5fDi2oTGUYcdg9uexQ4mtCHIHfi4citgqZTgco40Yqr4lIlo4V2b2Dyauk0eYFNebHtYlFVgAUj+7Indz3LU0aTWk1WKIjHmmMCIoTkyYp/k7kUG7moeEYKSitwQIi6Gjn+nyzM+PtoA3685ixzv0R7i5rjQi0YE0lf1oeie3bDiNHncmzosRM6SFiPzSvp6h/32xQuZsjcypmwsPSDtTPYcs0+YN/8BRi2/IcrxSpnWEXAMPLEXSDFTAQAM6Dl9zR0tXoybnlrZIwMLlMi1Kcgo5OytwU=",
            "Expiration": "2016-03-15T00:05:07Z",
            "AccessKeyId": "ASIAJEXAMPLEXEG2JICEA"
        }
    }'

    stub aws \
        "sts assume-role --role-arn arn:aws:iam::123456789012:role/role-name --role-session-name RoleSession1 : echo ${OUTPUT}"

    run "$PWD/scripts/example-3.sh"

    assert_success
    assert_output --partial "Finished"
}