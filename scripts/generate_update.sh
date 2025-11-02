#!/usr/bin/env bash
set -e

TIL_FILE=til.md
ACTIVITY=activity_log.md
README=README.md

TIL_TEMPLATES=(
  "TIL: experimented with small Kubernetes liveness probe tweaks — %s"
  "TIL: improved Terraform variable naming — %s"
  "TIL: cleaned up a Dockerfile layer to reduce size — %s"
  "TIL: wrote a tiny bash helper for CI workflows — %s"
  "TIL: documented a CI gotcha and solution — %s"
)

TS=$(date --utc +"%Y-%m-%d %H:%M UTC")
idx=$((RANDOM % ${#TIL_TEMPLATES[@]}))
line=$(printf "${TIL_TEMPLATES[$idx]}" "$TS")

mkdir -p "$(dirname "$TIL_FILE")"
[ ! -f "$TIL_FILE" ] && echo "# Today I Learned" > "$TIL_FILE"
echo -e "\n- $line\n\nDetails: Tried out a short snippet and noted the result.\n" >> "$TIL_FILE"

[ ! -f "$ACTIVITY" ] && echo "Activity log" > "$ACTIVITY"
echo "${TS} — updated TIL and README" >> "$ACTIVITY"

if grep -q "^Last automation update:" "$README" 2>/dev/null; then
  sed -i "s/^Last automation update:.*/Last automation update: ${TS}/" "$README"
else
  echo "\nLast automation update: ${TS}" >> "$README"
fi

python - <<'PY'
from pathlib import Path
p=Path('README.md')
text=p.read_text()
if 'Automation score:' not in text:
    text += '\nAutomation score: 7/10\n'
p.write_text(text)
PY

mkdir -p .automation
uname -a > .automation/host_info.txt
