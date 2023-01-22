#!/bin/bash
set -euo pipefail

CREDENTIALS=$(aws sts assume-role --role-arn arn:aws:iam::123456789012:role/role-name --role-session-name RoleSession1)
echo "Assume Role Output: ${CREDENTIALS}"

echo "Finished Assume Role"