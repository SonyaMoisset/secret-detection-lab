#!/bin/bash

# Pattern definitions
patterns=(
  "api_key"
  "apikey"
  "api-key"
  "access_key"
  "secret_key"
  "client_secret"
  "auth_token"
  "private_key"
  "ssh_key"
)

# Check for suspicious patterns
for pattern in "${patterns[@]}"; do
  if grep -i "$pattern\s*=\s*[\"'][^\"']\{10,\}[\"']" "$@"; then
    echo "❌ Potential hardcoded secret found!"
    echo "Consider using environment variables instead."
    exit 1
  fi
done

echo "✅ No hardcoded secrets detected"
