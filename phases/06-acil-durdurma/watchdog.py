#!/usr/bin/env python3
"""
Acil Durdurma Bekçi Süreci (Faz 6)
Serdar Kaptan

Modelin dışında çalışır. DUR / STOP komutu ile
Agent Zero konteynerini anında duraklatır (docker pause).
"""

import subprocess
import sys
import time
import os
from datetime import datetime

CONTAINER = os.environ.get("A0_CONTAINER", "agent-zero-otonom")
LOG_FILE = os.environ.get("WATCHDOG_LOG", "/tmp/a0-watchdog.log")

def log(msg):
    ts = datetime.now().isoformat()
    line = f"[{ts}] {msg}\n"
    print(line, end="")
    with open(LOG_FILE, "a") as f:
        f.write(line)

def docker_cmd(args):
    try:
        result = subprocess.run(["docker"] + args, capture_output=True, text=True, timeout=10)
        return result.returncode == 0, result.stdout + result.stderr
    except Exception as e:
        return False, str(e)

def pause():
    ok, out = docker_cmd(["pause", CONTAINER])
    log(f"PAUSE: {'OK' if ok else 'FAIL'} {out.strip()}")
    with open("/tmp/a0-pause-state.txt", "w") as f:
        f.write(f"paused_at={datetime.now().isoformat()}\ncontainer={CONTAINER}\n")

def unpause():
    ok, out = docker_cmd(["unpause", CONTAINER])
    log(f"UNPAUSE: {'OK' if ok else 'FAIL'} {out.strip()}")

def main():
    log("Bekçi başladı. DUR/STOP veya DEVAM bekleniyor. (Serdar Kaptan)")
    log(f"Hedef konteyner: {CONTAINER}")
    while True:
        try:
            line = input().strip().upper()
            if line in ("DUR", "STOP"):
                pause()
            elif line in ("DEVAM", "RESUME", "CONTINUE"):
                unpause()
            elif line == "STATUS":
                ok, out = docker_cmd(["inspect", "-f", "{{.State.Status}}", CONTAINER])
                log(f"STATUS: {out.strip() if ok else 'bilinmiyor'}")
            else:
                log(f"Bilinmeyen komut: {line}")
        except EOFError:
            time.sleep(1)
        except KeyboardInterrupt:
            log("Bekçi durduruldu.")
            break

if __name__ == "__main__":
    main()
