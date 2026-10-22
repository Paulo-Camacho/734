#!/usr/bin/env python3
"""Turn tmux captures (capture.sh) into framed HTML windows.

    render.py <out.html> <title> <dark.ansi> [<light.ansi>]

With one capture it draws a single window. With two it draws the hero: the
dark capture with the light one laid over it, split on a diagonal.
"""
import html
import re
import sys
from pathlib import Path

# window chrome and the cursor, per variant; everything else comes from the capture
THEME = {
    "dark": {"bg": "#000000", "fg": "#d4d4d4", "bar": "#14110f", "title": "#8c8c8c",
             "edge": "rgba(255,255,255,.09)", "cursor": "#ff6900", "on_cursor": "#000000"},
    "light": {"bg": "#fdfaf6", "fg": "#241f31", "bar": "#efe8e0", "title": "#6b655e",
              "edge": "rgba(0,0,0,.10)", "cursor": "#ff6900", "on_cursor": "#14171c"},
}

SGR = re.compile(r"\x1b\[([0-9;:]*)m")


def parse(path):
    """ANSI text -> rows of (char, style) cells; style is a frozen attr dict."""
    rows, state = [], {}
    for line in Path(path).read_text().split("\n"):
        cells, pos = [], 0
        for m in SGR.finditer(line):
            cells += [(ch, dict(state)) for ch in line[pos:m.start()]]
            apply_sgr(state, m.group(1))
            pos = m.end()
        cells += [(ch, dict(state)) for ch in line[pos:]]
        rows.append(cells)
    while rows and all(ch == " " for ch, _ in rows[-1]):
        rows.pop()  # the empty command line
    return rows


def apply_sgr(state, params):
    parts = params.split(";") if params else ["0"]
    i = 0
    while i < len(parts):
        p = parts[i]
        sub = p.split(":")
        code = int(sub[0] or 0)
        if code in (38, 48, 58) and len(parts) > i + 4 and parts[i + 1] == "2":
            key = {38: "fg", 48: "bg", 58: "sp"}[code]
            state[key] = "#%02x%02x%02x" % tuple(int(x) for x in parts[i + 2:i + 5])
            i += 5
            continue
        if code == 0:
            state.clear()
        elif code == 1:
            state["bold"] = True
        elif code == 2:
            state["dim"] = True
        elif code == 3:
            state["italic"] = True
        elif code == 4:
            state["underline"] = {"3": "wavy", "2": "double", "4": "dotted", "5": "dashed"}.get(
                sub[1] if len(sub) > 1 else "", "solid")
            if len(sub) > 1 and sub[1] == "0":
                state.pop("underline", None)
        elif code == 7:
            state["reverse"] = True
        elif code == 9:
            state["strike"] = True
        elif code == 22:
            state.pop("bold", None)
            state.pop("dim", None)
        elif code == 23:
            state.pop("italic", None)
        elif code == 24:
            state.pop("underline", None)
        elif code == 27:
            state.pop("reverse", None)
        elif code == 29:
            state.pop("strike", None)
        elif code in (39, 49, 59):
            state.pop({39: "fg", 49: "bg", 59: "sp"}[code], None)
        i += 1


def css(style, theme):
    fg, bg = style.get("fg", theme["fg"]), style.get("bg", theme["bg"])
    if style.get("reverse"):
        fg, bg = bg, fg
    out = [f"color:{fg}", f"background:{bg}"]
    if style.get("bold"):
        out.append("font-weight:700")
    if style.get("italic"):
        out.append("font-style:italic")
    if style.get("dim"):
        out.append("opacity:.6")
    deco = []
    if style.get("underline"):
        deco.append("underline")
    if style.get("strike"):
        deco.append("line-through")
    if deco:
        out.append("text-decoration:" + " ".join(deco))
        if style.get("underline"):
            out.append(f"text-decoration-style:{style['underline']}")
        out.append(f"text-decoration-color:{style.get('sp', fg)}")
    return ";".join(out)


def grid(path, variant):
    theme = THEME[variant]
    rows = parse(path)
    cx, cy = (int(n) for n in Path(path + ".cursor").read_text().split())
    if cy < len(rows) and cx < len(rows[cy]):
        ch, style = rows[cy][cx]
        rows[cy][cx] = (ch, {**style, "fg": theme["on_cursor"], "bg": theme["cursor"], "reverse": False})
    out = []
    for cells in rows:
        spans, run, run_css = [], "", None
        for ch, style in cells:
            c = css(style, theme)
            if c != run_css and run:
                spans.append(f'<span style="{run_css}">{html.escape(run)}</span>')
                run = ""
            run += ch
            run_css = c
        if run:
            spans.append(f'<span style="{run_css}">{html.escape(run)}</span>')
        out.append(f'<div class="row">{"".join(spans)}</div>')
    return "\n".join(out), max(len(r) for r in rows), len(rows)


def window(body, variant, title, extra=""):
    t = THEME[variant]
    return f"""
<div class="window {extra}" style="background:{t['bg']};box-shadow:inset 0 0 0 1px {t['edge']}">
  <div class="bar" style="background:{t['bar']};color:{t['title']}">
    <i style="background:#ff5f57"></i><i style="background:#febc2e"></i><i style="background:#28c840"></i>
    <span>{html.escape(title)}</span>
  </div>
  <div class="term" style="background:{t['bg']}">{body}</div>
</div>"""


def main():
    out, title, dark = sys.argv[1], sys.argv[2], sys.argv[3]
    light = sys.argv[4] if len(sys.argv) > 4 else None
    variant = "light" if not light and "light" in Path(dark).name else "dark"
    body, cols, nrows = grid(dark, variant)
    windows = window(body, variant, title)
    if light:
        lbody, _, _ = grid(light, "light")
        windows += window(lbody, "light", title, "overlay")
    cell_w, line_h, pad_x, pad_y = 9, 20, 18, 14  # 15px JetBrains Mono: 0.6em advance
    w, h = cols * cell_w + 2 * pad_x, 40 + nrows * line_h + 2 * pad_y
    Path(out).write_text(f"""<!doctype html><meta charset="utf-8">
<style>
  html, body {{ margin: 0; background: transparent; }}
  .stage {{ position: relative; width: {w}px; height: {h}px; margin: 48px 64px 80px; border-radius: 12px;
           box-shadow: 0 30px 70px rgba(0,0,0,.30), 0 8px 20px rgba(0,0,0,.18); }}
  .window {{ position: absolute; inset: 0; border-radius: 12px; overflow: hidden; }}
  .overlay {{ clip-path: polygon(64% 0, 100% 0, 100% 100%, 40% 100%); }}
  .bar {{ position: relative; height: 40px; display: flex; align-items: center; gap: 8px; padding: 0 16px;
         font: 500 13px/1 "JetBrainsMono Nerd Font", monospace; letter-spacing: .02em; }}
  .bar i {{ width: 12px; height: 12px; border-radius: 50%; display: block; }}
  .bar span {{ position: absolute; left: 0; right: 0; text-align: center; pointer-events: none; }}
  .term {{ padding: {pad_y}px {pad_x}px; font: 15px/{line_h}px "JetBrainsMono Nerd Font", monospace;
          font-variant-ligatures: none; }}
  .row {{ height: {line_h}px; white-space: pre; }}
</style>
<div class="stage">{windows}</div>
""")
    print(f"{w + 128} {h + 128}")  # page size for the screenshot


if __name__ == "__main__":
    main()
