#!/usr/bin/env bash
# Runs your real nvim (config, plugins, statusline) on the sample project in a
# detached tmux pane and saves the screen, with colors, as ANSI text.
#   capture.sh <dark|light> <out.ansi>
set -euo pipefail
here=$(cd "$(dirname "$0")" && pwd)
variant=$1 out=$2
cols=${SHOT_COLS:-100} rows=${SHOT_ROWS:-32}

# the project dir is named 734 so the statusline path reads 734/src/palette.ts
work=$(mktemp -d)/734
trap 'tmux -L 734shots kill-server 2>/dev/null || true; rm -rf "$(dirname "$work")"' EXIT
cp -r "$here/sample" "$work"
(
	cd "$work"
	mv palette.base.ts src/palette.ts.new && mv src/palette.ts palette.ts.work && mv src/palette.ts.new src/palette.ts
	git init -q && git add -A && git -c user.name=734 -c user.email=734@localhost commit -qm base
	mv palette.ts.work src/palette.ts
)

done_file="$work/.done"
tmux -L 734shots -f /dev/null new-session -d -s shot -x "$cols" -y "$rows" \
	-e COLORTERM=truecolor -e SHOT_VARIANT="$variant" -e SHOT_DONE="$done_file" \
	"cd '$work' && nvim -c 'luafile $here/scene.lua' src/palette.ts"
tmux -L 734shots set -g status off

for _ in $(seq 150); do
	[[ -e $done_file ]] && break
	sleep 0.1
done
[[ -e $done_file ]] || { echo "scene never became ready (no diagnostics from ts_ls?)" >&2; exit 1; }

tmux -L 734shots capture-pane -p -e -N -t shot > "$out"
tmux -L 734shots display -p -t shot '#{cursor_x} #{cursor_y}' > "$out.cursor"
