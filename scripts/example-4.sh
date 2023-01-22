#!/bin/bash
set -euo pipefail

CREDENTIALS=$(aws sts assume-role --role-arn arn:aws:iam::123456789012:role/example-4-role --role-session-name example-4-session)
echo "example-4-role Credentials: ${CREDENTIALS}"

echo "Retrieved example-4-role credentials successfully"