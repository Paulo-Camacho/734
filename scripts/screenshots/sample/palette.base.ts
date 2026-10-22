import type { Variant } from "./types";

// Every syntax role gets its own hue; punctuation stays grey.
const ORANGE = "#ff6900";
const CONTRAST_MIN = 4.3;

export interface Palette {
  name: string;
  variant: Variant;
  colors: Record<string, string>;
}

export function contrast(hex: string, variant: Variant): number {
  const bg = variant === "dark" ? 0x000000 : 0xfdfaf6;
  return Math.abs(parseInt(hex.slice(1), 16) - bg) / 0xffffff * 21;
}

export async function loadPalette(url: string): Promise<Palette> {
  const res = await fetch(url);
  const palette = (await res.json()) as Palette;
  if (!palette.colors.cursor) {
    palette.colors.cursor = ORANGE;
  }

  for (const [role, hex] of Object.entries(palette.colors)) {
    if (contrast(hex, palette.variant) < CONTRAST_MIN) {
      throw new Error(`${role} fails WCAG AA: ${hex}`);
    }
  }
  return palette;
}
