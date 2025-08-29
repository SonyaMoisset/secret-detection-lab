#!/bin/bash

echo "🔐 Setting up secrets management..."

# Install pre-commit
pip install pre-commit
pre-commit install

# Install git-secrets
if ! command -v git-secrets &> /dev/null; then
  echo "Installing git-secrets..."
  brew install git-secrets || {
    git clone https://github.com/awslabs/git-secrets
    cd git-secrets && sudo make install && cd ..
    rm -rf git-secrets
  }
fi

# Configure git-secrets
git secrets --install
git secrets --register-aws
git secrets --add 'api[_-]?key.*["\s]=.*["\s]'

# Create .env from template
if [ ! -f .env ]; then
  cp .env.example .env
  echo "✅ Created .env from template"
  echo "⚠️  Remember to fill in your actual values!"
fi

echo "✅ Secret protection activated!"
