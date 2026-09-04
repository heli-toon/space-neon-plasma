# Installing Space Neon Orange

Two ways to install: **remote** (from GitHub, one line) or **local** (you already have the folder). Both end with the same result.

---

## Option A — Remote install (from GitHub)

Use this once the repo is pushed to your own GitHub account.

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/heli-toon/space-neon-plasma/main/install.sh)"
```

This downloads and runs `install.sh` directly — it does **not** clone the repo first, so it only works if `install.sh` itself pulls files from other raw GitHub URLs. Since our `install.sh` copies files from a local `$SCRIPT_DIR`, the more reliable remote flow is:

```bash
git clone https://github.com/heli-toon/space-neon-plasma.git
cd space-neon-plasma
chmod +x install.sh
./install.sh
```

---

## Option B — Local install (you already have the folder, e.g. this zip)

1. **Unzip and enter the folder:**
   ```bash
   unzip space-neon-plasma.zip
   cd space-neon-plasma
   ```

2. **Make the scripts executable** (the zip preserves this, but if it doesn't survive a transfer):
   ```bash
   chmod +x install.sh deploy.sh
   ```

3. **Run the installer:**
   ```bash
   ./install.sh
   ```
   or, if you just want to (re)apply the theme without any of the install-script framing/output:
   ```bash
   ./deploy.sh
   ```
   Both scripts do the same core work — `deploy.sh` is the quieter, local-only version meant for repeat use on a machine you already set up once.

---

## What the script actually does

| Step | Action |
|---|---|
| 1 | Creates `~/.local/share/color-schemes`, `~/.config/gtk-3.0`, `~/.config/gtk-4.0`, `~/.local/share/konsole`, `~/.local/share/plasma/desktoptheme` if missing |
| 2 | Copies `SpaceNeonOrange.colors`, `gtk.css` (x2), the Konsole scheme, and the Plasma theme metadata into those folders |
| 3 | Runs `kwriteconfig6`/`kwriteconfig5` to set the KDE color scheme to `SpaceNeonOrange` |
| 4 | Reloads KWin via `qdbus6`/`qdbus` so window borders update without a logout |

Nothing is installed system-wide — everything lands in your `$HOME`, so no `sudo` is required.

---

## Applying the rest manually

The script sets the **color scheme** automatically, but a few pieces are opt-in through the GUI:

1. **Confirm the color scheme:**
   System Settings → **Appearance → Colors** → select **Space Neon Orange**. (Should already be selected after the script runs — this is just to verify.)

2. **Pick up the GTK CSS:**
   Restart GTK apps (Firefox, GIMP, file managers, etc.). GTK apps read `gtk.css` on launch, not live.

3. **Enable the Konsole theme:**
   Konsole → **Settings → Edit Current Profile → Appearance** → select **Space Neon Orange** as the color scheme.

4. **Go ultra-minimal (optional):**
   - Right-click the Plasma panel → **Enter Edit Mode** → set panel to **Auto-Hide**, remove default widgets you don't need.
   - Use `Alt+Space` for KRunner instead of a full app menu, or install **Rofi** for a leaner launcher.

---

## Troubleshooting

- **`kwriteconfig5: command not found` and `kwriteconfig6: command not found`**
  You're likely not on a KDE Plasma session, or the KDE CLI utils package isn't installed. On Debian/Ubuntu: `sudo apt install kde-cli-tools`. The color scheme file is still copied even if this step is skipped — you can select it manually in System Settings.

- **Colors don't change after running the script**
  Log out and back in, or run `qdbus6 org.kde.KWin /KWin org.kde.KWin.reconfigure` (or the `qdbus` equivalent) manually.

- **GTK apps still look default**
  Confirm `~/.config/gtk-3.0/gtk.css` and `~/.config/gtk-4.0/gtk.css` exist and aren't being overridden by a GTK theme (e.g. Breeze-GTK) that sets its own rules with higher specificity. You may need to also set the GTK theme itself to something minimal in System Settings → **Appearance → Application Style → GNOME/GTK Application Style**.

- **Konsole scheme not showing up in the list**
  Konsole reads schemes on startup — fully quit and relaunch Konsole (not just open a new tab/window).

## Uninstalling

There's no uninstaller — remove the copied files manually if you want to revert:

```bash
rm ~/.local/share/color-schemes/SpaceNeonOrange.colors
rm ~/.local/share/konsole/SpaceNeonOrange.colorscheme
rm -rf ~/.local/share/plasma/desktoptheme/SpaceNeonMinimal
```

Then reset your GTK CSS (`~/.config/gtk-3.0/gtk.css`, `~/.config/gtk-4.0/gtk.css`) and pick a different color scheme in System Settings.
