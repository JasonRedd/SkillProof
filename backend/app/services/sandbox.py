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

        container_name = f"skillproof_exec_{uuid.uuid4().hex}"
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
            process = subprocess.Popen(
                docker_cmd,
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                text=True
            )

            # WINDOWS FIX: Add a boot grace period.
            # We wait up to 5 seconds for the container to actually start 
            # before we start counting the strict execution time_limit.
            boot_timeout = 5 
            start_time = time.time()
            
            try:
                # We use communicate with a larger timeout to account for Docker boot time
                stdout, stderr = process.communicate(timeout=time_limit + boot_timeout)
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
    # We reuse the same verification logic in the verify_sandbox.py file,
    # but I will update the service file first.
    print("SandboxManager updated with Windows Boot Grace Period.")
