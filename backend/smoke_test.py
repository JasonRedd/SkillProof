import requests
import time
import subprocess
import os

# Start the FastAPI server in the background
process = subprocess.Popen(
    ["uvicorn", "app.main:app", "--host", "127.0.0.1", "--port", "8000"],
    cwd="C:/Users/mjais/Projects/SkillProof/backend",
    stdout=subprocess.PIPE,
    stderr=subprocess.PIPE,
    text=True
)

time.sleep(3) # Give server time to boot

try:
    # 1. Test Registration
    print("Testing Registration...")
    reg_data = {"username": "test_user", "email": "test@example.com", "password": "password123"}
    reg_resp = requests.post("http://127.0.0.1:8000/api/v1/auth/register", json=reg_data)
    print(f"Registration Response: {reg_resp.status_code} - {reg_resp.text}")

    # 2. Test Challenge Creation
    print("\nTesting Challenge Creation...")
    chal_data = {
        "title": "Hello World Python",
        "description": "Print hello world",
        "category": "Python",
        "difficulty": "Easy",
        "starter_code": "print()",
        "time_limit": 2,
        "memory_limit": 128
    }
    chal_resp = requests.post("http://127.0.0.1:8000/api/v1/challenges", json=chal_data)
    print(f"Challenge Response: {chal_resp.status_code} - {chal_resp.text}")

    if reg_resp.status_code == 201 and chal_resp.status_code == 201:
        print("\n? INTEGRATION SUCCESS: API and Database are talking!")
    else:
        print("\n? INTEGRATION FAILURE: Check logs.")

finally:
    process.terminate()
