#!/usr/bin/env bash

set -u

input=$(cat)
session_id=$(jq -r '.session_id // empty' <<<"$input")
cwd=$(jq -r '.cwd // empty' <<<"$input")

if [[ -z "$session_id" || -z "$cwd" ]]; then
  exit 0
fi

marker="${TMPDIR:-/tmp}/claude-auto-resume-${session_id}"
log="${TMPDIR:-/tmp}/claude-auto-resume-${session_id}.log"

# Do not schedule duplicate jobs when several requests hit the same limit.
if ! mkdir "$marker" 2>/dev/null; then
  exit 0
fi

nohup bash -c '
  session_id=$1
  cwd=$2
  marker=$3
  log=$4

  # Subscription sessions use a five-hour window. The extra two minutes
  # avoid retrying on the boundary if clocks differ slightly.
  sleep 18120

  cd "$cwd" || exit 1
  if claude --print --resume "$session_id" \
    "Continue the interrupted task from where you stopped." >>"$log" 2>&1
  then
    rmdir "$marker"
  fi
' _ "$session_id" "$cwd" "$marker" "$log" </dev/null >>"$log" 2>&1 &

exit 0
