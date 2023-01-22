#!/bin/bash
set -euo pipefail

CREDENTIALS=$(aws sts assume-role --role-arn arn:aws:iam::123456789012:role/example-5-role --role-session-name example-5-session)
echo "example-5-role Credentials: ${CREDENTIALS}"

echo "Retrieved example-5-role credentials successfully"