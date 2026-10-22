#!/usr/bin/env bash
# Regenerates images/734-dark.png, images/734-light.png and images/hero.png
# from your real nvim setup. Needs tmux, chromium, ImageMagick, ts_ls and
# JetBrainsMono Nerd Font.
set -euo pipefail
here=$(cd "$(dirname "$0")" && pwd)
images=$here/../../images
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

"$here/capture.sh" dark "$tmp/dark.ansi"
"$here/capture.sh" light "$tmp/light.ansi"

shoot() { # <html> <png> <size from render.py>
	local w=${3% *} h=${3#* }
	chromium --headless=new --disable-gpu --hide-scrollbars --force-device-scale-factor=2 \
		--default-background-color=00000000 --window-size="$w,$h" \
		--screenshot="$2" "file://$1" 2>/dev/null
	magick "$2" -strip -define png:compression-level=9 "$2"
}

shoot "$tmp/dark.html" "$images/734-dark.png" \
	"$("$here/render.py" "$tmp/dark.html" "palette.ts — colorscheme 734" "$tmp/dark.ansi")"
shoot "$tmp/light.html" "$images/734-light.png" \
	"$("$here/render.py" "$tmp/light.html" "palette.ts — colorscheme 734-light" "$tmp/light.ansi")"
shoot "$tmp/hero.html" "$images/hero.png" \
	"$("$here/render.py" "$tmp/hero.html" "palette.ts — 734 / 734-light" "$tmp/dark.ansi" "$tmp/light.ansi")"
ls -l "$images"/734-dark.png "$images"/734-light.png "$images"/hero.png
