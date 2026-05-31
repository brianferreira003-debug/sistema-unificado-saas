#!/usr/bin/env python3
"""Entry point for Render deployment."""
import os
import sys

# Ensure static directory exists
os.makedirs('static', exist_ok=True)
os.makedirs('data', exist_ok=True)
os.makedirs('templates', exist_ok=True)

# Load environment variables from .env
env_path = os.path.join(os.path.dirname(__file__), '.env')
if os.path.exists(env_path):
    with open(env_path) as f:
        for line in f:
            line = line.strip()
            if line and not line.startswith('#') and '=' in line:
                key, _, value = line.partition('=')
                key = key.strip()
                value = value.strip().strip('"').strip("'")
                if key and key not in os.environ:
                    os.environ[key] = value

# Import app after env setup
from app import app

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 5000))
    debug = os.environ.get('FLASK_DEBUG', '0') == '1'
    print(f"\n✅ Sistema Unificado SaaS v3.2 → http://localhost:{port}\n")
    app.run(debug=debug, host='0.0.0.0', port=port)
