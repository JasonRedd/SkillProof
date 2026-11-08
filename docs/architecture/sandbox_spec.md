# SkillProof Sandbox Specification

## 1. Overview
The Sandbox is the core security layer of SkillProof. It is responsible for executing untrusted user-submitted code in a completely isolated environment to prevent host system compromise.

## 2. Isolation Strategy: Docker-based Containers
We will use **Docker** to create a "throwaway" environment for every single submission.

### Execution Lifecycle:
1. **Request**: API receives code and language (e.g., Python).
2. **Provision**: Sandbox Manager pulls a minimal image (e.g., `python:3.11-slim`).
3. **Mount**: Code is written to a temporary volume as a single file (e.g., `solution.py`).
4. **Execute**: Container is started with a specific command: `python solution.py`.
5. **Monitor**: A watchdog timer kills the container if it exceeds the `time_limit`.
6. **Collect**: `stdout` and `stderr` are captured.
7. **Destroy**: Container and temporary volumes are immediately deleted.

## 3. Security Constraints (Hard Limits)
To prevent malicious code (e.g., infinite loops, memory bombs), the following limits are enforced at the Docker level:

| Constraint | Limit | Purpose |
| :--- | :--- | :--- |
| **CPU** | 0.5 vCPU | Prevents CPU exhaustion/mining |
| **Memory** | 128MB - 256MB | Prevents RAM crashes (OOM) |
| **Time** | 2s - 5s | Prevents infinite loops |
| **Network** | Disabled (`--network none`) | Prevents data exfiltration/botnets |
| **Disk** | Read-only Root FS | Prevents modification of the environment |
| **Privilege** | Non-root user | Prevents container escape |

## 4. Evaluation Logic
The Sandbox does not just "run" code; it compares output.

**The Comparison Pipeline:**
`Code` $\rightarrow$ `Sandbox` $\rightarrow$ `Actual Output` $\rightarrow$ `Comparison with Expected Output (from DB)` $\rightarrow$ `Pass/Fail`.

## 5. Failure Modes
- **Tle (Time Limit Exceeded)**: Container killed by watchdog.
- **Mle (Memory Limit Exceeded)**: Container killed by Docker OOM killer.
- **Re (Runtime Error)**: Non-zero exit code (captured via `stderr`).
- **Wa (Wrong Answer)**: Output does not match test case.

