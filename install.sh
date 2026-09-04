#!/usr/bin/env bash
# Space Neon Orange - Automated KDE Plasma Installer

set -e

# Color definitions for output
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
NC='\033[0m' # No Color

echo -e "${ORANGE}========================================${NC}"
echo -e "${ORANGE} Installing Space Neon Orange Theme... ${NC}"
echo -e "${ORANGE}========================================${NC}"

# Define target directories
COLOR_DIR="$HOME/.local/share/color-schemes"
GTK3_DIR="$HOME/.config/gtk-3.0"
GTK4_DIR="$HOME/.config/gtk-4.0"
KONSOLE_DIR="$HOME/.local/share/konsole"
PLASMA_THEME_DIR="$HOME/.local/share/plasma/desktoptheme"
WALLPAPER_DIR="$HOME/.local/share/wallpapers/SpaceNeonOrange/contents/images"
FONT_VALUE="JetBrainsMono Nerd Font Mono,10,-1,5,50,0,0,0,0,0"

# Create directories if they don't exist
mkdir -p "$COLOR_DIR" "$GTK3_DIR" "$GTK4_DIR" "$KONSOLE_DIR" "$PLASMA_THEME_DIR" "$WALLPAPER_DIR"

# Get current script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Copy configurations
echo -e "${GREEN}[+] Copying color schemes and GTK overrides...${NC}"
cp -f "$SCRIPT_DIR/color-schemes/SpaceNeonOrange.colors" "$COLOR_DIR/"
cp -f "$SCRIPT_DIR/gtk/gtk-3.0/gtk.css" "$GTK3_DIR/"
cp -f "$SCRIPT_DIR/gtk/gtk-4.0/gtk.css" "$GTK4_DIR/"
[ -f "$SCRIPT_DIR/konsole/SpaceNeonOrange.colorscheme" ] && cp -f "$SCRIPT_DIR/konsole/SpaceNeonOrange.colorscheme" "$KONSOLE_DIR/"
[ -d "$SCRIPT_DIR/plasma/desktoptheme/SpaceNeonMinimal" ] && cp -rf "$SCRIPT_DIR/plasma/desktoptheme/SpaceNeonMinimal" "$PLASMA_THEME_DIR/"
[ -f "$SCRIPT_DIR/wallpapers/space-neon-orange-nebula.jpg" ] && cp -f "$SCRIPT_DIR/wallpapers/space-neon-orange-nebula.jpg" "$WALLPAPER_DIR/"

# Apply KDE Color Scheme programmatically (supports Plasma 5 & Plasma 6)
echo -e "${GREEN}[+] Applying Plasma Color Scheme...${NC}"
if command -v kwriteconfig6 &> /dev/null; then
    kwriteconfig6 --file kdeglobals --group General --key ColorScheme "SpaceNeonOrange"
    kwriteconfig6 --file kdeglobals --group General --key AccentColor "255,107,0"
    kwriteconfig6 --file kdeglobals --group General --key font "$FONT_VALUE"
    kwriteconfig6 --file kdeglobals --group General --key fixed "${FONT_VALUE/,10,/,10,}"
elif command -v kwriteconfig5 &> /dev/null; then
    kwriteconfig5 --file kdeglobals --group General --key ColorScheme "SpaceNeonOrange"
    kwriteconfig5 --file kdeglobals --group General --key AccentColor "255,107,0"
    kwriteconfig5 --file kdeglobals --group General --key font "$FONT_VALUE"
    kwriteconfig5 --file kdeglobals --group General --key fixed "${FONT_VALUE/,10,/,10,}"
else
    echo "[!] kwriteconfig5/6 not found — color scheme file was copied but not auto-applied."
fi

# Zafiro is a pure monochrome icon pack.  It is intentionally only selected
# when already installed; the theme never replaces the user's icon files.
if command -v kwriteconfig6 &> /dev/null; then
    kwriteconfig6 --file kdeglobals --group Icons --key Theme "Zafiro-icons-Dark"
elif command -v kwriteconfig5 &> /dev/null; then
    kwriteconfig5 --file kdeglobals --group Icons --key Theme "Zafiro-icons-Dark"
fi

if command -v plasma-apply-wallpaperimage &> /dev/null && [ -f "$WALLPAPER_DIR/space-neon-orange-nebula.jpg" ]; then
    plasma-apply-wallpaperimage "$WALLPAPER_DIR/space-neon-orange-nebula.jpg" || true
fi

# Reload KWin to apply instantly
echo -e "${GREEN}[+] Reloading window manager...${NC}"
if command -v qdbus6 &> /dev/null; then
    qdbus6 org.kde.KWin /KWin org.kde.KWin.reconfigure 2>/dev/null || true
elif command -v qdbus &> /dev/null; then
    qdbus org.kde.KWin /KWin org.kde.KWin.reconfigure 2>/dev/null || true
fi

echo -e "${ORANGE}========================================${NC}"
echo -e "${GREEN} Success! Theme installed and applied. ${NC}"
echo -e "${ORANGE}========================================${NC}"
echo "Note: some apps (GTK, Konsole profile selection) may need a restart to pick up the new theme."
