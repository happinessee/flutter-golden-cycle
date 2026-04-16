#!/usr/bin/env sh
# worktree-port.sh — deterministic web-port allocator for Flutter worktrees.
#
# Same worktree name always produces the same port, so flutter run / hot reload
# URLs stay stable across sessions.
#
# Usage: bash worktree-port.sh <worktree-name>
# Output: a single integer in [PORT_FLOOR, PORT_FLOOR + BUCKETS - 1]
#
# Cross-platform: prefers `shasum -a 256` (macOS), falls back to `sha256sum` (Linux/Git-Bash).
# Windows native users should use `scripts/worktree-port.ps1`.

set -eu

# TODO(user): Review these constants for your team.
# PORT_FLOOR — must avoid common dev-server defaults (3000, 5173, 8000, 8080 collisions).
#   Sticking to 8080 means collisions with another flutter or jenkins dev instance on that port.
# BUCKETS — controls collision probability across parallel worktrees:
#   100 → [8080, 8179]; ~20% collision at 10 active worktrees (birthday paradox).
#   200 → [8080, 8279]; ~5% collision at 10 active worktrees, but eats into 8280+ range (grafana etc).
#   500 → [8080, 8579]; near-zero collision, widest range used.
PORT_FLOOR=8080
BUCKETS=100

if [ "$#" -lt 1 ]; then
  echo "Usage: bash $0 <worktree-name>" >&2
  exit 1
fi

name="$1"

hash_cmd() {
  if command -v shasum >/dev/null 2>&1; then
    shasum -a 256
  elif command -v sha256sum >/dev/null 2>&1; then
    sha256sum
  else
    echo "ERROR: neither 'shasum' nor 'sha256sum' is available" >&2
    exit 2
  fi
}

# Take first 8 hex chars of sha256 → integer → modulo BUCKETS.
hex=$(printf '%s' "$name" | hash_cmd | cut -c1-8)
# POSIX arithmetic: base-16 interpretation.
n=$(printf '%d' "0x$hex")
bucket=$(( n % BUCKETS ))
if [ "$bucket" -lt 0 ]; then
  bucket=$(( bucket + BUCKETS ))
fi
port=$(( PORT_FLOOR + bucket ))
printf '%d\n' "$port"
