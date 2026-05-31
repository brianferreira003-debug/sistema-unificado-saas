import sys, logging
logging.basicConfig(level=logging.DEBUG)

from app import app

print("=" * 50)
print("SECRET_KEY OK:", app.secret_key[:8] + "...")
print("Starting on 0.0.0.0:5000")
print("=" * 50)
sys.stdout.flush()

app.run(host='0.0.0.0', port=5000, debug=False, use_reloader=False)
