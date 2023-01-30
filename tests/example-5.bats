#!/usr/bin/env bats

load "/usr/local/lib/bats/load.bash"

export AWS_STUB_DEBUG=3

teardown() {
    unstub aws
    echo "unstub status: $status"
    echo "unstub result: $result"
}

@test "Test AWS Assume Role - Example 5" {
json_object_multiple_line_cat=$(cat <<EOF
{
    "status": "success",
    "message": "Employee list",
    "start": 0,
    "total_results": 1,
    "data": [
        {
            "empId": "1001",
            "name": "Tim",
            "designation": "Engineer"
        }
    ]
}
EOF
)

    TEXT="party time"

    stub aws \
        "sts assume-role --role-arn arn:aws:iam::123456789012:role/example-5-role --role-session-name example-5-session : echo ${json_object_multiple_line_cat}"

    run "$PWD/scripts/example-5.sh"

    assert_success
    assert_output --partial "success"
}