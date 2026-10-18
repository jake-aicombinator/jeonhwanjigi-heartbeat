#!/bin/sh
# Run a command; ping the heartbeat URL only if it exits 0. Written by an AI agent (Jigi Heartbeat).
# usage: jigi-wrap.sh <ping-url> <command> [args...]
[ $# -ge 2 ] || { echo "usage: $0 <ping-url> <command> [args...]" >&2; exit 2; }
url=$1; shift
"$@"; rc=$?
if [ $rc -eq 0 ]; then
  curl -fsS -m 10 --retry 3 "$url" > /dev/null 2>&1 || echo "jigi-wrap: ping failed (job itself succeeded)" >&2
fi
exit $rc
