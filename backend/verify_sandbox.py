import os
import sys
import subprocess
import uuid
import time
from typing import Tuple

class SandboxManager:
    def __init__(self):
        try:
            subprocess.run(["docker", "--version"], capture_output=True, check=True)
            self.docker_available = True
        except Exception:
            self.docker_available = False

    def execute_python_code(self, code: str, time_limit: int = 2, memory_limit: int = 128) -> Tuple[str, str, str]:
        if not self.docker_available:
            return "", "Docker CLI not available", "InfrastructureError"

        container_name = f"skillproof_test_{uuid.uuid4().hex}"
        image = "python:3.11-slim"
        escaped_code = code.replace('"', '\\"')
        py_cmd = f"python3 -c \"{escaped_code}\""
        
        docker_cmd = [
            "docker", "run", "--rm",
            "--name", container_name,
            "--network", "none",
            "--memory", f"{memory_limit}m",
            "--cpus", "0.5",
            "--user", "1000:1000",
            image,
            "sh", "-c", py_cmd
        ]

        try:
            process = subprocess.Popen(docker_cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
            try:
                # Added boot grace period for Windows
                stdout, stderr = process.communicate(timeout=time_limit + 5)
                exit_code = process.returncode
            except subprocess.TimeoutExpired:
                subprocess.run(["docker", "kill", container_name], capture_output=True)
                subprocess.run(["docker", "rm", "-f", container_name], capture_output=True)
                return "", "Time Limit Exceeded", "TLE"

            if exit_code == 0:
                return stdout, stderr, "Success"
            else:
                return stdout, stderr, "RuntimeError"
        except Exception as e:
            return "", str(e), "SystemError"

if __name__ == "__main__":
    sb = SandboxManager()
    print("\n" + "="*40)
    print(" SKILLPROOF SANDBOX VERIFICATION (v2) ")
    print("="*40)
    
    tests = [
        ("Basic Execution", "print('Success')", "Success"),
        ("Infinite Loop (TLE)", "while True: pass", "TLE"),
        ("Runtime Error", "print(1/0)", "RuntimeError"),
    ]

    all_passed = True
    for name, code, expected in tests:
        print(f"Testing {name}...", end=" ")
        out, err, status = sb.execute_python_code(code)
        if status == expected:
            print("? PASS")
        else:
            print(f"? FAIL (Got: {status}, Expected: {expected})")
            all_passed = False

    print("="*40)
    if all_passed:
        print(" RESULT: ? SANDBOX VERIFIED")
    else:
        print(" RESULT: ? VERIFICATION FAILED")
    print("="*40 + "\n")
