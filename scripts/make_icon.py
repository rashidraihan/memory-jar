from PIL import Image, ImageDraw
import os

os.makedirs("assets", exist_ok=True)
S = 1024
cols = ["#F4A261", "#90BE6D", "#8ECAE6", "#E5989B", "#B5A7E8", "#F9C74F"]

def jar(d, s):
    cx, cy = S / 2, S / 2
    w, h = 360 * s, 440 * s
    l, t = cx - w / 2, cy - h / 2 + 20 * s
    r, b = cx + w / 2, cy + h / 2 + 20 * s
    d.rounded_rectangle([l, t, r, b], radius=90 * s, outline="white", width=int(18 * s))
    d.rounded_rectangle([l + 40 * s, t - 60 * s, r - 40 * s, t - 10 * s], radius=20 * s, fill="white")
    i = 0
    for row in range(3):
        for col in range(3):
            x = l + 75 * s + col * 105 * s
            y = b - 85 * s - row * 105 * s
            d.ellipse([x - 38 * s, y - 38 * s, x + 38 * s, y + 38 * s], fill=cols[i % 6])
            i += 1

full = Image.new("RGB", (S, S), "#7FB7A4")
jar(ImageDraw.Draw(full), 1.2)
full.save("assets/icon.png")

fg = Image.new("RGBA", (S, S), (0, 0, 0, 0))
jar(ImageDraw.Draw(fg), 0.9)
fg.save("assets/icon_fg.png")