# Space Neon Orange — KDE Plasma Theme

An ultra-minimal, high-contrast dark theme for KDE Plasma designed for performance and aesthetic clarity. Deep space blacks (`#0A0A0B`), grayscale hierarchy, and vibrant neon orange (`#FF6B00`) accents.

![Preview](preview.png)

## Features

- **Ultra-low resource overhead** — pure GTK and KDE color definitions, no heavy third-party engines.
- **Deep space palette** — pitch black base, dark grays for UI elements, white for text legibility.
- **Neon orange accents** — precise highlight colors for borders, buttons, and selections.
- **Orange-only interaction states** — hover, selected items, task-manager buttons, radio controls, and scrollbars no longer fall back to blue.
- **Monochrome icons** — Zafiro Icons (dark) is selected when installed; it keeps the desktop iconography grayscale.
- **JetBrainsMono Nerd Font Mono** — applied to Plasma and GTK.
- **Darker panel palette** — the panel and button surfaces sit below the window background for a more deliberate contrast.
- **Multi-version support** — works on KDE Plasma 5 and Plasma 6.
- **Matching Konsole theme** included for a consistent terminal look.

## One-Line Quick Install

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/heli-toon/space-neon-plasma/main/install.sh)"
```

> Replace `heli-toon` with your GitHub username once you've pushed the repo.

## Manual Installation

```bash
git clone https://github.com/heli-toon/space-neon-plasma.git
cd space-neon-plasma
chmod +x install.sh
./install.sh
```

## After Installing

1. Open **System Settings → Appearance → Colors** and select **Space Neon Orange**.
2. Restart GTK apps (Firefox, GIMP, etc.) to pick up the new `gtk.css`.
3. In Konsole, go to **Settings → Edit Current Profile → Appearance** and select **Space Neon Orange**.
4. Install **Zafiro Icons** (dark) before applying the theme. The deployer selects `Zafiro-icons-Dark`; if your package uses a different name, choose its dark variant in **System Settings → Icons**.
5. Install **JetBrainsMono Nerd Font Mono** (for example from the Nerd Fonts package) before applying the theme.
6. The included 4K orange-nebula wallpaper is applied automatically when `plasma-apply-wallpaperimage` is available.

## Included Components

| Component | Path |
|---|---|
| KDE color scheme | `color-schemes/SpaceNeonOrange.colors` |
| GTK 3/4 CSS overrides | `gtk/gtk-3.0/gtk.css`, `gtk/gtk-4.0/gtk.css` |
| Konsole theme | `konsole/SpaceNeonOrange.colorscheme` |
| Plasma desktop theme metadata | `plasma/desktoptheme/SpaceNeonMinimal/metadata.desktop` |
| 4K matching wallpaper | `wallpapers/space-neon-orange-nebula.jpg` |

## Repository Structure

```text
space-neon-plasma/
├── install.sh
├── README.md
├── color-schemes/
│   └── SpaceNeonOrange.colors
├── gtk/
│   ├── gtk-3.0/gtk.css
│   └── gtk-4.0/gtk.css
├── plasma/
│   └── desktoptheme/SpaceNeonMinimal/metadata.desktop
└── konsole/
    └── SpaceNeonOrange.colorscheme
```

## Publishing to GitHub

```bash
git init
git add .
git commit -m "Initial commit: Space Neon Orange KDE theme"
git branch -M main
git remote add origin https://github.com/heli-toon/space-neon-plasma.git
git push -u origin main
```

Don't forget to drop a `preview.png` screenshot of your desktop into the repo root before pushing — the README links to it.

## License

MIT
